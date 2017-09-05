require 'spec_helper'
require 'yaml'
facts_yaml = File.dirname(__FILE__) + '/../../fixtures/facts/spec.yaml'
facts = YAML.load_file(facts_yaml)

describe 'profile::base::linux', type: :class do
  let(:pre_condition) { "Exec { path => '/bin:/usr/bin:/sbin:/usr/sbin:/usr/local/bin:/usr/local/sbin' } ; include '::profile::settings'" }
  let(:facts) { facts }

  on_supported_os.select { |_, f| f[:os]['name'] == 'RedHat' }.each do |os, f|
    context "on #{os}" do
      let(:facts) do
        f.merge(super())
      end

      it { is_expected.to compile.with_all_deps }

      describe 'with hieradata defaults' do
        it { is_expected.to compile.with_all_deps }
        it { is_expected.to contain_class('profile::mail::postfix') }
        it { is_expected.to contain_class('profile::puppet::peclient') }
        it { is_expected.to contain_class('profile::ssh::openssh') }
        it { is_expected.to contain_class('profile::network') }
        it { is_expected.to contain_class('profile::monitor') }
        it { is_expected.to contain_class('profile::logs::rsyslog') }
        it { is_expected.to contain_class('profile::backup') }
        it { is_expected.to contain_class('profile::time') }
        it { is_expected.to contain_class('profile::sysctl') }
        it { is_expected.to contain_class('profile::multipath') }
        it { is_expected.to contain_class('profile::hardening') }
        it { is_expected.to contain_class('profile::motd') }
        it { is_expected.to contain_class('profile::hosts::resource') }
        it { is_expected.to contain_class('profile::update') }
        it { is_expected.to contain_class('profile::hardware') }
        it { is_expected.to contain_class('profile::sudo') }
      end

      describe 'with manage => false' do
        let(:params) do
          { manage: false }
        end

        it { is_expected.to have_class_count(2) }
        it { is_expected.to have_resource_count(0) }
      end
    end
  end
end
