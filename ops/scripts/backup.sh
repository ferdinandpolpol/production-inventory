#!/bin/bash

# Check if the db container is running
if ! docker-compose ps | grep -q 'db.*Up'; then
  echo "Error: db container is not running." >&2
  exit 1
fi

# Check if docker-compose is installed
if ! [ -x "$(command -v docker-compose)" ]; then
  echo 'Error: docker-compose is not installed.' >&2
  exit 1
fi

# Run pg_dump inside the db container and output directly to a file on the host
docker-compose exec db pg_dump -Fc -U postgres postgres > backup.sql

# Check if the backup was successful
if [ $? -ne 0 ]; then
  echo "Error: pg_dump failed." >&2
  exit 1
fi

# Get the current date
current_date_time="$(date +%Y-%m-%d)"

# Upload the backup to S3
aws s3 cp backup.sql s3://amorens-general/backup/$current_date_time.sql

# Check if the S3 upload was successful
if [ $? -ne 0 ]; then
  echo "Error: S3 upload failed." >&2
  exit 1
fi

# Remove the backup file from the host
rm backup.sql

echo "Backup successful and uploaded to S3."
