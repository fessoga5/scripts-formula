# vim: sts=2 ts=2 sw=2 ai et
# 
# copy all files from directori with name == minionid to /usr/scripts/ directory on minion


# папка scripts
{%- set hostn = grains['host'] -%}
{%- set script_dir_host = salt['pillar.get']('scripts:hostdir','/usr/scripts') -%}
{%- set script_dir_salt = salt['pillar.get']('scripts:saltdir','/hosts_scripts') -%}
{% for item in salt['pillar.get']('scripts:hosts',[hostn]) %}
{{script_dir_host}}/{{item}}:
  file.recurse:
    - user: {{ salt['pillar.get']('scripts:user','root') }}
    - group: {{ salt['pillar.get']('scripts:user','group') }}
    - dir_mode: {{ salt['pillar.get']('scripts:dirmod','2755') }} 
    - file_mode: {{ salt['pillar.get']('scripts:filemod','0755') }} 
    - source: salt:/{{script_dir_salt}}/{{item}}
    - include_empty: True
{%- endfor -%}

{%- set bare_scripts =  salt['pillar.get']('scripts:bare',False) -%}
{% if bare_scripts %}
{{script_dir_host}}:
  file.recurse:
    - user: {{ salt['pillar.get']('scripts:user','root') }} 
    - group: {{ salt['pillar.get']('scripts:user','group') }}
    - dir_mode: {{ salt['pillar.get']('scripts:dirmod','2755') }} 
    - file_mode: {{ salt['pillar.get']('scripts:filemod','0755') }} 
    - source: salt:/{{script_dir_salt}}/{{bare_scripts}}
    - include_empty: True
{%- endif -%}
