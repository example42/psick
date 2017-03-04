require 'spec_helper'
require 'yaml'
facts_yaml = File.dirname(__FILE__) + '/../fixtures/facts/spec.yaml'
facts = YAML.load_file(facts_yaml)

describe 'profile::ssh::openssh', :type => :class do
  let(:facts) { facts }

  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let (:facts) do
        facts.merge(super())
      end
      it { pp catalogue.resources }

      describe 'with hieradata defaults' do
        it { is_expected.to compile.with_all_deps }
        it { is_expected.not_to contain_tp__conf('openssh') }
        it { is_expected.to contain_tp__dir('openssh').with(
            'ensure' => 'present',
            'source' => nil
        ) }
        it { is_expected.to contain_tp__install('openssh').with(
            'ensure' => 'present'
        ) }
       end
    end
  end
end

