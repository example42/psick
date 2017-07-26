require 'spec_helper'

os_facts = @os_facts

describe 'build.lab.psick.io' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        OS_FACTS.merge(facts)
      end
      let(:environment) { 'production' }
      let(:trusted_facts) { {
        'env' => 'lab',
        'zone' => 'lab',
        'datacenter' => 'lab',
        'role' => 'build'
      } }
      it { is_expected.to compile.with_all_deps }
    end
  end
end

