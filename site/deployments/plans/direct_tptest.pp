# Deployment policy based on default cd4pe_deployments::direct policy with
# added tp::test task to validate the system status
#
# This deployment policy will deploy a source commit to the Puppet environment
# associated with the Deployment's configured Node Group. It will then run Puppet
# on all nodes in the environemnt.
#
# @summary This deployment policy will deploy a source commit to the Puppet environment
#          associated with the Deployment's configured node group and then run Puppet.
#
# @param max_node_failure
#     The number of allowed failed Puppet runs that can occur before the Deployment will fail
# @param noop
#     Indicates if the Puppet run should be a noop.
plan deployments::direct_tptest (
  Integer $max_node_failure = 0,
  Boolean $noop = false,
) {
  $repo_target_branch = system::env('REPO_TARGET_BRANCH')
  $source_commit = system::env('COMMIT')
  $target_node_group_id = system::env('NODE_GROUP_ID')

  $get_node_group_result = cd4pe_deployments::get_node_group($target_node_group_id)
  if $get_node_group_result['error'] =~ NotUndef {
    fail_plan($get_node_group_result['error']['message'], $get_node_group_result['error']['code'])
  }
  $target_environment = $get_node_group_result['result']['environment']
  # Wait for approval if the environment is protected
  cd4pe_deployments::wait_for_approval($target_environment) |String $url| { }

  # Update the branch associated with the target environment to the source commit.
  $update_git_ref_result = cd4pe_deployments::update_git_branch_ref(
    'CONTROL_REPO',
    $repo_target_branch,
    $source_commit
  )
  if $update_git_ref_result['error'] =~ NotUndef {
    fail_plan($update_git_ref_result['error']['message'], $update_git_ref_result['error']['code'])
  }
  # Deploy the code associated with the Node Group's environment if the Deployment is approved
  $deploy_code_result = cd4pe_deployments::deploy_code($target_environment)
  $validate_code_deploy_result = cd4pe_deployments::validate_code_deploy_status($deploy_code_result)
  if ($validate_code_deploy_result['error'] =~ NotUndef) {
    fail_plan($validate_code_deploy_result['error']['message'], $validate_code_deploy_result['error']['code'])
  }

  $nodes = $get_node_group_result['result']['nodes']
  if $nodes =~ Undef {
    fail_plan("No nodes found in target node group ${get_node_group_result['result']['name']}")
  }
  # Perform a Puppet run on all nodes in the environment
  $puppet_run_result = cd4pe_deployments::run_puppet($nodes, $noop)
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

  $tptest_options = {
    '_catch_errors' => true,
  }
  $tptest_result = run_task('tp::test', $nodes, $tptest_options)
  unless $tptest_result.ok {
    fail_plan("tp::test has failed on these targets ${test_result.error_targets.names} nodes failed.")
  }

}
