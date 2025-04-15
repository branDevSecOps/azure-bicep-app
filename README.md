# 🚀 Azure Flask App Deployment (Project 4)

This project demonstrates how to deploy a Dockerized Flask web application to Azure using Bicep for infrastructure as code, Azure Container Registry for storing the image, Azure App Service for hosting the app, and GitHub Actions for continuous deployment.

---

## 🧰 Tech Stack

| Tool            | Purpose                          |
|-----------------|----------------------------------|
| Flask           | Lightweight Python web framework |
| Docker          | Containerize the Flask app       |
| Azure Bicep     | Infrastructure-as-Code (IaC)     |
| Azure CLI       | Resource provisioning & auth     |
| Azure Container Registry (ACR) | Docker image hosting         |
| Azure App Service | Deploy containerized app       |
| GitHub Actions  | CI/CD automation pipeline        |

---

## 📁 Project Structure

```
azure-app/
├── Dockerfile
├── app/
│   └── app.py
│   └── requirements.txt
├── main.bicep
└── .github/
    └── workflows/
        └── deploy.yml
```

---

## 🚀 Deployment Steps

### 🔨 1. Build and Run Locally
```bash
docker build -t my-azure-flask-app .
docker run -p 8080:80 my-azure-flask-app
```
Browse to `http://localhost:8080`

---

### ☁️ 2. Deploy Azure Resources with Bicep
```bash
az login
az account set --subscription <your-subscription-id>
az group create --name flask-rg --location eastus
az deployment group create \
  --resource-group flask-rg \
  --name flaskDeployment \
  --template-file main.bicep
```

---

### 🐳 3. Push Docker Image to ACR
```bash
az acr login --name <your-acr-name>
docker tag my-azure-flask-app <your-acr-name>.azurecr.io/my-azure-flask-app:latest
docker push <your-acr-name>.azurecr.io/my-azure-flask-app:latest
```

---

### 🔁 4. Restart App to Pull New Image
```bash
az webapp restart \
  --name <your-webapp-name> \
  --resource-group flask-rg
```

Get the live app URL:
```bash
az webapp show \
  --name <your-webapp-name> \
  --resource-group flask-rg \
  --query defaultHostName -o tsv
```

---

## 🤖 5. Automated Deployment with GitHub Actions

On each push to the `main` branch, GitHub Actions will:
- Build the Docker image
- Push it to ACR
- Restart the Azure Web App to pull the latest image

Ensure you add the following secret to your GitHub repo:

### 🔐 `AZURE_CREDENTIALS`
Create with:
```bash
az ad sp create-for-rbac --name github-actions-flask \
  --role contributor \
  --scopes /subscriptions/<your-subscription-id>/resourceGroups/flask-rg \
  --sdk-auth
```

Paste the output JSON into GitHub → Settings → Secrets → Actions.

---

## 💡 Lessons Learned
- Building out Azure App Services from scratch with Bicep
- Working with Azure Container Registry & ACR login
- Securely injecting Docker credentials into App Services
- Debugging issues with quotas, deployment timing, and auth
- Automating cloud deployment pipelines with GitHub Actions

---

## 📌 Next Steps
- [x] Add GitHub Actions workflow for CI/CD automation
- [ ] Add Application Insights for monitoring
- [ ] Add custom domain + HTTPS
- [ ] Add staging slots for zero-downtime deployments

---

## 🧠 Author
**Brandon Lester**  
YouTube: [Brandevops](https://www.youtube.com/@brandevops)  
LinkedIn: [linkedin.com/in/brandonmlester](https://www.linkedin.com/in/brandonmlester)

---

## 📜 License
MIT


