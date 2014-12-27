application: xxxxxxx
module: xxxxx
version: 1
runtime: go
api_version: go1
instance_class: F1
automatic_scaling:
  min_idle_instances: 1
  max_idle_instances: automatic
  max_pending_latency: 100ms
  max_concurrent_requests: 50  # max: 500

default_expiration: "3d"

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
