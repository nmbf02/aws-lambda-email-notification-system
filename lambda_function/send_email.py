import json
import smtplib
from email.message import EmailMessage
import os

def lambda_handler(event, context):
    smtp_server = os.environ['SMTP_SERVER']
    smtp_port = int(os.environ['SMTP_PORT'])
    smtp_user = os.environ['SMTP_USER']
    smtp_password = os.environ['SMTP_PASSWORD']

    for record in event['Records']:
        # Comprobar si el mensaje proviene de SNS
        if 'Sns' in record:
            message = json.loads(record['Sns']['Message'])
        else:
            message = json.loads(record['body'])

        to = message.get('to', '').strip()
        cc = message.get('cc', '').strip()
        bcc = message.get('bcc', '').strip()
        subject = message.get('subject', 'Sin asunto').strip()
        body = message.get('body', 'Mensaje vacío').strip()
        sender = message.get('origen', smtp_user).strip()
        
        # Validar campos obligatorios
        if not to or not sender:
            print("El campo 'to' o 'origen' está vacío. No se enviará el correo.")
            return {
                'statusCode': 400,
                'body': json.dumps('Error: El campo destinatario o el remitente están vacíos.')
            }
        
        # Crear el correo electrónico
        email = EmailMessage()
        email['From'] = sender
        email['To'] = to
        email['Cc'] = cc
        email['Bcc'] = bcc
        email['Subject'] = subject
        email.set_content(body)

        # Mostrar el contenido del mensaje para depuración
        print("Mensaje preparado para enviar:")
        print(email)

        try:
            with smtplib.SMTP(smtp_server, smtp_port) as smtp:
                smtp.ehlo()
                smtp.set_debuglevel(1)
                smtp.starttls()
                smtp.ehlo()
                smtp.login(smtp_user, smtp_password)
                smtp.send_message(email)
            print(f"Correo enviado a {to}")
        except Exception as e:
            print(f"Error al enviar el correo: {e}")

    return {
        'statusCode': 200,
        'body': json.dumps('Procesado con éxito')
    }
