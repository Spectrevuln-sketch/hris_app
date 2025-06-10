FROM python:3.10-slim-bullseye

ENV PYTHONUNBUFFERED=1

RUN apt-get update && apt-get install -y libcairo2-dev gcc netcat dos2unix

WORKDIR /app/

COPY . .

RUN dos2unix /app/entrypoint.sh && chmod +x /app/entrypoint.sh

RUN pip install -r requirements.txt

EXPOSE 8777

# CMD ["python3", "manage.py", "runserver"]
CMD ["./entrypoint.sh"]
