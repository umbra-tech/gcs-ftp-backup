FROM google/cloud-sdk:slim

# Install lftp
RUN apt-get update && apt-get install -y lftp python3 
# && rm -rf /var/lib/apt/lists/*

# Set the working directory in the container
WORKDIR /app

# Copy the script into the container
COPY /python/ /app/

# Set the script to be executable
RUN chmod +x /app/

# Install requirements
RUN pip install -r requirements.txt --break-system-packages

# Run the script when the container launches
CMD python3 /app/gcs-ftp-backup.py --gcs_bucket=${GCS_BUCKET} --secret_name=${SECRET_NAME} --remote_dir=${REMOTE_DIR} --local_dir=${LOCAL_DIR} --project_id=${PROJECT_ID}