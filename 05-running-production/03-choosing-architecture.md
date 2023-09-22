https://prometheus.io/docs/prometheus/latest/federation/

## Single Prometheus

- Can handle up to 1000 scrape targets
- Could be enough for most situations
- Fully functional as a lone instance
- Choose if
  - You have a single DC or cloud region
  - You have less than 700 scrape targets

## HA Pair

- Availability is a concern
- Scrape metrics identically
- Never communicate with each other
- Slightly different data between them
- Thanos can dedupe

> Clustering Alertmanager
