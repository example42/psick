require 'spec_helper'

@os_facts
base_resources = YAML.load_file(File.dirname(__FILE__) + '/../resources/base_resources.yaml')
tpinstalls = base_resources['tp__install']

describe 'sensu.lab.psick.io' do
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
          'role' => 'sensu'
        }
      end
      it { is_expected.to compile.with_all_deps }
      tpinstalls.each do | tpinstall |
        it { is_expected.to contain_tp__install(tpinstall).with_ensure('present') }
      end
    end
  end
end
