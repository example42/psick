# This deployment policy plan will perform a code deployment of an environment that
# matches the source branch for a commit. It will then run puppet agent on a
# list customisable nodes using the relevant environment.
# Based on https://github.com/puppetlabs/puppetlabs-cd4pe_deployments/blob/master/plans/feature_branch.pp
#
# @summary This deployment policy plan will perform a code deployment of an environment that
#          matches the source branch for a commit.
#
plan deployments::feature_test (
  Integer $max_node_failure             = 0,
  Boolean $noop                         = false,
  Boolean $fail_if_no_nodes             = true,
  Array  $nodes                         = [],
  Optional[String] $nodes_puppetdbquery = undef,
  Optional[String] $nodes_groupid       = undef,
) {
  $repo_type = system::env('REPO_TYPE')
  $src_branch_name = system::env('BRANCH')
  $environment_prefix = system::env('ENVIRONMENT_PREFIX')

  # Nodes from Console
  $get_node_group_result = cd4pe_deployments::get_node_group($node_groupid)
  if $get_node_group_result['error'] =~ NotUndef {
    $nodes_console = []
  } else {
    $nodes_console = $get_node_group_result['result']['nodes']
  }

  # Nodes from PuppetDB
  $puppetdb_query = "nodes { ${$nodes_puppetdbquery} }"
  $hosts_result = puppetdb_query($puppetdb_query)
  $nodes_puppetdb = $hosts_result.map |$node| {
    $result = $node['certname']
  }

  # All nodes list
  $all_nodes = $nodes + $nodes_puppetdb + $nodes_console


  if($repo_type == 'MODULE') {
    $feature_branch_name = $src_branch_name
    $base_branch_sha = system::env('CONTROL_REPO_BASE_FEATURE_BRANCH_HEAD')
    # Create a feature branch on the control repo based on the branch that was selected when the Deployment was added
    # to the pipeline. Make the branch long lived.
    $create_branch_result = cd4pe_deployments::create_git_branch('CONTROL_REPO', $feature_branch_name, $base_branch_sha, false)
    if $create_branch_result['error'] != undef {
      fail_plan($create_branch_result['error']['message'], $create_branch_result['error']['code'])
    }
  }

  # If an environment prefix was selected on the Deployment then calculate the target environment name with this prefix
  $target_environment = $environment_prefix ? {
    '' => $src_branch_name,
    String[1] => "${environment_prefix}${src_branch_name}",
  }

  # Deploy the target environment associated with the feature branch
  $deploy_code_result = cd4pe_deployments::deploy_code($target_environment)
  $validate_code_deploy_result = cd4pe_deployments::validate_code_deploy_status($deploy_code_result)
  if ($validate_code_deploy_result['error'] != undef) {
    fail_plan($validate_code_deploy_result['error']['message'], $validate_code_deploy_result['error']['code'] )
  }

  # Run Puppet agent using the feature branch environment
  if ($all_nodes != []) {
    $msg = "No nodes found in node group ${get_node_group_result['result']['name']} or in pdbquery"
    if ($fail_if_no_nodes) {
      fail_plan("${msg}. Set fail_if_no_nodes parameter to false to prevent this deployment failure in the future")
    } else {
      return "${msg}. Deployed directly to target environment and ending deployment."
    }
  }
  # Perform a Puppet run on all nodes in the environment
  $puppet_run_result = cd4pe_deployments::run_puppet($all_nodes, $noop, $target_environment)
  if $puppet_run_result['error'] =~ NotUndef {
    fail_plan($puppet_run_result['error']['message'], $puppet_run_result['error']['code'])
  }

  if $puppet_run_result['result']['nodeStates'] =~ NotUndef {
    if $puppet_run_result['result']['nodeStates']['failedNodes'] =~ NotUndef {
      $node_failure_count = $puppet_run_result['result']['nodeStates']['failedNodes']
      # Fail the deployment if the number of failures exceeds the threshold

      if ($node_failure_count > $max_node_failure) {
        fail_plan("Max node failure reached. ${node_failure_count} nodes failed.")
      }
    }
  }
}

