require 'spec_helper'

@os_facts

describe 'puppet.lab.psick.io' do
  test_on = {
    :supported_os => [
      { 'operatingsystem' => 'RedHat' }
    ]
  }
  on_supported_os(test_on).each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        OS_FACTS.merge(facts).merge({ :servername => 'puppet.example.com' })
      end
      let(:environment) { 'production' }
      let(:trusted_facts) do
        {
          'env' => 'lab',
          'zone' => 'lab',
          'datacenter' => 'lab',
          'role' => 'puppet'
        }
      end
      it { is_expected.to compile.with_all_deps }
    end
  end
end
