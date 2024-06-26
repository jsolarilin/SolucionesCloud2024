# #!/bin/bash

# #Actualizar kubeconfig-update
# aws eks update-kubeconfig --region us-east-1 --name terraform-obligatorio-soluciones-cloud

# #Ejecutar comando para enviar las variables de output a un archivo para poder leerlas
# terraform output -json > terraform_output.json


# # Filtrar solo las variables de RDS
# jq '{rds_db_name: .rds_db_name, rds_endpoint: .rds_endpoint, rds_username: .rds_username, rds_password: .rds_password}' terraform_output.json > rds_output.json

# # Leer las variables de RDS
# rds_endpoint=$(jq -r .rds_endpoint.value rds_output.json)
# rds_username=$(jq -r .rds_username.value rds_output.json)
# rds_password=$(jq -r .rds_password.value rds_output.json)
# rds_db_name=$(jq -r .rds_db_name.value rds_output.json)

# # Aplicar el namespace en Kubernetes
# kubectl apply -f Kubernetes/namespace.yaml

# #Creo el secret para mi contraseña de RDS
# kubectl create secret generic ecommerce-php-secret --from-literal=DB_PASSWORD=${rds_password}

# # Crear el archivo ConfigMap temporal
# cat <<EOF > Kubernetes/temp-configmap.yaml
# apiVersion: v1
# data: 
#   config.php: |-
#     <?php
#         ini_set('display_errors', 1);
#         error_reporting(-1);
#         define('DB_HOST', '${rds_endpoint}');
#         define('DB_USER', '${rds_username}');
#         define('DB_PASSWORD', getenv('DB_PASSWORD'));
#         define('DB_DATABASE', '${rds_db_name}');
        
#     ?>
# kind: ConfigMap
# metadata:
#     creationTimestamp: null
#     name: temp-ecommerce-php-config
# ---
# EOF

# # Aplicar el ConfigMap en Kubernetes
# kubectl create -n php-ecommerce-namespace -f Kubernetes/temp-configmap.yaml

# # Aplicar el deployment en Kubernetes
# kubectl apply -f Kubernetes/deployment.yaml

#!/bin/bash

# Actualizar kubeconfig
aws eks update-kubeconfig --region us-east-1 --name terraform-obligatorio-soluciones-cloud

# Ejecutar comando para enviar las variables de output a un archivo para poder leerlas
terraform output -json > terraform_output.json

# Filtrar solo las variables de RDS
jq '{rds_db_name: .rds_db_name, rds_endpoint: .rds_endpoint, rds_username: .rds_username, rds_password: .rds_password}' terraform_output.json > rds_output.json

# Leer las variables de RDS
rds_endpoint=$(jq -r .rds_endpoint.value rds_output.json)
rds_username=$(jq -r .rds_username.value rds_output.json)
rds_password=$(jq -r .rds_password.value rds_output.json)
rds_db_name=$(jq -r .rds_db_name.value rds_output.json)

# Aplicar el namespace en Kubernetes
kubectl apply -f Kubernetes/namespace.yaml

# Crear el secret para mi contraseña de RDS
# Creo el secret para mi contraseña de RDS en el namespace correcto
kubectl create secret generic ecommerce-php-secret --from-literal=DB_PASSWORD=${rds_password} -n php-ecommerce-namespace


# Crear el archivo ConfigMap temporal
cat <<EOF > Kubernetes/temp-configmap.yaml
apiVersion: v1
data: 
  config.php: |-
    <?php
        ini_set('display_errors', 1);
        error_reporting(-1);
        define('DB_HOST', '${rds_endpoint}');
        define('DB_USER', '${rds_username}');
        define('DB_PASSWORD', getenv('DB_PASSWORD'));
        define('DB_DATABASE', '${rds_db_name}');
    ?>
kind: ConfigMap
metadata:
  name: temp-ecommerce-php-config
  namespace: php-ecommerce-namespace
EOF

# Aplicar el ConfigMap en Kubernetes
kubectl apply -f Kubernetes/temp-configmap.yaml

# Aplicar el deployment en Kubernetes
kubectl apply -f Kubernetes/deployment.yaml

# Esperar a que el pod esté en funcionamiento
kubectl rollout status deployment/php-ecommerce -n php-ecommerce-namespace

# Obtener el nombre del pod
pod_name=$(kubectl get pods -n php-ecommerce-namespace -l app=php-ecommerce-label -o jsonpath="{.items[0].metadata.name}")

# Verificar si el archivo dump.sql existe
if kubectl exec -it $pod_name -n php-ecommerce-namespace -- test -f /var/www/html/dump.sql; then
  echo "El archivo dump.sql existe. Ejecutando el dump de la base de datos."
  # Ejecutar el comando para hacer el dump de la base de datos dentro del pod
  kubectl exec -it $pod_name -n php-ecommerce-namespace -- /bin/sh -c "mysql -h $rds_endpoint -P 3306 -u $rds_username -p${rds_password} obligatorio_db < /var/www/html/dump.sql"
else
  echo "El archivo dump.sql no existe en la ruta especificada."
fi