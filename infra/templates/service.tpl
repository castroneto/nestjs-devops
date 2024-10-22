apiVersion: v1
kind: Service
metadata:
  name: ${name}-service
spec:
  type: LoadBalancer
  selector:
    app: ${name}-app
  ports:
  - protocol: TCP
    port: 80
    targetPort: 3000