application: xxx
version: 1
runtime: go
api_version: go1

handlers:
- url: /(robots\.txt|favicon\.ico)
  static_files: static/\1
  upload: static/(robots\.txt|favicon\.ico)
- url: /imgs
  static_dir: static/imgs
- url: /.*
  script: _go_app
