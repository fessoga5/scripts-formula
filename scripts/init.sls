# vim: sts=2 ts=2 sw=2 ai et
# 
# copy all files from directori with name == minionid to /usr/scripts/ directory on minion


# папка scripts
{%- set hostn = grains['host'] -%}
{%- for elem in salt['pillar.get']('scripts | []) %}
{%- set script_dir_host = elem.hostdir | '/usr/scripts' -%}
{%- set script_dir_salt = elem.saltdir | '/hosts_scripts' -%}

{% for item in elem.hosts | [hostn] %}
{{script_dir_host}}/{{item}}:
  file.recurse:
    - user: {{ elem.user | 'root') }}
    - group: {{ elem.user | 'group') }}
    - dir_mode: {{ elem.dirmod | '2755') }} 
    - file_mode: {{ elem.filemod | '0755') }} 
    - source: salt:/{{script_dir_salt}}/{{item}}
    - include_empty: True
{%- endfor -%}

{%- set bare_scripts =  elem.bare | False -%}
{% if bare_scripts %}
{{script_dir_host}}:
  file.recurse:
    - user: {{ elem.user | 'root') }} 
    - group: {{ elem.user | 'group') }}
    - dir_mode: {{ elem.dirmod | '2755') }} 
    - file_mode: {{ elem.filemod | '0755') }} 
    - source: salt:/{{script_dir_salt}}/{{bare_scripts}}
    - include_empty: True
{%- endif -%}
{%- endfor %}
