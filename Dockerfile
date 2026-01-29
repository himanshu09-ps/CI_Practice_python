FROM python:3.10-slim
WORKDIR /app

COPY requirements.txt .
COPY add.py .

RUN pip install -r requirements.txt

CMD ["python", "add.py"]

# docker build [OPTIONS] -t <image-name>:<tag> <build-context>
# docker build -t my-python-app . 

# docker run [OPTIONS] <image-name>:<tag>
# or
# docker run -d --name myapp-container my-python-app:1.0
# Dockerfile  →  docker build  →  IMAGE
# IMAGE       →  docker run    →  CONTAINER (running)
# docker run my-python-app:1.0

# push to docker registry 

# docker tag my-python-app:1.0 <registry-url>/<username-or-project>/my-python-app:1.0
# docker tag my-python-app:1.0 docker.io/myusername/my-python-app:1.0
# docker push <registry-url>/<username-or-project>/my-python-app:1.0



# FROM node:18
# WORKDIR /app

# # Step 1: package.json copy
# COPY package*.json ./

# # Step 2: dependencies install
# RUN npm install

# # Step 3: baki code copy
# COPY . .

# # Step 4: build (agar front-end ho)
# RUN npm run build ...build code like compile and create dist/ for frontend as browser want html css js so 
# put all in dist/ folder after making bundle 

# CMD ["node", "index.js"]




# -----------------------> Multi stage dockerfile example of node 

# Stage 1: Build stage
# FROM node:18 AS build
# WORKDIR /app

# # Install dependencies
# COPY package*.json ./
# RUN npm install

# # Copy source and build
# COPY . .
# RUN npm run build   # Generates dist folder

# # Stage 2: Runtime stage (Nginx)
# FROM nginx:alpine
# COPY --from=build /app/dist /usr/share/nginx/html

# EXPOSE 80
# CMD ["nginx", "-g", "daemon off;"]

# -------------------> Scans for maintaining quality 


# name: CI Security Scans

# on:
#   workflow_dispatch:   # GitHub UI se manual run
#   push:
#     branches: [ main ]

# jobs:
#   security-scan:
#     runs-on: ubuntu-latest

#     steps:
#     # 1️⃣ Checkout code
#     - name: Checkout code
#       uses: actions/checkout@v3

#     # 2️⃣ Secret Scan (API keys, passwords)
#     - name: Secret Scan (Gitleaks)
#       uses: gitleaks/gitleaks-action@v2
#       continue-on-error: false

#     # 3️⃣ Code & Dependency Scan
#     - name: Trivy Filesystem Scan
#       uses: aquasecurity/trivy-action@0.20.0
#       with:/
#         scan-type: fs
#         scan-ref: .
#         severity: HIGH,CRITICAL
#         exit-code: 1

#     # 4️⃣ Build Docker Image
#     - name: Build Docker Image
#       run: |
#         docker build -t myapp:latest .

#     # 5️⃣ Docker Image Vulnerability Scan
#     - name: Trivy Docker Image Scan
#       uses: aquasecurity/trivy-action@0.20.0
#       with:
#         image-ref: myapp:latest
#         severity: HIGH,CRITICAL
#         exit-code: 1

#     # 6️⃣ IaC Scan (Terraform / Kubernetes / CloudFormation)
#     - name: IaC Scan (Checkov)
#       uses: bridgecrewio/checkov-action@v12
#       with:
#         directory: .
#         framework: all
