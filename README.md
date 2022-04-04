# Form Recognizer Solution Accelerator

Accelerate your Form Recognizer solution to production with this Solution Accelerator, which leverages an Azure Function and a set of Logic Apps to split multi-page PDF files to single-page PDF files and sends individual PDF files to the REST API endpoint of a trained custom document model in Form Recognizer.

This solution implements two capabilities that are commonly required when working with a trained custom document model: 

  1. Splitting multi-page PDF documents into individual, single-page PDF documents
  2. Analyzing the results of documents sent to the Form Recognizer REST API endpoint of a trained custom document model

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fstevedem%2FFormRecognizerAccelerator%2Fmain%2Finfrastructure%2Fazuredeploy.json)
