runtime: go
api_version: go1
vm: true

automatic_scaling:
  min_num_instances: 1
  max_num_instances: 20
  cpu_utilization:
    target_utilization: 0.8

resources:
  cpu: 0.5
  memory_gb: 1
  disk_size_gb: 50

handlers:
# SEO
- url: /(robots\.txt|favicon\.ico)
  static_files: static/\1
  upload: static/(robots\.txt|favicon\.ico)
  expiration: "10d"

# Fonts
- url: /(.+\.(eot|otf|tt[cf]|woff2?|cur))
  static_files: web/fonts/\1
  upload: web/fonts/(.+\.(eot|otf|tt[cf]|woff2?|cur))
  http_headers:
    # Allow cross-origin access to web fonts
    # You can also replace "*" with a specific host, e.g. https://example.org
    Access-Control-Allow-Origin: "*"

# Images
- url: /images
  static_dir: web/images
  http_headers:
    Access-Control-Allow-Origin: "*"

# Css
- url: /css
  static_dir: web/css
  #expiration: "60m"
  http_headers:
    Access-Control-Allow-Origin: "*"

# Js
- url: /js
  static_dir: web/js
  http_headers:
    Access-Control-Allow-Origin: "*"

- url: /.*
  script: _go_app
