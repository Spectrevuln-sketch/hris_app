#!/bin/sh

# Konversi line endings ke Unix format
sed -i 's/\r$//' t.sh

# Tunggu database siap (contoh dengan PostgreSQL)
while ! nc -z $DB_HOST $DB_PORT; do
  sleep 1
done

# Jalankan perintah dengan format yang benar
python3 manage.py makemigrations
python3 manage.py migrate
python3 manage.py collectstatic --no-input  # Ganti opsi
python3 manage.py createhorillauser --first_name admin ...  # Pastikan email unik
gunicorn --bind 0.0.0.0:8777 horilla.wsgi:application