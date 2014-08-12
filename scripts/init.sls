# vim: sts=2 ts=2 sw=2 ai et
# 
# copy all files from directori with name == minionid to /usr/scripts/ directory on minion


# папка scripts
/usr/scripts/:
  file.recurse:
    - user: root
    - dir_mode: 2755
    - file_mode: '0755'
    - source: salt://{{pillar['scripts']['path_dir']}}/{{ pillar['scripts']['hosts'] }}
    - include_empty: True
