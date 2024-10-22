name: CI/CD Pipeline

on:
  pull_request:
    branches:
      - main
  push:
    branches:
      - main

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
    - uses: actions/checkout@v2
    - name: Set up Node.js
      uses: actions/setup-node@v2
      with:
        node-version: '14'
    - run: npm install
    - run: npm test # This will run your tests

  deploy:
    if: github.ref == 'refs/heads/main'
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v2

    - name: Log in to Azure
      uses: azure/login@v1
      with:
        creds: $${{ secrets.AZURE_CREDENTIALS }}

    - name: Set up Docker Buildx
      uses: docker/setup-buildx-action@v1

    - name: Log in to ACR
      run: |
        az acr login --name ${acr_name}

    - name: Build and Push Docker Image
      run: |
        docker build -t ${name}-app:$${{ github.sha }} .
        docker tag ${name}-app:$${{ github.sha }} ${acr_name}.azurecr.io/${name}-app:$${{ github.sha }}
        docker push ${acr_name}.azurecr.io/${name}-app:$${{ github.sha }}

    - name: Deploy to AKS
      uses: azure/aks-set-context@v1
      with:
        creds: $${{ secrets.AZURE_CREDENTIALS }}
        cluster-name: ${aks_cluster_name}
        resource-group: ${resource_group_name}

    - name: Apply Kubernetes manifests
      run: |
        kubectl set image deployment/${name}-app node-app=${acr_name}.azurecr.io/${name}-app:$${{ github.sha }}
        kubectl rollout status deployment/${name}-app
