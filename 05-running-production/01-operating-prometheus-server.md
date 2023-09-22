## Running Prometheus in General

- Prometheus is a long running process
- REST API
- Dashboard
- Suits being run as a service
- Not designed for open internet

## Hardware

> It operates and scales its resource usage as a time series database.
> Prometheus will use RAM equivalent to how much work you ask it to do.
> Brian Brazil: rule of thumb of 3 KB of RAM per time series

- Time series database
- RAM equivalent to work
  - ~3kb per timeseries
  - Multiplied by 2.5x - 3x
- 16GB should be enough for 1M timeseries
- RAM optimized cloud instances
  - Be aware of query times (CPU usage)

### Local Disk

- Local data persistence on disk
- Potentially large batches of data
- Value peak writing performance
- SSD is a wise choice

### Operational Recomendations

- Run as Systemd service
- Separately mounted data disk
- Can configure for automatic restarts
- Logs written to central journal
- Decouple data storage from server

> Show Reverse Proxy Diagram

- [basic auth](https://prometheus.io/docs/guides/basic-auth/)
