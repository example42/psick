require 'spec_helper'
require 'yaml'
facts_yaml = File.dirname(__FILE__) + '/../fixtures/facts/spec.yaml'
facts = YAML.load_file(facts_yaml)

describe 'profile::ssh::openssh', :type => :class do
  let(:facts) { facts }

  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let (:facts) do
        facts.merge(super())
      end

      # it { pp catalogue.resources }  # Uncomment to dump the catalogue

      it { is_expected.to compile.with_all_deps }
      it { is_expected.to contain_class('profile::ssh::openssh') }

      context 'with defaults values' do
        it { is_expected.not_to contain_tp__conf('openssh') }
        it { is_expected.to contain_tp__dir('openssh').with(
            'ensure' => 'present',
            'source' => nil
        ) }
        it { is_expected.to contain_tp__install('openssh').with(
            'ensure' => 'present'
        ) }
      end

      context 'with :ensure parameter specified' do
        let :default_params do
          {
              :config_dir_source => 'test_config_dir_source',
              :config_file_template => '/dev/null',
          }
        end

        describe 'with parameter: ensure parameter set to absent' do
          let :params do
            default_params.merge({:ensure => 'absent'})
          end

          it { is_expected.to contain_tp__install('openssh').with(
              'ensure' => 'absent'
          ) }

          it { is_expected.to contain_tp__dir('openssh').with(
              'ensure' => 'absent',
              'source' => 'test_config_dir_source'
          ) }

          it { is_expected.to contain_tp__conf('openssh').with(
              'ensure' => 'absent',
              'template' => '/dev/null',
              'options_hash' => {'option1' => 'option1_value',
                                 'option2' => 'option2_value'}
          ) }
        end

        describe 'with parameter :ensure set to present' do
          let :params do
            default_params.merge({:ensure => 'present'})
          end

          it { is_expected.to contain_tp__install('openssh').with(
              'ensure' => 'present'
          ) }

          it { is_expected.to contain_tp__conf('openssh').with(
              'ensure' => 'present',
              'template' => '/dev/null',
              'options_hash' => {'option1' => 'option1_value',
                                 'option2' => 'option2_value'}
          ) }

          it { is_expected.to contain_tp__dir('openssh').with(
              'ensure' => 'present',
              'source' => 'test_config_dir_source'
          ) }
        end

      end

      context 'with invalid parameter values' do
        describe 'with :ensure not equal to "present" or "absent"' do
          let :params do
            {
                :ensure => 'invalid'
            }
          end
          it { is_expected.to raise_error(Puppet::PreformattedError, /^Evaluation Error.* got \'invalid\'.*/) }
        end

        describe 'with :config_dir_source set to empty string' do
          let :params do
            {
                :ensure             => 'present',
                :config_dir_source  => ''
            }
          end
          it { is_expected.to raise_error(Puppet::PreformattedError, /^Evaluation Error:.*/) }
        end

        describe 'with :config_dir_source not a string' do
          let :params do
            {
                :ensure             => 'present',
                :config_dir_source  => 1
            }
          end
          it { is_expected.to raise_error(Puppet::PreformattedError, /^Evaluation Error:.*/) }
        end

      end
    end
  end
end


