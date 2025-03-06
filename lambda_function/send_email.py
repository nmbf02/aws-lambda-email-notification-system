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
        message = json.loads(record['body'])

        to = message.get('to', '')
        cc = message.get('cc', '')
        bcc = message.get('bcc', '')
        subject = message.get('subject', 'Sin asunto')
        body = message.get('body', 'Mensaje vacío')
        sender = message.get('origen', smtp_user)

        # Crear el correo electrónico
        email = EmailMessage()
        email['From'] = sender
        email['To'] = to
        email['Cc'] = cc
        email['Bcc'] = bcc
        email['Subject'] = subject
        email.set_content(body)

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
