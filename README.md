# AWS Lambda Email Notification System

Este proyecto implementa un sistema de notificación por correo electrónico basado en una arquitectura serverless utilizando AWS Lambda, AWS SQS, AWS SNS, AWS CloudWatch y Terraform para la infraestructura.

---

## **Objetivo**
El objetivo es desarrollar un sistema automatizado que envíe un correo electrónico cada vez que se reciba un mensaje en una cola de AWS SQS, gestionando las suscripciones mediante AWS SNS y monitorizando el proceso con AWS CloudWatch.

---

## **Características**
- **AWS Lambda:** Procesamiento de eventos y envío de correos electrónicos con Python.
- **AWS SQS:** Cola de mensajes para disparar la Lambda.
- **AWS SNS:** Distribución de mensajes a SQS.
- **AWS CloudWatch:** Monitoreo y alertas.
- **Terraform:** Infraestructura como código (IaC).

---

## **Estructura del Proyecto**

```bash
aws-lambda-email-notification-system/
│
├── terraform/               # Infraestructura en Terraform
│   ├── main.tf              # Configuración principal
│   ├── variables.tf         # Variables de entorno
│   ├── outputs.tf           # Salidas de Terraform
│   └── provider.tf          # Proveedor AWS
│
├── lambda_function/         # Código de la función Lambda
│   ├── send_email.py        # Función para enviar correos electrónicos
│   ├── requirements.txt     # Dependencias de Python
│   └── config.json          # Configuración de correo SMTP
│
└── README.md                # Documentación del proyecto
```

---

## **Requisitos Previos**

1. **Herramientas necesarias**:
   - [Terraform](https://www.terraform.io/downloads)
   - [AWS CLI](https://aws.amazon.com/cli/)
   - Python 3.x y pip

2. **Configuración de AWS CLI**:
```bash
aws configure
```
Introduce tus credenciales de acceso a AWS y selecciona la región adecuada.

---

## **Configuración del Proyecto**

### 1. **Clonar el Repositorio**

```bash
git clone https://github.com/nmbf02/aws-lambda-email-notification-system.git
cd aws-lambda-email-notification-system
```

---

### 2. **Configuración de Terraform**

```bash
cd terraform
terraform init
terraform plan
terraform apply
```

Esto creará:

- Una función Lambda en AWS
- Un tópico SNS y una cola SQS conectada
- Políticas de IAM necesarias
- Monitoreo con CloudWatch

---

### 3. **Configuración de la Función Lambda**

```bash
cd lambda_function
pip install -r requirements.txt -t .
zip -r function.zip .
aws s3 cp function.zip s3://<nombre-del-bucket-s3>/
```

Actualiza el archivo `main.tf` en Terraform con la URL correcta del bucket S3.

---

### 4. **Configuración de Correo SMTP**

Edita el archivo `config.json`:

```json
{
  "smtp_server": "smtp.tu-dominio.com",
  "smtp_port": 587,
  "username": "tu-email@dominio.com",
  "password": "tu-contraseña-segura"
}
```

Guarda las credenciales de forma segura, preferiblemente utilizando AWS Secrets Manager.

---

### 5. **Prueba del Sistema**

Envía un mensaje a la cola SQS:

```bash
aws sqs send-message --queue-url <URL_DE_TU_COLA_SQS> --message-body '{"to": "destino@correo.com", "cc":"cc@correo.com", "bcc":"bcc@correo.com", "origen":"notificaciones@tu-dominio.com"}'
```

---

### 6. **Monitoreo y Alertas en CloudWatch**

Revisa el estado de las métricas en el panel de CloudWatch:

- Errores en la función Lambda.
- Longitud de la cola SQS.
- Configura alarmas para recibir notificaciones si algo falla.

---

## **Solución de Problemas**

1. **Errores de Permisos:** Revisa las políticas de IAM en Terraform.
2. **Problemas de Conexión SMTP:** Verifica las credenciales y la configuración del servidor de correo.
3. **Errores en Lambda:** Revisa los logs en AWS CloudWatch.

---

##  **Contribución**

¿Te gustaría mejorar este proyecto? ¡Las contribuciones son bienvenidas! Por favor, crea un fork del repositorio y abre un pull request.

---

## **Contacto**

¿Tienes alguna pregunta o sugerencia? Puedes contactarme en [LinkedIn](https://www.linkedin.com/in/nathalyberroa/) o revisar mi [GitHub](https://github.com/nmbf02).
