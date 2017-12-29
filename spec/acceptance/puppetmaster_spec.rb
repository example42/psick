require 'spec_helper_acceptance'

describe 'puppetmaster' do
  let(:manifest) {
    <<-EOS
      include role::puppetmaster
    EOS
  }
  it 'should run first time with changes and without errors' do
    result = apply_manifest(manifest, :catch_failures => true)
    expect(@result.exit_code).to eq 2
  end
  it 'should run a second time without changes' do
    result = apply_manifest(manifest, :catch_changes => true)
    expect(@result.exit_code).to eq 0
  end
  # here one can add more serverspec tests
end

