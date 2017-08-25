require 'spec_helper'
require 'yaml'
facts_yaml = File.dirname(__FILE__) + '/../fixtures/facts/spec.yaml'
facts = YAML.load_file(facts_yaml)

describe 'profile::settings', :type => :class do
  let(:facts) { facts } 
  on_supported_os.each do |os, f|
    context "on #{os}" do
      let(:facts) do
        f.merge(super())
      end
      it { is_expected.to compile.with_all_deps }
    end
  end
end
