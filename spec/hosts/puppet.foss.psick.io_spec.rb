require 'spec_helper'

os_facts = @os_facts

describe 'puppet.foss.psick.io' do
  test_on = {
    :supported_os => [
      { 'operatingsystem' => 'RedHat' },
    ],
  }
  on_supported_os(test_on).each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        OS_FACTS.merge(facts)
      end
      let(:environment) { 'production' }
      let(:trusted_facts) { {
        'env' => 'lab',
        'zone' => 'lab',
        'datacenter' => 'lab',
        'role' => 'puppet'
      } }
      it { is_expected.to compile.with_all_deps }
    end
  end
end

