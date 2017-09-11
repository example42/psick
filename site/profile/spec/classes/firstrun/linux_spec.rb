require 'spec_helper'
require 'yaml'
facts_yaml = File.dirname(__FILE__) + '/../../fixtures/facts/spec.yaml'
facts = YAML.load_file(facts_yaml)

describe 'profile::firstrun::linux', type: :class do
  let(:pre_condition) { "Exec { path => '/bin:/usr/bin:/sbin:/usr/sbin:/usr/local/bin:/usr/local/sbin' } ; include '::profile::settings'" }
  let(:facts) { facts.merge( firstrun_fact: 'firstrun_done' )  }

  on_supported_os.select { |_, f| f[:os]['name'] == 'RedHat' }.each do |os, f|
    context "on #{os}" do
      let(:facts) do
        f.merge(super())
      end

      it { is_expected.to compile.with_all_deps }

      describe 'with hieradata defaults' do
        it { is_expected.to compile.with_all_deps }
        it { is_expected.to contain_reboot('Rebooting') }
        it { is_expected.to contain_tools__puppet__set_external_fact('firstrun_done').with('notify' => 'Reboot[Rebooting]', 'value' => 'done') }
      end

      describe 'with custom _class params' do
        let(:params) do {
          hostname_class: 'profile::hostname',
          repo_class: 'profile::repo::generic',
          proxy_class: 'profile::proxy',
          packages_class: 'profile::aws::sdk'
        } end
        it { is_expected.to compile.with_all_deps }
        it { is_expected.to contain_class('profile::hostname') }
        it { is_expected.to contain_class('profile::repo::generic') }
        it { is_expected.to contain_class('profile::proxy') }
        it { is_expected.to contain_class('profile::aws::sdk') }
      end

      describe 'with custom reboot params' do
        let(:params) do {
          reboot_apply: 'immediately',
          reboot_message: 'test',
          reboot_when: 'refreshed',
          reboot_timeout: 30,
          reboot_name: 'test reboot'
        } end

        it { is_expected.to contain_tools__puppet__set_external_fact('firstrun_done').with('notify' => 'Reboot[test reboot]', 'value' => 'done') }
        it { is_expected.to contain_reboot('test reboot').only_with('apply' => 'immediately', 'message' => 'test', 'when' => 'refreshed', 'timeout' => 30) }
      end
  
      describe 'with reboot => false' do
        let(:params) { { reboot: false } }

        it { is_expected.not_to contain_reboot('Rebooting') }
        it { is_expected.to contain_tools__puppet__set_external_fact('firstrun_done').without(['notify']) }
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
