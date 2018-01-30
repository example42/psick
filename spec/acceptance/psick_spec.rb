require 'spec_helper_acceptance'

describe 'psick' do
  let(:facts) do
    OS_FACTS.merge(facts).merge( domain: 'lab.psick.io' )
  end
  let(:manifest) {
    <<-EOS
      Tp::Install {
        test_enable  => lookup('tp::test_enable', Boolean, 'first', false),
        puppi_enable => lookup('tp::puppi_enable', Boolean, 'first', false),
        debug => lookup('tp::debug', Boolean, 'first', false),
        data_module  => lookup('tp::data_module', String, 'first', 'tinydata'),
      }
      Tp::Conf {
        config_file_notify => lookup('tp::config_file_notify', Boolean, 'first', true),
        config_file_require => lookup('tp::config_file_require', Boolean, 'first', true),
        debug => lookup('tp::debug', Boolean, 'first', false),
        data_module  => lookup('tp::data_module', String, 'first', 'tinydata'),
      }
      Tp::Dir {
        config_dir_notify => lookup('tp::config_dir_notify', Boolean, 'first', true),
        config_dir_require => lookup('tp::config_dir_require', Boolean, 'first', true),
        debug  => lookup('tp::debug', Boolean, 'first', false),
        data_module  => lookup('tp::data_module', String, 'first', 'tinydata'),
      }
      Exec {
        path => '/bin:/usr/bin:/sbin:/usr/sbin:/usr/local/bin:/usr/local/sbin',
      }
      include psick
    EOS
  }
  it 'should run without errors or without changes' do
    result = apply_manifest(manifest, :catch_failures => true)
    expect(@result.exit_code).to eq(2).or(eq(0))
  end
  it 'should run a second time without changes' do
    result = apply_manifest(manifest, :catch_changes => true)
    expect(@result.exit_code).to eq 0
  end
end
