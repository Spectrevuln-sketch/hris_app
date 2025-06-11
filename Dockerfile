FROM python:3.10-slim-bullseye

ENV PYTHONUNBUFFERED=1

RUN apt-get update && apt-get install -y libcairo2-dev gcc netcat dos2unix

WORKDIR /app/

COPY . .

# Convert all files to LF to avoid \r issues
RUN find . -type f \( -name "*.html" -o -name "*.py" -o -name "*.sh" \) -exec dos2unix {} \; \
  && chmod +x /app/entrypoint.sh

RUN pip install -r requirements.txt

EXPOSE 8777

# CMD ["sh", "/app/entrypoint.sh"]