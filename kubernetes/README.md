# Kubernetes Manifests - Product Service

**Prerequisites:** Database namespace, secret, configmap, and database deployment must exist.

## Apply

```bash
kubectl apply -f dev/deployment.yaml
kubectl apply -f dev/service.yaml
```

## Image Update (Jenkins)

```bash
kubectl set image deployment/ecomm-product-service product-service=FULL_IMAGE -n ecomm-dev
```

## NodePorts

| Env    | NodePort |
|--------|----------|
| dev    | 30001    |
| staging| 30101    |
| prod   | 30201    |
