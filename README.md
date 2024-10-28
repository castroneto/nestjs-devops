
## Deploy

Para fazer o deploy desse projeto rode

```bash
  cd infra
```

Para criar autenticação no azure

```bash
  az login
```
Para fazer o deploy desse projeto

```bash
  terraform init
  terraform apply
```

| Month    | desciption |   example  |
| -------- | ------- |------- |
| name  | nome do projeto |   evilcorp   |
| location | Local onde os recursos serão provisionados.| australiacentral   |
| subscription    | id da subscrição  |    |
| resource_group  |  grupo de recursos |  rg-evilcorp |

## Publicar uma Imagem Docker no Azure Container Registry
```bash
  cd ..
  az acr login --name <NOME_DO_ACR>
```
Este comando autentica você no ACR usando o Azure CLI. O <NOME_DO_ACR> deve ser substituído pelo nome do seu registro no Azure. Após a autenticação, você poderá interagir com o ACR, como fazer o upload de imagens Docker.

```bash
  docker build -t <NOME_DO_ACR>.azurecr.io/<NOME_DA_IMAGEM>:latest .
```
Este comando cria uma imagem Docker a partir do seu projeto local. Ele utiliza o arquivo Dockerfile presente no diretório atual para construir a imagem. O nome da imagem é formatado para incluir o ACR onde ela será armazenada.

```bash
  docker push <NOME_DO_ACR>.azurecr.io/<NOME_DA_IMAGEM>:latest
```
Este comando faz o upload da imagem Docker que você acabou de construir para o ACR. Isso torna a imagem disponível no registro para ser utilizada por outros serviços, como o Kubernetes ou Azure App Services.


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
  kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/cloud/deploy.yaml
``` 
 instala o Ingress Controller NGINX no cluster Kubernetes.
 
 ```bash
   kubectl apply -f k8s/ingress.yaml
``` 
aplica as configurações definidas no arquivo ingress.yaml para criar um recurso de Ingress no cluster Kubernetes.

```bash
  kubectl set image deployment/<NOME_DA_IMAGEM> node-app=<NOME_DO_ACR>.azurecr.io/<NOME_DA_IMAGEM>:latest
``` 
atualiza a imagem de um deployment no Kubernetes, substituindo a imagem existente por uma nova versão hospedada no Azure Container Registry (ACR).

```bash
  kubectl get ingress ${name}-app-ingress
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
