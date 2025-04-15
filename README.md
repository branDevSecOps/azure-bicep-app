🚀 Azure Flask App Deployment (Project 4)

This project demonstrates how to deploy a Dockerized Flask web application to Azure using Bicep for infrastructure as code, Azure Container Registry for storing the image, and Azure App Service for hosting the app.

🌐 Live Demo

Visit: https://.azurewebsites.net

🧰 Tech Stack

Tool

Purpose

Flask

Lightweight Python web framework

Docker

Containerize the Flask app

Azure Bicep

Infrastructure-as-Code (IaC)

Azure CLI

Resource provisioning & auth

Azure Container Registry (ACR)

Docker image hosting

Azure App Service

Deploy containerized app

📁 Project Structure

azure-app/
├── Dockerfile
├── app/
│   └── app.py
│   └── requirements.txt
├── main.bicep
└── .github/
    └── workflows/
        └── deploy.yml (optional, CI/CD)

🚀 Deployment Steps

🔨 1. Build and Run Locally

docker build -t my-azure-flask-app .
docker run -p 8080:80 my-azure-flask-app

Browse to http://localhost:8080

☁️ 2. Deploy Azure Resources with Bicep

az login
az account set --subscription <your-subscription-id>
az group create --name flask-rg --location eastus
az deployment group create \
  --resource-group flask-rg \
  --name flaskDeployment \
  --template-file main.bicep

🐳 3. Push Docker Image to ACR

az acr login --name <your-acr-name>
docker tag my-azure-flask-app <your-acr-name>.azurecr.io/my-azure-flask-app:latest
docker push <your-acr-name>.azurecr.io/my-azure-flask-app:latest

🔁 4. Restart App to Pull New Image

az webapp restart \
  --name <your-webapp-name> \
  --resource-group flask-rg

Get the live app URL:

az webapp show \
  --name <your-webapp-name> \
  --resource-group flask-rg \
  --query defaultHostName -o tsv

💡 Lessons Learned

Building out Azure App Services from scratch with Bicep

Working with Azure Container Registry & ACR login

How to securely inject Docker credentials into App Services

Debugging issues with quotas, deployment timing, and auth

g
🧠 Author

Brandon Lester 
YouTube: Brandevops
LinkedIn: linkedin.com/in/brandonmlester

📜 License

MIT
