# vim: sts=2 ts=2 sw=2 ai et
# 
# copy all files from directori with name == minionid to /usr/scripts/ directory on minion


# папка scripts
{%- set hostn = grains['host'] -%}
{%- set script_dir_host = salt['pillar.get']('scripts:hostdir','/usr/scripts') -%}
{%- set script_dir_salt = salt['pillar.get']('scripts:saltdir','/scripts/hosts/') -%}
{% for item in salt['pillar.get']('scripts:hosts',[hostn]) %}
{{script_dir_host}}/{{item}}:
  file.recurse:
    - user: root
    - dir_mode: 2755
    - file_mode: '0755'
    - source: salt:/{{script_dir_salt}}{{item}}
    - include_empty: True
{%- endfor -%}
