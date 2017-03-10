require 'spec_helper'
require 'yaml'
facts_yaml = File.dirname(__FILE__) + '/../../fixtures/facts/spec.yaml'
facts = YAML.load_file(facts_yaml)

describe 'profile::users::static', :type => :class do
  let(:facts) { facts }

  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let (:facts) do
        facts.merge(super())
      end

      # it { pp catalogue.resources }  # Uncomment to dump the catalogue

      it { is_expected.to compile.with_all_deps }
      it { is_expected.to contain_class('profile::users::static') }

      context 'with defaults values' do
        it {is_expected.not_to contain_user('root')}
        it {is_expected.to have_user_resource_count(0)}
        it {is_expected.to have_tools__user__managed_resource_count(0)}
      end

      context 'with rootpw: set' do
        let :params do
          {
              :rootpw => 'test_rootpw'
          }
        end
        it {is_expected.to contain_user('root').with(
            'password' => 'test_rootpw'
        ) }
      end
    end
  end
end


