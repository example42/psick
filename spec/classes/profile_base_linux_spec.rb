require 'spec_helper'
require 'yaml'
facts_yaml = File.dirname(__FILE__) + '/../spec.yaml'
facts = YAML.load_file(facts_yaml)

describe 'profile::base::linux', :type => :class do
  let(:facts) { facts } 
  let(:pre_condition) {
    "Exec { path => '/bin:/usr/bin:/sbin:/usr/sbin:/usr/local/bin:/usr/local/sbin', }
     contain ::profile::pre
     contain '::profile::settings'
     $kernel_down=downcase($::kernel)
     contain \"::profile::base::${kernel_down}\"
    "
  }
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
        it { should contain_class('puppet') }
        it { should contain_class('profile::ssh::openssh') }
        it { should contain_class('profile::monitor') }
        it { should contain_class('profile::logs::rsyslog') }
        it { should contain_class('profile::time') }
        it { should contain_class('profile::sysctl') }
        it { should contain_class('profile::motd') }
        it { should contain_class('profile::sudo') }
        it { should contain_class('profile::users::static') }
        it { should contain_class('profile::dns::resolver') }
        it { should contain_class('profile::hostname') }
        it { should contain_class('profile::hosts::resource') }
        it { should contain_class('profile::profile') }
      end
    end
  end
end

