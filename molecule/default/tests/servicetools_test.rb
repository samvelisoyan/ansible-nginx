# frozen_string_literal: true

expected_plugin_packages = %w[servicetools-common]

control 'Plugin Packages installation' do
  impact 1.0
  desc 'The servicetools plugin packages must be installed'
  expected_plugin_packages.each do |plugin_package|
    describe package(plugin_package) do
      it { should be_installed }
    end
  end
end

describe file('/etc/servicetools/services/nginx/nginx') do
  it { should exist }
  it { should be_file }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  it { should be_mode 0o644 }
  its('content') { should match 'systemd|10|/usr/lib/systemd/system/nginx.service|root' }
end
