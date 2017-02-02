require 'spec_helper'
require 'yaml'
facts_yaml = File.dirname(__FILE__) + '/../fixtures/facts/spec.yaml'
facts = YAML.load_file(facts_yaml)

describe 'profile::base::linux', :type => :class do
  let(:facts) { facts } 
  on_supported_os.select { |_, f| f[:os]['name'] == 'RedHat' }.each do |os, f|
    context "on #{os}" do
      let(:facts) do
        f.merge(super())
      end
  
      it { is_expected.to compile.with_all_deps }
      it { should contain_class('profile::pre') }
      it { should contain_class('profile::settings') }

      describe 'with hieradata defaults' do
        it { is_expected.to compile.with_all_deps }
        it { should contain_class('profile::pre') }
        it { should contain_class('profile::mail::postfix') }
        it { should contain_class('profile::puppet::peclient') }
        it { should contain_class('profile::ssh::openssh') }
        it { should contain_class('profile::network') }
        it { should contain_class('profile::monitor') }
        it { should contain_class('profile::logs::rsyslog') }
        it { should contain_class('profile::backup') }
        it { should contain_class('profile::time::ntp') }
        it { should contain_class('profile::sysctl') }
        it { should contain_class('profile::multipath') }
        it { should contain_class('profile::hardening') }
        it { should contain_class('profile::motd') }
        it { should contain_class('profile::hosts::file') }
        it { should contain_class('profile::sar') }
        it { should contain_class('profile::update') }
        it { should contain_class('profile::hardware') }
        it { should contain_class('profile::packages') }
        it { should contain_class('profile::sudo') }
      end
    end
  end
end
