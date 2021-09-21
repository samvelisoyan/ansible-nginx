# frozen_string_literal: true

control 'Package nginx installation' do
  impact 1.0
  desc 'The nginx package must be installed'
  describe package('nginx') do
    it { should be_installed }
  end
end

control 'Package nginx service status' do
  impact 1.0
  desc 'The nginx service must be running'
  describe service('nginx') do
    it { should be_running }
  end
end

control 'Check-configuration-file' do
  desc 'Check config file content of nginx installation'

  describe file('/etc/nginx/nginx.conf') do
    it { should exist }
    it { should be_file }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should be_mode 0o644 }
    its('content') { should match 'user nginx' }
    its('content') { should match 'error_log /var/log/nginx/error.log warn' }
    its('content') { should match 'worker_connections 1024' }
    its('content') { should match 'multi_accept off' }
    its('content') { should match 'server_names_hash_bucket_size 64' }
    its('content') { should match 'client_max_body_size 64m' }
    its('content') { should match 'access_log /var/log/nginx/access.log main buffer=16k flush=2m' }
    its('content') { should match 'sendfile on' }
    its('content') { should match 'tcp_nopush on' }
    its('content') { should match 'tcp_nodelay on' }
    its('content') { should match 'keepalive_timeout 65' }
    its('content') { should match 'keepalive_requests 100' }
    its('content') { should match 'server_tokens on' }
    its('content') { should match 'include /etc/nginx/conf.d/*' }
    its('content') { should match 'server google.com' }
    its('content') { should match 'server amazon.com weight=3' }
  end
end

control 'Check-virtual-host-configuration-file1' do
  desc 'Check config file content of vhost conf file2'

  describe file('/etc/nginx/conf.d/vhost1.conf') do
    it { should exist }
    it { should be_file }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should be_mode 0o644 }
    its('content') { should match 'listen 80' }
    its('content') { should match 'server_name vhost1test' }
    its('content') { should match 'add_header X-Frame-Options DENY' }
    its('content') { should match 'location / {' }
    its('content') { should match 'proxy_pass http://myupstream/' }
    its('content') { should match 'proxy_http_version 1.1' }
    its('content') { should match 'proxy_set_header Connection "upgrade"' }
    its('content') { should match 'proxy_set_header X-Forward-Proto http' }
    its('content') { should match 'proxy_set_header X-Nginx-Proxy true' }
    its('content') { should match 'proxy_redirect off' }
  end
end

control 'Check-virtual-host-configuration-file2' do
  desc 'Check config file content of vhost conf file2'

  describe file('/etc/nginx/conf.d/vhost2.conf') do
    it { should exist }
    it { should be_file }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should be_mode 0o644 }
    its('content') { should match 'listen 80' }
    its('content') { should match 'server_name vhost2test' }
    its('content') { should match 'add_header X-Frame-Options DENY' }
    its('content') { should match 'location /web {' }
    its('content') { should match 'root /usr/share/nginx/html' }
    its('content') { should match 'index index.html index.htm' }
  end
end
