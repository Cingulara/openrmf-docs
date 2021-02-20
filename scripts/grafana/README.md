# Auto provisioning of Prometheus and Dashboards in Grafana

The current directory in the container is /etc/grafana/conf/provisioning/ and then you have subdirectories of
* dashboards
* datasources
* notifiers
* plugins

You can setup the configuration of this data inside these subdirectories. 

## Environment in the container

* GF_PATHS_CONFIG='/etc/grafana/grafana.ini'
* GF_PATHS_DATA='/var/lib/grafana'
* GF_PATHS_HOME='/usr/share/grafana'
* GF_PATHS_LOGS='/var/log/grafana'
* GF_PATHS_PLUGINS='/var/lib/grafana/plugins'
* GF_PATHS_PROVISIONING='/etc/grafana/provisioning'