application: xxx
version: 1
runtime: python27
api_version: 1
threadsafe: true

handlers:
- url: /favicon.ico
  static_files: assets/img/favicon.ico
  upload: assets/img/favicon.ico
- url: /stats.*
  script: google.appengine.ext.appstats.ui.app
- url: /.*
  script: main.app

libraries:
- name: jinja2
  version: latest

inbound_services:
- warmup

skip_files:
- ^(.*/)?app\.yaml
- ^(.*/)?app\.yml
- ^(.*/)?index\.yaml
- ^(.*/)?index\.yml
- ^(.*/)?#.*#
- ^(.*/)?.*~
- ^(.*/)?.*\.py[co]
- ^(.*/)?.*/RCS/.*
- ^(.*/)?\..*
- ^(.*/)local/*
- ^(.*/)sql/*
