FROM bitnami/prometheus:2.46.0-debian-11-r31
USER root
COPY entrypoint.sh /opt/bitnami/prometheus/bin/entrypoint.sh
RUN apt-get update && apt-get install -y gettext-base && chmod +x /opt/bitnami/prometheus/bin/entrypoint.sh
RUN mv /opt/bitnami/prometheus/conf/prometheus.yml prometheus.yml
ENTRYPOINT [ "entrypoint.sh" ]
