# Implementing this Solution

## Deploy Resources to Azure

To implement this solution, go to the following GitHub repository and/or click the "Deploy to Azure" button.

 

[stevedem/FormRecognizerAccelerator (github.com)](https://github.com/stevedem/FormRecognizerAccelerator)

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fstevedem%2FFormRecognizerAccelerator%2Fmain%2Finfrastructure%2Fazuredeploy.json)

After clicking Deploy to Azure, you will be asked to fill out the following fields:
![Custom Deployment](images/008-deploy-to-azure.jpg)

Once the deployment succeeds, you should see six resources in your resource group.

![Deployment Results](images/009-deploy-results.jpg)

Please note that this will only deploy the core infrastructure. There are a few steps to configure each service once deployed.

 

Each configuration is divided into these sections:

 

- **Storage Account** - create containers & upload data
- **Form Recognizer** - train custom document model
- Function App - deploy open-source Python code to split PDFs
- **Split PDFs Logic App** - split multi-page PDF documents to single-page PDF documents
- **Analyze Results Logic App** - send single-page PDF document data to REST API endpoint of trained custom document model

## Next Steps

[Implement this Solution - Storage Account - create containers & upload data](02-storage-account-containers-upload-data.md)