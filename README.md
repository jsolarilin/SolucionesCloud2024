# Obligatorio-SolucionesCloud Marzo 2024
Repositorio para PHP Ecommerce

## Descripción de solución

En este repositorio encontraremos la solución llevada a cabo por el equipo de Juan Ignacio Solari y Juan Manuel Ruiz para desplegar la aplicación php-ecommerce desarrollada en lenguaje PHP y conectada a una base de datos MySQL.

El despliegue de la infraestructura es completamente mediante IaC (Infraestructure As Code).
Las tecnologías que se llevan a cabo son Terraform, Bash Scripting y manifiestos de YAML para impactar los servicios del cluster de EKS (Elastic Kubernetes Services).

### Bash Scripting
![logo](https://github.com/jsolarilin/SolucionesCloud2024/blob/main/ImagesReadme/BashImage.jpg)

Se utiliza bash scripting para desplegar un conjunto de sentencias dentro de un mismo bloque de código.
Dentro de estas sentencias encontramos la sentencia donde actualizamos kubectl con el cluster creado.

Posteriormente se consultan las variables de ouput que arrojó el despliegue de terraform, estos datos son enviadoss a un archivo json el cual utilizaremos para crear el configmap necesario
para realizar el deployment de eks.
Dentro de esta misma lógica, ya que tenemos variables de output que no solo pertenecen a la información de la base de datos se realiza un filtrado de ese archivo creado .json para 
encontrar solo las variables que estén directamente relacionadas con RDS.

Dentro del bloque de código comprendido entre las líneas 25 y 41 tenemos la creación del configmap que nos servirá para establecer la conexión a la base de datos.
Este configmap es necesario para hacer referencia en el manifiesto del deployment.yaml y así tomar los valores correctos para la conexión hacia el endpoint de RDS.

Por último en el bloque de código entre las líneas 56-62 realizamos de manera automatica la ejecución del dump de la base de datos.
Logramos realizar esto mediante la creación del deployment y en consecuencia la ejecución de los pods.
Una vez creados los pods nos conectamos remoto a uno de ellos gracias a la previa consulta y asignación del nombre del pod en una varible que utilizamos para referenciar la conexión.
Posteriormente realizamos el dump de la base de datos con la sentencia "mysql -h $rds_endpoint -P 3306 -u $rds_username -p${rds_password} obligatorio_db < /var/www/html/dump.sql"

También se utilizaron tecnologías de Docker para crear una imagen con todos los componentes necesarios pre instalados y de esta manera tener el ambiente de producción configurado.

### DockerHub
![logo](https://github.com/jsolarilin/SolucionesCloud2024/blob/main/ImagesReadme/dockerhub.png)

Con esta tecnología implementada en nuestro proyecto logramos realizar la configuración del ambiente necesario para los pods ejecutados en el deployment de kubernetes.
En dicha imagen configuramos la instalación de el sistema operativo base CentOS 7, PHP, MySQL 5.7 y Apache(httpd).

Además cargamos el repositorio de la aplicación en el directorio /var/www/html brindada en este curso para tenerla disponible una vez se cree el pod.
El nombre de la imagen se puede encontrar en el path: "Kubernetes/deployment.yaml" yendo al apartado de containers en el manifiesto de kubernetes.

### Terraform
![logo](https://github.com/jsolarilin/SolucionesCloud2024/blob/main/ImagesReadme/TerraformImage.png)

Los servicios que se despliegan mediante Terraform apuntan a recursos de AWS (Amazon Web Services) y se detallan a continuación.
El código desarrollado via terraform está modularizado con la finalidad de tener mayor flexibilidad.

Para cada recurso que se despliega se hizo un módulo con sus respectivas variables.

### Módulos creados

1- **deploy-network** - Contiene el código necesario para realizar el despliegue de toda la arquitectura de networking.

2- **deploy-rds** - Contiene las sentencias necesarias para ejecutar la creación del recurso RDS con la del motor de base de datos MySQL.

3- **deploy-eks** - En este módulo se crean los recursos de el cluster de EKS y el grupo de nodos.

Fuera de los módulos tenemos un archivo **invocador.tf** donde se invocan a estos últimos.
Para esto es necesaria la declaración de las variables fuera de los módudlos y su asignación correspondiente que la encontraremos en 
este archivo: **vars-invocador.tfvars**

### Variables de Output

Las variables de output son necesarias para lograr realizar el script en donde se envía la información que es mandatoria para el deployment de EKS.
Gracias a esta información que nos aparece en consola una vez finalizada la implementación del código de terraform es que logramos ejecutar
el script de manera exitosa.

Los servicios que se despliegan mediante manifiesto de YAML - Kubernetes - EKS apuntan a recursos de EKS y AWS, también se detallan a continuación.

### Recursos desplegados - Terraform

- 1- **VPC**
  - 1.1 - 2 PUBLIC SUBNETS
  - 1.2 - 1 INTERNET GATEWAY
  - 1.3 - 2 SECURITY GROUPS
  - 1.4 - 1 ROUTE TABLE

- 2- **RDS**
  - 2.1 - 1 DATABASE ENGINE
  - 2.2 - 1 DATABASE INSTANCE

- 3- **EKS**
  - 3.1 - 1 CLUSTER EKS
  - 3.2 - 1 EKS GROUP NODE

### YAML - Kubernetes
![logo](https://github.com/jsolarilin/SolucionesCloud2024/blob/main/ImagesReadme/1_IesAKYMAOqBQvMLba801rg.png)

### Recursos desplegados - Manifiesto YAML Kubernetes.

  - 3.3 - 1 NAMESPACE
  - 3.4 - 1 CONFIGMAP
  - 3.5 - 1 SERVICE
  - 3.3 - 1 CLASSIC LOAD BALANCER
  - 3.4 - 1 AUTO SCALING GROUP

## Arquitectura desplegada

A continuación se aprecia la arquitectura desplegada mediante un diagrama general.
Estos diagramas están directamente relacionados con el resultado de la ejecución de este repositorio.

### Diagrama de arquitectura php-ecommerce

![logo](https://github.com/jsolarilin/SolucionesCloud2024/blob/main/ImagesReadme/DiagramaSolucionObligatorioEKSRDSCLB.PNG)

### Imágen ilustrativa del resultado de networking en consola

![logo](https://github.com/jsolarilin/SolucionesCloud2024/blob/main/ImagesReadme/MapaDeRecursosVPC.PNG)

## Ejecución de repositorio

Para lograr ejecutar este repositorio deberán tener instalado en sus equipos:
- 1- **Git**
  - Finalidad: Lograr clonar el repositorio a sus equipos.

- 2- **AWS cli**
  - Finalidad: Lograr conectarse con su cuenta de AWS de manera remota.

- 3- **Terraform**
  - Finalidad:
    - a. Inicializar el repositorio.
    - b. Ejecutar el plan sin impactar.
    - c. Aplicar el repositorio para desplegar recursos.

- 4- **Kubectl**
  - Finalidad: Lograr ejecutar comandos de Kubernetes para realizar deployment de aplicación.

## Procedimiento para impactar repositorio

Una vez tengamos todos los requerimientos mencionados ya instalados en nuestro equipo es momento de proceder a realizar el despliegue del repositorio.

#### Grupo de sentencias a ejecutar:

**git clone https://github.com/jsolarilin/SolucionesCloud2024.git**

**terraform init**

**terraform plan -var-file="vars-invocador.tfvars"**

**terraform apply -var-file="vars-invocador.tfvars"**

###### Nota

Luego de este punto se les pedirá en la terminal que ingresen el password de la base de datos a crear.
Allí deberán especificar la contraseña que deseen y esta será usada para autenticar contra la database instance.
Con esta práctica evitamos colocar la passsword a fuego en el código y este dato al momento de desplegarse en la consola gracias a la variable
de output declarada se trata como sensitive, de este modo evitamos mostrar este dato confidencial en pantalla aumentando la seguridad.

**./deploy-app-kubernetes.sh**

## Validación de aplicación web.

Para confirmar que se haya ejecutado correctamente el script y visualizar el deployment de kubernetes desplegado podemos ejecutar el siguiente comando:

**kubectl get deployment -n php-ecommerce-namespace php-ecommerce**

Si todo funcionó sin errores ya es hora de dirigirnos a nuestra consola de AWS.
Tendremos que navegar hasta la pestaña *EC2 > Load Balancer* y ejecutar la URL que nos proporciona.
Allí veremos la aplicación desplegada y podremos verificar la conexión con la base de datos yendo al apartado *"Login" > "Registrarme"*.

Una vez registrados podremos acceder y con las credenciales digitadas previamente.

Existen aspectos de arquitectura que se deben mejorar si se requiere alta disponibilidad de la aplicación, aumentar eficiencia en el servicio y mejora de seguridad.

Para contemplar la alta disponibilidad podriamos tener la base de datos RDS con modalidad de escritura en una AZ y una copia de esta base de datos con modalidad de solo lectura en una AZ diferente.

Para contemplar la eficiencia del sevicio aumentando la velocidad de respuesta hacia consultas a la aplicación. 
Podriamos implementar el servicio de Elasti Cache para REDIS.
Con este servicio tendremos informacion hit la cual nos permite almacenar datos en memoria para no tener que consultar en el motor de la base de datos cada dato o información solicitada.

Por último para mejorar la seguridad, deberíamos tener al menos 2 subnets privadas.
La primer subnet privada debería alojar a las bases de de datos RDS.
La segunda subnet privada debería alojar el cluster de EKS.

Para lograr conectividad entre estos servicios tendriamos que crear un NAT Gateway para que permita el tráfico saliente de dichos servicios.
De esta manera solo se deja el Classic Load Balancer en la subnet pública.

### Posible diagrama de arquitectura EKS - Aumentando seguridad

![logo](https://github.com/jsolarilin/SolucionesCloud2024/blob/main/ImagesReadme/arquitecturamejorada1.png)

#### Posible diagrama de arquitectura RDS - Aumentando disponibilidad

![logo](https://github.com/jsolarilin/SolucionesCloud2024/blob/main/ImagesReadme/arquitecturamejorada2RDS.png)
