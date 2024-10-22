
## Deploy

Para fazer o deploy desse projeto rode

```bash
  cd infra
```

Para criar autenticação no azure

```bash
  az login
```
Para fazer o deploy desse projeto rode

```bash
  terraform init
  terraform apply
```

| Month    | desciption |   example  |
| -------- | ------- |------- |
| name  | nome do projeto |   evilcorp   |
| location | Local onde os recursos serão provisionados.| australiacentral   |
| subscription    | id da subscrição  |    |



## Aplicação de manifestos no Kubernetes para configurar e gerenciar recursos no cluster.
```bash
  az aks get-credentials --resource-group rg-${name}-infra --name aks-cluster
```

Esse comando obtém as credenciais do cluster AKS (Azure Kubernetes Service) especificado, permitindo que você interaja com o cluster usando o kubectl.
```bash
  kubectl apply -f k8s/deployment.yaml
```
Aplica as configurações definidas no arquivo deployment.yaml no cluster Kubernetes, criando ou atualizando um Deployment (que gerencia réplicas de pods).

```bash
  kubectl apply -f k8s/service.yaml
```
Aplica as configurações do arquivo service.yaml, criando ou atualizando um Service no Kubernetes, que define como os pods serão acessados dentro ou fora do cluster.

```bash
  kubectl apply -f k8s/hpa.yaml
``` 
Aplica as configurações do arquivo hpa.yaml para criar ou atualizar um Horizontal Pod Autoscaler (HPA), que ajusta automaticamente o número de réplicas dos pods com base no uso de recursos, como CPU ou memória.

```bash
  kubectl get service ${name}-service
``` 
Obter o ip publico do serviço

## Github Actions

```bash
  az ad sp create-for-rbac --name terraform --sdk-auth --role Contributor --scopes /subscriptions/123e4567-e89b-12d3-a456-426614174000/resourceGroups/my-resource-group
``` 


- Altere o ID da subscription (123e4567-e89b-12d3-a456-426614174000) para o ID da sua subscription no Azure.
- Substitua my-resource-group pelo nome do seu Resource Group real no Azure

Vá até o repositório no GitHub.
- Navegue para "Settings" > "Secrets and variables" > "Actions".
- Clique em "New repository secret" e adicione uma nova variável com o nome - AZURE_CREDENTIALS.
- No campo de valor, cole o JSON gerado pelo comando az ad sp create-for-rbac.
- Salve o segredo.
