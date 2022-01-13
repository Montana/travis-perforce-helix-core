[![Build Status](https://app.travis-ci.com/Montana/travis-perforce-helix-core.svg?branch=master)](https://app.travis-ci.com/Montana/travis-perforce-helix-core)

# A Test Run With: Travis & Perforce Helix-Core

You're free to use my bash script to install, and make sure it passes on Travis CI. 

## The Project

This project integrates Perforce's Helix Core Server (p4d) with the [Prometheus](https://prometheus.io/) monitoring framework and associated tools.
It allows real-time metrics from analysis of p4d log files and other monitoring commands to be collected by Prometheus
and shown on Grafana dashboards. The metrics can also used for system alerting.

[Prometheus has many integrations](https://prometheus.io/docs/instrumenting/exporters/) with other monitoring packages 
and other systems, so just because you are not using Prometheus doesn't mean this isn't useful! 
This project has simple installation instructions and scripts for all the required components.

The `p4prometheus` component itself (from this project) continuously parses p4d log files and writes a summary to 
a specified Prometheus compatible metrics file which can be handled via the `node_exporter`
textfile collector module. Other components of this package collect related metrics by interrogating p4d server
and other associated logs.

* [p4prometheus](releases/latest) - a released binary executable
* [monitor_metrics.sh](demo/monitor_metrics.sh) - an [SDP](https://swarm.workshop.perforce.com/projects/perforce-software-sdp) compatible bash script to generate simple supplementary metrics - see also [installation instructions](INSTALL.md)
* other useful scripts and tools

Check out the Prometheus architecture below. The custom components referred to above interface with
"Prometheus targets"  (or "Jobs/exporters") in the lower left of the diagram.

![Prometheus architecture](https://prometheus.io/assets/architecture.png)

Uses [go-libp4dlog](https://github.com/rcowham/go-libp4dlog) for actual log file parsing.

- [p4prometheus](#p4prometheus)
  - [Support Status](#support-status)
  - [Overview](#overview)
- [Grafana Dashboards](#grafana-dashboards)
- [Detailed Installation Instructions](#detailed-installation-instructions)
- [Metrics Available](#metrics-available)
  - [P4Prometheus](#p4prometheus-1)
  - [Monitor_metrics.sh](#monitor_metricssh)
  - [Locks](#locks)

## P4 Stats Summary

This is how the `p4 stats` summary looks, you can also use something like Grafana.

![image](https://user-images.githubusercontent.com/20936398/149221067-3649f468-2a30-408f-8293-e670fb652dd3.png)


## Overview

This is part of a solution consisting of the following components:

* [Prometheus](https://prometheus.io/) - time series metrics management system
* [VictoriaMetrics](https://github.com/VictoriaMetrics/VictoriaMetrics) - (optional but recommended) high performing storage management which is Prometheus-compatible
* [Grafana](https://grafana.com/) - The leading open source software for time series analytics
* [node_exporter](https://github.com/prometheus/node_exporter) - Prometheus collector for basic Linux metrics
* [windows_exporter](https://github.com/prometheus-community/windows_exporter) - Prometheus collector for Windows machines
* [alertmanager](https://github.com/prometheus/alertmanager) - handles alerting including de-duplication etc - part of Prometheus
