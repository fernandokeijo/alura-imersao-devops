# Use uma imagem base oficial do Python.
# A versão 'slim' é menor e contém o mínimo necessário para rodar a aplicação.
# https://hub.docker.com/_/python
FROM python:3.10-slim

# Define o diretório de trabalho no contêiner para /app
WORKDIR /app

# Copia o arquivo de dependências primeiro para aproveitar o cache de camadas do Docker.
# Se o requirements.txt não mudar, o Docker reutilizará a camada de dependências instaladas.
COPY requirements.txt .

# Instala as dependências do projeto
RUN pip install --no-cache-dir -r requirements.txt

# Copia o restante do código da aplicação para o diretório de trabalho
COPY . .

# Expõe a porta 8000 para que a aplicação possa ser acessada de fora do contêiner
EXPOSE 8000

# Comando para executar a aplicação quando o contêiner iniciar.
# O host 0.0.0.0 é necessário para que o servidor seja acessível externamente.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]