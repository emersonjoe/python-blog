FROM python:3.12

WORKDIR /app

# Instala ferramentas de compilação
RUN apt-get update && apt-get install -y clang build-essential



# Copia todo o projeto antes de instalar dependências
COPY . .


RUN pip install --no-cache-dir -r requirements.txt

# Remove pacotes usados apenas para compilação
RUN apt-get purge -y clang build-essential && apt-get autoremove -y

EXPOSE 8000

# Usa o gunicorn da .venv
CMD ["gunicorn", "mysite.wsgi", "--bind", "0.0.0.0:8000", "--log-file", "-"]
