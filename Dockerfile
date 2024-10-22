# Etapa 1: Build
FROM node:18-alpine AS build

# Setando o diretório de trabalho na imagem
WORKDIR /usr/src/app

# Copiando o arquivo package.json e o package-lock.json
COPY package*.json ./

# Instalando dependências
RUN npm install

# Copiando o restante do código para o diretório de trabalho
COPY . .

# Build da aplicação
RUN npm run build

# Etapa 2: Produção
FROM node:18-alpine AS production

# Setando o diretório de trabalho na imagem
WORKDIR /usr/src/app

# Copiando os pacotes de dependências do build anterior
COPY --from=build /usr/src/app/node_modules ./node_modules
COPY --from=build /usr/src/app/dist ./dist

# Definindo a variável de ambiente para produção
ENV NODE_ENV=production

# Expondo a porta 3000 para acessar a aplicação
EXPOSE 3000

# Comando para iniciar a aplicação
CMD ["node", "dist/main"]