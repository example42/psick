require 'spec_helper'

@os_facts

describe 'jenkins.lab.psick.io' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        OS_FACTS.merge(facts)
      end
      let(:environment) { 'production' }
      let(:trusted_facts) do
        {
          'env' => 'lab',
          'zone' => 'lab',
          'datacenter' => 'lab',
          'role' => 'jenkins'
        }
      end
      it { is_expected.to compile.with_all_deps }
      it { is_expected.to contain_service('jenkins').with('ensure' => 'running') }
    end
  end
end
