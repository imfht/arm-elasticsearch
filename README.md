Role Name
=========

Installs and configures Elasticsearch "{{ elasticsearch.version }}" to a Raspberry pi or Odroid running ubuntu.

Supports
------------

Ubuntu

Role Variables
--------------

|| Variable || Default ||
| java.repo | ppa:webupd8team/java |
| java.name | oracle-java8-installer |
| java.xms | 512m |
| java.xmx | 512m |
| java.xss | 320k |
| elasticsearch.version | 5.5.1 |
| elasticsearch.url | https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch |
| elasticsearch.data_path | /var/lib/elasticsearch |
| elasticsearch.logs_path | /var/log/elasticsearch |
| elasticsearch.network_host | _eth0_ |

Example Playbook
----------------

    - hosts: odroid
      become: true
      become_method: sudo
      vars:
        elasticsearch:
          data_path: /var/lib/elasticsearch
      roles:
         - jahrik.arm-elasticsearch
