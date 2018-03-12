{% set output = salt.cmd.shell('ceph prometheus file_sd_config') %}
{% set output = [{"labels": {}, "targets": [":42677", ":46677", ":50677"]}] %}
/srv/salt/ceph/monitoring/prometheus/cache/mgr_exporter.yml:
  file.managed:
    - user: {{ salt['deepsea.user']() }}
    - group: {{ salt['deepsea.group']() }}
    - mode: 600
    - makedirs: True
    - contents: |
        {{ output }}
    - fire_event: True


{% for minion in salt.saltutil.runner('select.minions', cluster='ceph', host=False) %}
/srv/salt/ceph/monitoring/prometheus/cache/{{ minion }}.yml:
  file.managed:
    - user: {{ salt['deepsea.user']() }}
    - group: {{ salt['deepsea.group']() }}
    - mode: 600
    - makedirs: True
    - fire_event: True
    - source: salt://ceph/monitoring/prometheus/files/minion.yml.j2
    - template: jinja
    - context:
        minion: {{ minion }}
{% endfor %}
