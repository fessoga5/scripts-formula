# vim: sts=2 ts=2 sw=2 ai et
# 
# copy all files from directori with name == minionid to /usr/scripts/ directory on minion


# папка scripts
{%- set hostn = grains['host'] -%}
{%- set data = salt['pillar.get']('scripts', []) %}
{% for elem in data %}
{%- set script_dir_host = elem.hostdir | default('/usr/scripts') -%}
{%- set script_dir_salt = elem.saltdir| default('/hosts_scripts') -%}

{% for item in elem.hosts | default([hostn]) %}
{{script_dir_host}}/{{item}}:
  file.recurse:
    - user: {{ elem.user | default('root') }}
    - group: {{ elem.user | default('group') }}
    - dir_mode: {{ elem.dirmod | default('2755') }} 
    - file_mode: {{ elem.filemod | default('0755') }} 
    - source: salt:/{{script_dir_salt}}/{{item}}
    - include_empty: True
{%- endfor -%}

{%- set bare_scripts =  elem.bare | default(False) -%}
{% if bare_scripts %}
{{script_dir_host}}:
  file.recurse:
    - user: {{ elem.user | default('root') }} 
    - group: {{ elem.user | default('group') }}
    - dir_mode: {{ elem.dirmod | default('2755') }} 
    - file_mode: {{ elem.filemod | default('0755') }} 
    - source: salt:/{{script_dir_salt}}/{{bare_scripts}}
    - include_empty: True
{%- endif -%}
{%- endfor %}
