# Prometheus & Grafana

## Introduction
* Prometheus is an monitoring system that collects and stores metrics from applications and infrastructure, using a powerful query language for analysis.
* Grafana is an analytics and visualization platform that integrates with various data sources, including Prometheus, to create dynamic and interactive dashboards.
* This guide will provide instructions for setting up Prometheus and Grafana to monitor a Minikube cluster, enabling effective tracking of Kubernetes metrics.

## Install Helm CLI
Helm is the package manager for Kubernetes, which can be used for deploying Prometheus and Grafana.  
To install Helm, refer to the official [Helm Installation Guide](https://helm.sh/docs/intro/install).

## Deploy Prometheus & Grafana
* Config & Deploy: 
```bash
chmod 755 start.sh && ./start.sh
```
Prometheus service is now accessible via: http://localhost:9090/  
Grafana service is now accessible via: http://localhost:3030/  

* Stop & Remove:
```bash
chmod 755 stop.sh && ./stop.sh
```

## Config Grafana to use Prometheus

### Add Prometheus as Data Source
![image](https://github.com/user-attachments/assets/f015d370-4814-434c-ba88-e9135f08f466)

![image](https://github.com/user-attachments/assets/351f793a-e3ab-4d00-8af5-dd565592ad91)

![image](https://github.com/user-attachments/assets/b498304c-e834-433d-bba3-524ffb8f1057)

### Import Dashboard
![image](https://github.com/user-attachments/assets/c4ae0f6f-602a-46d6-a1f2-8c8c6504b294)

![image](https://github.com/user-attachments/assets/5d1479b5-9ef5-4641-ab99-5e4cd29a5127)

![image](https://github.com/user-attachments/assets/ba2521af-bae5-4179-9fec-eb78846edf89)
