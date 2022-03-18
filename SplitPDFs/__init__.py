import logging
import base64
import io
import PyPDF2
import json
import os
import datetime
import azure.functions as func


def main(req: func.HttpRequest) -> func.HttpResponse:
    logging.info('Python HTTP trigger function processed a request.')

    # Get the request body from previous step in Logic App
    req_body = req.get_json()
    file_name = req_body.get('fileName')
    file_content = req_body['fileContent']['$content']

    # Convert file content to bytes
    file_data = base64.decodebytes(file_content.encode())

    # Generate date time object of the run
    dt = datetime.datetime.now().strftime('%Y-%m-%dT%H-%M-%S')

    # Extract original PDF file name
    pdf_prefix_file_name = ''.join(file_name.split('.pdf')[:1]) + '_'

    # Establish HOME directory for writing/reading temporary files
    HOME_LOCAL_DIR = os.environ['HOME']
    logging.info(f"HOME_DATA_DIR: {HOME_LOCAL_DIR}")
    
    # Open multi-page PDF file
    with io.BytesIO(file_data) as open_pdf_file:
        read_pdf = PyPDF2.PdfFileReader(open_pdf_file)

        # Extract each page and write out to individual files
        pdf_list = []
        for i in range(read_pdf.numPages):
            output = PyPDF2.PdfFileWriter()
            output.addPage(read_pdf.getPage(i))
            
            # Temporarily write PDF to disk
            temp_pdf_fn = pdf_prefix_file_name + str(i + 1) + '_' + dt + str(".pdf")
            temp_pdf_fp = os.path.join(HOME_LOCAL_DIR, temp_pdf_fn)
            with open(temp_pdf_fp, "wb") as outputStream:
                output.write(outputStream)

            # Read back in the PDF to get the bytes-like version
            with open(temp_pdf_fp, 'rb') as temp_pdf_file:
                file_data = base64.b64encode(temp_pdf_file.read()).decode()

                # Record the filename and the bytes-like data of single-page PDF
                ind_pdf = {
                    'fileName': temp_pdf_fn,
                    'fileContent': file_data
                }

            pdf_list.append(ind_pdf)
    
    # Finalize response object
    respObj = {
        'individualPDFs': pdf_list
    }

    return func.HttpResponse(body=json.dumps(respObj))
