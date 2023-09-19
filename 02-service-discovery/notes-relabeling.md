> https://grafana.com/blog/2022/03/21/how-relabeling-in-prometheus-works/#:~:text=Relabeling%20is%20a%20powerful%20tool,usefulness%20in%20taming%20Prometheus%20metrics.

## Labels

> Key pair value

## Instrument

```
node_filesystem_avail_bytes
{device="/dev/mapper/ubuntu--vg-ubuntu--lv", fstype="ext4", instance="linux-batch:9100", job="batch", mountpoint="/", os="linux", runtime="vm"}
	26058063872
```

- `__name__` -> NOMBRE de la metrica
- `__address__` -> host:port scrape target
- `__scheme__`
- `__metrics_path__`
- `__param_<name>`
- `__scrape_interval__`
- `__scrape_tiemout__`
- `__meta_`
- `__tmp`

```yml
# A list of scrape configurations.
scrape_configs:
    - job_name: "some scrape job"
    ...

    # List of target relabel configurations.
    relabel_configs:
    [ - <relabel_config> ... ]

    # List of metric relabel configurations.
    metric_relabel_configs:
    [ - <relabel_config> ... ]

# Settings related to the remote write.
remote_write:
    url: https://remote-write-endpoint.com/api/v1/push
    ...

    # List of remote write relabel configurations.
    write_relabel_configs:
    [ - <relabel_config> ... ]
```

> `relabel_config`, _antes_ scrape, SÓLO acceso a las añadidas por el SD
> `metric_relabel_configs`, _después_ scrape
> `write_relabel_configs` mandas a escribir

## relabel_config

- source_labels
- separator (default = ;)
- target_label
- regex (default = (.\*))
- modulus
- replacement (default = $1)
- action (default = replace)

### source_labels & separator

```
my_custom_counter_total{server="webserver01",subsystem="kata"} 192  1644075044000
my_custom_counter_total{server="sqldatabase",subsystem="kata"} 147  1644075044000
```

```yml
source_labels: [subsystem, server]
separator: "@"
```

```
kata@webserver01
kata@sqldatabase
```

### regex

```yml
source_labels: [subsystem, server]
separator: "@"
regex: "kata@(.*)"
```

```yml
source_labels: [subsystem, server]
separator: "@"
regex: "(.*)@redis"
```

### replacement

```
my_custom_counter_total{server="webserver01",subsystem="kata"} 192  1644075044000
my_custom_counter_total{server="sqldatabase",subsystem="kata"} 147  1644075044000
```

```yml
source_labels: [subsystem, server]
separator: "@"
regex: "(.*)@(.*)"
replacement: "${2}/${1}"
```

```
webserver01/kata
sqldatabase/kata
```

### target_label

```yml
replacement: "production"
target_label: "env"
# action: "replace"
```

```yml
source_labels: [subsystem, server]
separator: "@"
regex: "(.*)@(.*)"
replacement: "${2}/${1}"
target_label: "my_new_label"
```

```
my_custom_counter_total{server="webserver01",subsystem="kata",my_new_label="webserver01/kata"} 192  1644075044000
my_custom_counter_total{server="sqldatabase",subsystem="kata",my_new_label="sqldatabase/kata"} 147  1644075044000
```

## Available Actions

- keep
- drop
- labeldrop

```
regex: "subsystem"
action: labeldrop
```

- labelkeep
