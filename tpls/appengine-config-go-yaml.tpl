application: xxx
version: 1
runtime: go
api_version: go1

handlers:
- url: /(robots\.txt|favicon\.ico)
  static_files: static/\1
  upload: static/(robots\.txt|favicon\.ico)
- url: /css
  static_dir: assets/css
- url: /img
  static_dir: assets/img
- url: /js
  static_dir: assets/js
- url: /.*
  script: _go_app
