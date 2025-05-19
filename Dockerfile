# Dockerfile
FROM python:3.10-slim

# 1) Install Chrome + driver + OS libs
RUN apt-get update && \
    apt-get install -y chromium chromium-driver \
       libglib2.0-0 libnss3 libgconf-2-4 libfontconfig1 \
       libx11-xcb1 libxcomposite1 libxcursor1 libxdamage1 \
       libxi6 libxtst6 libxrandr2 libxss1 libxext6 libxrender1 \
       ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# 2) Upgrade pip and install Python deps
WORKDIR /app
COPY requirements.txt .
RUN pip install --upgrade pip && \
    pip install -r requirements.txt   # :contentReference[oaicite:0]{index=0}

# 3) Copy the rest of your bot code
COPY . .

# 4) Tell undetected-chromedriver where to find Chrome
ENV CHROME_BIN=/usr/bin/chromium
ENV CHROMEDRIVER_PATH=/usr/bin/chromedriver

# 5) Start your bot (e.g. quickstart or auto_swipe)
CMD ["python3", "quickstart.py"]
