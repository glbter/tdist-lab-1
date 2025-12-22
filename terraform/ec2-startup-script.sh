#! /bin/bash

sudo apt-get update -y
sudo apt upgrade -y
mkdir /root/prometheus 
# /root/grafana/dashboard /root/grafana/provisioning/dashboards /root/grafana/provisioning/datasources
curl -o /root/docker-compose.yaml -OL https://github.com/DanikVitek/tdist-lab-1/raw/refs/heads/prometheus_grafana/docker-compose.yaml
curl -o /root/prometheus/prometheus.yml -OL https://github.com/DanikVitek/tdist-lab-1/raw/refs/heads/prometheus_grafana/prometheus/prometheus.yml
curl -o /root/grafana/dashboards/trist-dashboard.json -OL https://github.com/DanikVitek/tdist-lab-1/raw/refs/heads/prometheus_grafana/grafana/dashboards/trist-dashboard.json --create-dirs
curl -o /root/grafana/provisioning/dashboards/dashboards.yml -OL https://github.com/DanikVitek/tdist-lab-1/raw/refs/heads/prometheus_grafana/grafana/provisioning/dashboards/dashboards.yml --create-dirs
curl -o /root/grafana/provisioning/datasources/datasource.yml -OL https://github.com/DanikVitek/tdist-lab-1/raw/refs/heads/prometheus_grafana/grafana/provisioning/datasources/datasource.yml --create-dirs
sudo mkdir /root/data
sudo chmod 777 /root/data
sudo mount /dev/nvme1n1 /root/data
sudo docker compose -f /root/docker-compose.yaml up -d 
