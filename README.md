Nginx
=========

An Ansible Role that installs and configures Nginx

Requirements
------------
### Ansible User Prerequisites 

Some tasks of this role need to be run as root(thanks to condition 'when ansible_user_id == root')  
So, a 'non-root' user just can deploy configuration files under conf.d directory.
Nginx installation and settings are reserved by root user.

### Operating Systems support

* Centos 7
* Redhat 7,8


Dependencies
------------


Variables and Properties
------------------------

In OPS ui, when you design your application, you have to use the software model(provider: ansible) related to this role 
and so you benefited from data form

## Role Variables

| Variables | Required | Default value | Description |
|-----------|----------|---------------|-------------|
| nginx_disable_install | False | *false* | Will skip packages installation, service managed and directories creation. |
| nginx_version | False | *""* | Major version of nginx package |
| nginx_branch | False | *mainline* | Specify which branch of NGINX Open Source you want to install. Options are 'mainline' or 'stable' |
| nginx_enabled_on_boot | False | *true* | enabled systemd service on boot(as root user) |
| nginx_create_config | False | *true* | Whether to create the elasticsearch configuration file |
| nginx_modules | False | *[]* | Install NGINX Modules. You can select any of the Nginx opensource modules |
| nginx_user | False | *"nginx"* | Nginx user. will specified in nginx.conf file |
| nginx_error_log | False | *"/var/log/nginx/error.log warn"* | Configures logging. The first parameter defines a file that will store the log. The second parameter determines the level of logging |
| nginx_access_log | False | *"/var/log/nginx/access.log main buffer=16k flush=2m"* | Sets the path, format, and configuration for a buffered log write.  path [format [buffer=size] [gzip[=level]] [flush=time] [if=condition]] |
| nginx_worker_processes | False | *"auto"* | Defines the number of worker processes. |
| nginx_worker_connections | False | *"1024"* | Sets the maximum number of simultaneous connections that can be opened by a worker process. |
| nginx_multi_accept | False | *"off"* | If multi_accept is disabled, a worker process will accept one new connection at a time. Otherwise, a worker process will accept all new connections at a time. |
| nginx_extra_conf_options | False | *""* | extra main options, used within the main nginx's context |
| nginx_extra_http_options | False | *""* | extra http options, printed inside the main server http config |
| nginx_server_names_hash_bucket_size | False | *"64"* | Sets the bucket size for the server names hash tables. |
| nginx_client_max_body_size | False | *"64m"* | Sets the maximum allowed size of the client request body. |
| nginx_sendfile | False | *"on"* | Enables or disables the use of sendfile() |
| nginx_tcp_nopush | False | *"on"* | Enables or disables the use of the TCP_NOPUSH socket option on FreeBSD or the TCP_CORK socket option on Linux. The options are enabled only when sendfile is used |
| nginx_tcp_nodelay | False | *"on"* | Enables or disables the use of the TCP_NODELAY option. |
| nginx_keepalive_timeout | False | *"65"* | The first parameter sets a timeout during which a keep-alive client connection will stay open on the server side. |
| nginx_keepalive_requests | False | *"100"* | Sets the maximum number of requests that can be served through one keep-alive connection. After the maximum number of requests are made, the connection is closed. |
| nginx_server_tokens | False | *"on"* | Enables or disables emitting nginx version on error pages and in the “Server” response header field |
| nginx_enable_gzip | False | *false* | The ngx_http_gzip_module module is a filter that compresses responses using the “gzip” method. This often helps to reduce the size of transmitted data by half or even more. |
| nginx_log_format | False | *'$remote_addr - $remote_user [$time_local] "$request" ' '$status $body_bytes_sent "$http_referer" ' '"$http_user_agent" "$http_x_forwarded_for"* | The escape parameter allows setting json or default characters escaping in variables, by default, default escaping is used. The none value disables escaping. |
| nginx_upstreams | False | *[]* | ============= |
| nginx_conf_path | False | */etc/nginx/conf.d* | directory of nginx config files |
| nginx_vhost_path | False | */etc/nginx/conf.d* | directory of nginx virtual host files |
| nginx_remove_default_vhost | False | *true* | Will remove default vhost file from vhost config path |
| nginx_ssl_dir | False | */etc/nginx/ssl/* | directory where will be stored ssl files |
| nginx_ssl_certificate_file | False | *""* | certificate file |
| nginx_ssl_key_file | False | *""* | certificate key file |
| nginx_listen_ipv6 | False | *false* | will listen also for ipv6 |
| nginx_vhosts | False | *[]* | ========== |


### nginx_upstreams Variables

| Variables | Required | Default value | Description |
|-----------|----------|---------------|-------------|
| name | true | *""* | name of upstream |
| strategy | false | *""* | upstream strategy "ip_hash" # "least_conn", etc. |
| keepalive | false | *""* | parameter sets the maximum number of idle keepalive connections to upstream servers that are preserved in the cache of each worker process. |
| servers | true | *""* | Defines the address and other parameters of a server. The address can be specified as a domain name or IP address, with an optional port, or as a UNIX-domain socket path specified after the “unix:” prefix. If a port is not specified, the port 80 is used. A domain name that resolves to several IP addresses defines multiple servers at once. |

### nginx_vhosts Variable

| Variables | Required | Default value | Description |
|-----------|----------|---------------|-------------|
| filename | False | *Will use server_name* | Can be used to set the vhost filename. |
| state | False | *present* | *absent* To remove the vhost configuration. |
| redirect | True | *""* | HTTP redirection is way to point one domain or address to another. |
| redirect_listen | False | *80* | listen port for redirect |
| redirect_server_name | True | *""* | listen servername for redirect |
| redirect_protocol | False | *$scheme* | redirect protocol used for return url |
| scheme | False | *""* | scheme for server config can be *https* or *http* |
| listen | False | *80/443* | listen port |
| server_name | True | *""* | listen servername |
| ssl_certificate_file | False | *""* | ssl certificate file name |
| ssl_key_file | False |  *""* | ssl key file name |
| certificate_protocols | False | *TLSv1.2* | ssl protocols |
| certificate_ciphers | False | *""* | ssl ciphers |
| headers | False | *""* | Adds the specified field to a response header |
| error_page | False | *""* | Defines the URI that will be shown for the specified errors. A uri value can contain variables. |
| access_log | False | *""* | Sets the path, format, and configuration for a buffered log write. path [format [buffer=size] [gzip[=level]] [flush=time] [if=condition]] |
| error_log | False | *""* | Configures logging. The first parameter defines a file that will store the log. The second parameter determines the level of logging |
| locations | True | *[]* | ============ |
| return | False | *""* | To inform clients that the resource they’re requesting now resides at a different location. Example use cases are when your website’s domain name has changed, when you want clients to use a canonical URL format (either with or without the www prefix), and when you want to catch and correct common misspellings of your domain name. The return and rewrite directives are suitable for these purposes. |
| extra_parameters | False | *""* | extra http options, printed inside the Vhost http config |

#### locations Variable

| Variables | Required | Default value | Description |
|-----------|----------|---------------|-------------|
| location | False | *""* |  Sets configuration depending on a request URI. The matching is performed against a normalized URI, after decoding the text encoded in the “%XX” form |
| type | False | *""* | type of location, can be *proxy* or *web* |
| proxy_pass | False | *""* | Sets the protocol and address of a proxied server and an optional URI to which a location should be mapped. As a protocol, “http” or “https” can be specified. The address can be specified as a domain name or IP address, and an optional port |
| proxy_http_version | False | *""* | Sets the HTTP protocol version for proxying. Version 1.1 is recommended for use with keepalive connections and NTLM authentication. |
| proxy_headers | False | *""* | Allows redefining or appending fields to the request header passed to the proxied server. The value can contain text, variables, and their combinations. |
| enable_proxy_redirect | False | *""* | Sets the text that should be changed in the “Location” and “Refresh” header fields of a proxied server response. |
| root | False | *""* | Sets the root directory for requests. |
| index | False | *'index.html index.htm'* | Defines files that will be used as an index |

### Role Vars file

By example, I would like to install(as root user) elasticsearch and set configuration files, place following content into vars yaml file

```yaml
---
nginx_disable_install: false
nginx_create_config: true
nginx_version: ""
nginx_branch: mainline
nginx_modules: []
nginx_enabled_on_boot: true
nginx_user: "nginx"
nginx_error_log: "/var/log/nginx/error.log warn"
nginx_access_log: "/var/log/nginx/access.log main buffer=16k flush=2m"
nginx_worker_processes: "auto"
nginx_worker_connections: "1024"
nginx_multi_accept: "off"
nginx_extra_conf_options: ""
nginx_extra_http_options: ""
nginx_server_names_hash_bucket_size: "64"
nginx_client_max_body_size: "64m"
nginx_sendfile: "on"
nginx_tcp_nopush: "on"
nginx_tcp_nodelay: "on"
nginx_keepalive_timeout: "65"
nginx_keepalive_requests: "100"
nginx_server_tokens: "on"
nginx_proxy_cache_path: ""
nginx_enable_gzip: false
nginx_log_format: |-
  '$remote_addr - $remote_user [$time_local] "$request" '
  '$status $body_bytes_sent "$http_referer" '
  '"$http_user_agent" "$http_x_forwarded_for"'
nginx_upstreams:
  - name: myupstream
    servers:
      - "google.com"
      - "amazon.com weight=3"
nginx_conf_path: /etc/nginx/conf.d
nginx_vhost_path: /etc/nginx/conf.d
nginx_remove_default_vhost: true
nginx_listen_ipv6: false
nginx_vhosts:
  - filename: vhost1.conf
    redirect: true
    redirect_server_name: redirectvhost1test
    scheme: http
    server_name: vhost1test
    headers:
      - 'X-Frame-Options DENY'
    locations:
      - location: '/'
        type: 'proxy'
        proxy_pass: http://myupstream/
        proxy_http_version: '1.1'
        enable_proxy_redirect: false
        proxy_headers:
          - 'Upgrade $http_upgrade'
          - 'Connection "upgrade"'
          - 'Host $http_host'
          - 'X-Real-IP $remote_addr'
          - 'X-Forwarded-For $proxy_add_x_forwarded_for'
          - 'X-Forward-Proto http'
          - 'X-Nginx-Proxy true'
  - filename: vhost2.conf
    redirect: false
    scheme: http
    server_name: vhost2test
    headers:
      - 'X-Frame-Options DENY'
    locations:
      - location: '/web'
        type: 'web'
        root: '/usr/share/nginx/html'
        proxy_http_version: '1.1'
```

Example Playbook
----------------

Including an example of how to use your role :
```yaml
---
    - hosts: servers
      vars_files:
        - vars_file.yml
      roles:
        - role: nginx            
```

License
-------

BSD

Author Information
------------------
