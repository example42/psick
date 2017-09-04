require 'spec_helper'
require 'yaml'
facts_yaml = File.dirname(__FILE__) + '/../../fixtures/facts/spec.yaml'
facts = YAML.load_file(facts_yaml)

describe 'profile::pre::linux', :type => :class do
  let(:facts) { facts } 
  on_supported_os.select { |_, f| f[:os]['name'] == 'Centos' }.each do |os, f|
    context "on #{os}" do
      let(:facts) do
        f.merge(super())
      end
      describe 'with hieradata defaults' do
        it { is_expected.to compile.with_all_deps }
#        it { should contain_class('profile::repo::generic') }
      end
    end
  end
  on_supported_os.select { |_, f| f[:os]['name'] == 'Ubuntu' }.each do |os, f|
    context "on #{os}" do
      let(:facts) do
        f.merge(super())
      end
      describe 'with hieradata defaults' do
        it { is_expected.to compile.with_all_deps }
#        it { should contain_class('profile::pre::ubuntu') }
      end
    end
  end
end
