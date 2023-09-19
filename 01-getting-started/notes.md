## Counter

> Siempre aumenta

```
http_requests_total 1000000
cpu_seconds_total 3000
                        @ 22:00
```

```
http_requests_total 970000
cpu_seconds_total 3000
                        @ 21:00
```

```
http_requests_total - http_requests_total offset 1h = 3000
```

## Gauge

Toma in `snapshot` de un valor cambiente

```
http_requests_active 2000
memory_allocated_bytes 4.832e+09
                        @ 22:00:15
```

```
http_requests_active 900
memory_allocated_bytes 3.642e+09
                        @ 22:00:00
```

```
memory_allocated_bytes / (1024 * 1024 * 1024)
```

## Summary

- `count` el núemro de eventos
- `sum` la suma del valor de todos los eventos

```
calculation_seconds_count 3
calculation_seconds_sum 15
                   @ 21:00
```

## Histogram

```
calculation_seconds_bucket{le="1"}  0
calculation_seconds_bucket{le="5"}  3
calculation_seconds_bucket{le="10"}  6
calculation_seconds_bucket{le="20"}  9
calculation_seconds_bucket{le="60"}  10
```

`+Inf`

- instant vectors 1 {}
- scalar 3434

```
f(x)' = [f(x1) - f(x0)] / [x1 - x0]
```

## Labels

```ini
http_requests_total {code, path}
```

> Las metricas son registradas a nivel de eiquetas

```
http_requests_total <-- 1x time series
```

```
http_requests_total |
                    > <- 20x time series
  host: w01..w19    |
```

http_requests_total | > <- 180x time series
host: w01..w19 |
host: dc1..dc9 |

## Reload Config via HTTP API

```bash
./prometheus --web.enable-lifecycle
```

```bash
curl -X POST <promtheus-api>/-/reload
```

> WARNING!!!: Cuidado quien lo puede ejecutar
