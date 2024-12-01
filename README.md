# Crontab with Docker Example

This project demonstrates how to set up and use a simple Python script executed via a cron job inside a Docker container.

## Project Structure

- **`app.py`**: A Python script containing a `job()` function that prints a message to the console.
- **`crontab`**: A crontab file that schedules the `app.py` script to run every minute.
- **`Dockerfile`**: A Dockerfile that sets up the environment to run the cron job inside a container.

---

## Files Overview

### 1. `app.py`

This script defines a simple function that prints "crontab try" to the console.

```python
def job():
    print("crontab try")

job()
```

### 2. `crontab`
This file schedules the app.py script to run every minute using the cron service.
```crontab
* * * * * python3 /app.py
```

### 3. `Dockerfile`  
The Dockerfile creates an Alpine-based image with Python and cron support, configures the cron job, and runs the cron service.
```Dockerfile
FROM python:3.6.12-alpine3.12

COPY app.py /
COPY crontab /crontab

RUN chmod +x /app.py
RUN crontab /crontab

CMD ["crond", "-f"]

```

- **Base Image**:  Uses a lightweight Alpine-based Python image.
- **File Copying**: Copies app.py and crontab to the container.
- **Permissions**:  Makes app.py executable.
- **Cron Configuration**: Installs the crontab file and starts the cron service.

---

## Usage
### Step 1: Build the Docker Image
Run the following command to build the Docker image:
```
docker build -t crontab-docker-example .
```

### Step 2: Run the Container
Start a container using the image:
```
docker run -it crontab-docker-example
```
The cron job will run every minute, and the output will be logged to the container logs.

### Step 3: Check the Output
To verify that the Python script is running, check the container logs:
```
docker logs <container_id>
```
Replace `<container_id>` with the actual container ID, which can be obtained using:
```
docker ps
```

### Notes
- The app.py script and crontab file are copied to the root directory (/) in the container.
- Ensure the cron service is started with the CMD instruction in the Dockerfile.
- The cron job is scheduled to run every minute (* * * * *). You can modify this schedule in the crontab file.

For understand to schedule expression, you can visit: [https://crontab.guru/#*_*_*_*_*](https://crontab.guru/#*_*_*_*_*)
