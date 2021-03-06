# -*- coding: utf-8 -*-
# vim: ft=yaml

{% from "ceph/map.jinja" import settings with context -%}

include:
  - .repo

install_ceph_pkgs:
  pkg.installed:
    - pkgs: {{ settings.packages }}

create_ceph_config_file:
  file.touch:
    - name: /etc/ceph/{{ settings.cluster_name }}.conf
    - unless: test -e /etc/ceph/{{ settings.cluster_name }}.conf

ceph_config_file:
  ini.options_present:
    - name: /etc/ceph/{{ settings.cluster_name }}.conf
    - sections:
        global:
          {{ settings.config.global }}

ceph_config_mon_host:
  ini.options_present:
    - name: /etc/ceph/{{ settings.cluster_name }}.conf
    - sections:
        global:
          mon_host: {{ settings.mon_hosts|join(', ') }}
