require 'spec_helper'
require 'yaml'
facts_yaml = File.dirname(__FILE__) + '/../../fixtures/facts/spec.yaml'
facts = YAML.load_file(facts_yaml)

describe 'profile::pre::darwin', type: :class do
  let(:pre_condition) { "Exec { path => '/bin:/usr/bin:/sbin:/usr/sbin:/usr/local/bin:/usr/local/sbin' }" }
  let(:facts) { facts }

  on_supported_os.select { |_, f| f[:os]['name'] == 'RedHat' }.each do |os, f|
    context "on #{os}" do
      let(:facts) do
        f.merge(super())
      end

      it { is_expected.to compile.with_all_deps }

      describe 'with default settings' do
        it { is_expected.to have_class_count(1) }
        it { is_expected.to have_resource_count(0) }
      end

      describe 'with manage = false' do
        let(:params) do
          { manage: false }
        end

        it { is_expected.to have_class_count(1) }
        it { is_expected.to have_resource_count(0) }
      end
    end
  end
end
