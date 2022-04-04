# Form Recognizer Solution Accelerator

Accelerate your Form Recognizer solution to production with this Solution Accelerator, which leverages an Azure Function and a set of Logic Apps to split multi-page PDF files to single-page PDF files and sends individual PDF files to the REST API endpoint of a trained custom document model in Form Recognizer.

This solution implements two capabilities that are commonly required when working with a trained custom document model: 

  1. Splitting multi-page PDF documents into individual, single-page PDF documents
  2. Analyzing the results of documents sent to the Form Recognizer REST API endpoint of a trained custom document model

Please reference [this blog post](https://techcommunity.microsoft.com/t5/ai-cognitive-services-blog/form-recognizer-solution-accelerator/ba-p/3262782) for detailed, step-by-step instructions for how to implement this solution. We are also actively working on organizing the same step-by-step instructions in this repository.

---

## Step 1: [Deploy core resources to Azure](https://github.com/stevedem/FormRecognizerAccelerator/blob/main/docs/01-deploy-to-azure.md)

Using the below button, six Azure services will be deployed:

  * Storage account
  * Function app
  * App Service plan
  * Form Recognizer
  * Logic app (x2)

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fstevedem%2FFormRecognizerAccelerator%2Fmain%2Finfrastructure%2Fazuredeploy.json)

## Step 2: [Create containers & upload data](https://github.com/stevedem/FormRecognizerAccelerator/blob/main/docs/02-storage-account-containers-upload-data.md)

Download [sample data]() from this repository and upload it into the new containers you create.

## Step 3: Train custom document model

Open the [Form Recognizer Studio](https://formrecognizer.appliedai.azure.com/studio/) and train a custom document model.

## Step 4: Deploy open-source Python code to split PDFs

Deploy [open-source Python code](https://github.com/stevedem/splitpdfs) to your Function App to split multi-page PDF files.

## Step 5: Configure Logic App to split multi-page PDF documents to single-page PDF documents

Create a Logic App to call your Azure Function App and save individual PDF files based on a multi-page PDF file input.

## Step 6: Configure Logic App to send single-page PDF document data to REST API endpoint of trained custom document model

Leverage the REST API endpoint of a trained custom document model in Form Recognizer.
