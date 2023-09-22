# Data Storage

Prometheus stores its data on local disk using a custom time series database, or TSDB format.

```
-- 01FAZ6RMVA85Y64RZ54404G575 # Custom TSDB format
| |-- chunks
| | |-- 000001
| |
| |-- tombstones
| |-- index
| |-- meta.json
|
|-- 01FB2J238RJEXF4CZAPYZJFP61  # ULID identifier (like UUID but sortable)
| |-- chunks                    # Contains Prometheus data
| | |-- 000001
| | |-- 000002
| | |-- 000003
| |
| |-- tombstones  # Lists deleted timeseries
| |-- index       # Indexes metric names and labels
| |-- meta.json   # Metadata
|
|-- wal           # Write-ahead log (WAL)
|-- 000000002
|-- checkpoint.00000001
|-- 00000000
```

### Coontrolling Data Storage

> Retaining by size or time depends on your goal
> Reduce the number of time series to save space

- `--storage.tsdb.path`
  - Where to staore Prometheus data
- `--storage.tsdb.retention-time`
  - Remove data after this length of time
- `--storage.tsdb.retention-size (experimental)`
  - Remove data once this size is reached
- size = time \* sample rate \* bytes (sample)
- RAID & block-level snapshots for local data
  - Do not use NFS for data storage

### References

- https://aws.amazon.com/blogs/containers/eks-persistent-volumes-for-instance-store/
- https://en.wikipedia.org/wiki/RAID

## External Read & Write

### Choosing External Storage

- What are you trying to achieve?
- General storage methodology
  - Relying on local TSDB gives more options
- Does it need compute?
  - No, if it's for backup only
- Buffer through a messaging system?
- Smaller deployments, self hosted DB

### Thanos

- Thanos

  - Set of components, run separately
  - Highly available Prometheus
  - Long term data storage
  - Uses object storage buckets
  - Querying API that combines data
  - Cost efficient & resilient

- https://prometheus.io/docs/operating/integrations/#remote-endpoints-and-storage
- https://banzaicloud.com/blog/multi-cluster-monitoring/
