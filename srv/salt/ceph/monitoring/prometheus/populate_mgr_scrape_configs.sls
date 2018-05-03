{# set output = salt.cmd.shell('ceph prometheus file_sd_config') #}
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

