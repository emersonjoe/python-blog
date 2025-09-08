FROM python:3.12

WORKDIR /app

# Instala ferramentas de compilação
RUN apt-get update && apt-get install -y clang build-essential



# Copia todo o projeto antes de instalar dependências
COPY . .

# Instala dependências de produção com PDM
RUN pip install --no-cache-dir -r requirements.txt

# Remove pacotes usados apenas para compilação
RUN apt-get purge -y clang build-essential && apt-get autoremove -y

EXPOSE 8000

# Usa o gunicorn da .venv
CMD ["/app/.venv/bin/gunicorn", "app.wsgi:application", "--bind", "0.0.0.0:8000"]
