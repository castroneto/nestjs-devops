apiVersion: apps/v1
kind: Deployment
metadata:
  name: ${name}-app
  annotations:
    azure.workload.identity/client-id: ${identity_client_id}  # Inject the client ID here
spec:
  replicas: 2
  selector:
    matchLabels:
      app: ${name}-app
  template:
    metadata:
      labels:
        app: ${name}-app
    spec:
      containers:
      - name: node-app
        image: bitshoppacr.azurecr.io/${name}-app:latest
        ports:
        - containerPort: 3000
        env:
        - name: PORT
          value: "3000"
        - name: PGHOST
          value: "${db_server}"
        - name: PGUSER
          value: "${db_username}"
        - name: PGDATABASE
          value: "${db_name}"
        - name: PGPORT
          value: "5432"
        - name: KEY_VAULT_NAME
          value: "${key_vault_name}"
        - name: KEY_VAULT_SECRET
          value: "${key_vault_secret_name}"
      nodeSelector:
        "kubernetes.io/os": linux