# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "terraform/map.jinja" import terraform with context %}
{% from "terraform/map.jinja" import terraform_sha256_checksums %}
{% set extract_path = terraform.path.extract_to|replace('VERSION', terraform.download.version) %}
# 
# Fetch the file from terraform
#
terraform-extract-binary:
  archive.extracted:
    - name: {{ extract_path }}
    - source: {{ terraform.download.url|replace('VERSION', terraform.download.version) }}
    - source_hash: {{ terraform_sha256_checksums[terraform.download.version] }}
    - archive_format: zip
    - enforce_toplevel: False
  # make terraform executable
  cmd.run:
    - name: |
        chmod +x {{ extract_path }}/terraform
    - runas: root
    - shell: /bin/bash
    - require:
        - archive: terraform-extract-binary
