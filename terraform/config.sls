{% from "terraform/map.jinja" import terraform with context -%}
# Ensure that terraform is added to the environment
terraform-env-file:
  file.managed:
    - name: {{ terraform.path.profile }}
    - contents: "export PATH=$PATH:{{ terraform.path.extract_to|replace('VERSION', terraform.download.version) }}"
