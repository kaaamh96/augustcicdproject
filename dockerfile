FROM python:3.12-bookworm

WORKDIR /app

COPY . .

RUN pip install --no-cache-dir flask

EXPOSE 5002

CMD ["python", "app.py"]
