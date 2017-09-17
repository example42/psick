require 'spec_helper'
require 'yaml'
facts_yaml = File.dirname(__FILE__) + '/../../fixtures/facts/spec.yaml'
facts = YAML.load_file(facts_yaml)

describe 'profile::base::linux', type: :class do
  let(:pre_condition) { "Exec { path => '/bin:/usr/bin:/sbin:/usr/sbin:/usr/local/bin:/usr/local/sbin' } ; include '::psick::settings'" }
  let(:facts) { facts }

  on_supported_os.select { |_, f| f[:os]['name'] == 'RedHat' }.each do |os, f|
    context "on #{os}" do
      let(:facts) do
        f.merge(super())
      end

      it { is_expected.to compile.with_all_deps }

      describe 'with hieradata defaults' do
        it { is_expected.to compile.with_all_deps }
        it { is_expected.to contain_class('psick::mail::postfix') }
        it { is_expected.to contain_class('puppet') }
        it { is_expected.to contain_class('psick::ssh::openssh') }
        it { is_expected.to contain_class('psick::users::static') }
        it { is_expected.to contain_class('psick::sudo') }
        it { is_expected.to contain_class('psick::monitor') }
        it { is_expected.to contain_class('psick::logs::rsyslog') }
        it { is_expected.to contain_class('psick::time') }
        it { is_expected.to contain_class('psick::sysctl') }
        it { is_expected.to contain_class('psick::dns::resolver') }
        it { is_expected.to contain_class('psick::hostname') }
        it { is_expected.to contain_class('psick::hosts::resource') }
        it { is_expected.to contain_class('psick::update') }
        it { is_expected.to contain_class('psick::motd') }
        it { is_expected.to contain_class('psick::psick') }
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
