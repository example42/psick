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
        describe "Root user is not created"
        it { is_expected.not_to contain_user('root') }

        describe 'No users are created'
        it { is_expected.to have_user_resource_count(0) }

        describe 'Unmanaged users are not purged'
        it { is_expected.to have_tools__user__managed_resource_count(0) }
      end

      context 'with rootpw: set' do
        let(:params) { {:rootpw => 'test_rootpw'} }

        describe 'Root user is created'
        it { is_expected.to contain_user('root').with(
            'password' => 'test_rootpw'
        ) }
      end

      context 'with :delete_unmanaged set to true' do
        # it { pp catalogue.resources }  # Uncomment to dump the catalogue
        let(:params) { {:delete_unmanaged => true} }

        describe "Non-system users are purged"
        it { is_expected.to contain_resources('user').with(
            'purge' => true,
            'unless_system_user' => true
        ) }
      end

      context 'with :users defined' do
        let(:params) { {
            :users => {
                'test_user1' => {
                    "name" => 'user1'
                },
                'test_user2' => {
                    "name" => 'user2'
                }
        }}
        }
        describe
        it { is_expected.to have_user_resource_count(2) }
      end

      context 'with :managed_users defined' do
        it { pp catalogue.resources } # Uncomment to dump the catalogue
        let(:params) { {
            :managed_users => {
                'testmanaged_user1' => {
                    "name" => 'managed_user1'
                },
                'test_user2' => {
                    "name" => 'managed_user2'
                }
            }}
        }
        describe
        it { is_expected.to have_tools__user__managed_resource_count(2)  }
      end
    end
  end
end


