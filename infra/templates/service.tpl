apiVersion: v1
kind: Service
metadata:
  name: ${name}-headless-service
spec:
  clusterIP: None  # Isso define o serviço como headless
  selector:
    app: ${name}-app
  ports:
  - protocol: TCP
    port: 80
    targetPort: 3000