```bash
docker build -t jaimesalas/webhook-receiver-server:1 .
```

```bash
docker push jaimesalas/webhook-receiver-server:1
```

```bash
curl -X POST -H "Content-Type: application/json" -d '{"name": "foo"}' http://localhost:3001/api/alert
```
