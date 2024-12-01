FROM python:3.6.12-alpine3.12

COPY app.py /
COPY crontab /crontab

RUN chmod +x /app.py
RUN crontab /crontab

CMD ["crond", "-f"]