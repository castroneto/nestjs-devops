apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: ${name}-app-ingress
spec:
  ingressClassName: nginx  # Defina a classe correta
  rules:
  - http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: ${name}-headless-service # Certifique-se que o nome do serviço está correto
            port:
              number: 80