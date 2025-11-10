🎯 Objectiu
Desplegar una infraestructura bàsica a AWS utilitzant Terraform, amb subxarxes públiques i privades, instàncies EC2, un bucket S3 condicional, i outputs detallats. Tot ha de ser parametritzable mitjançant variables.

🧩 Pas 1: Configuració inicial
Crear un fitxer variables.tf amb les següents variables:

region: Regió AWS

project_name: Nom del projecte

instance_count: Nombre d’instàncies per subnet

subnet_count: Nombre de subxarxes per tipus (públiques i privades)

instance_type: Tipus d’instància (ex: t3.micro)

instance_ami: AMI d’Amazon Linux

create_s3_bucket: Crea bucket S3 si és true

vpc_cidr: Xarxa CIDR (10.0.0.0/16)

my_ip: Xarxa CIDR per SSH (per defecte 0.0.0.0/0)

Crear un fitxer provider.tf on es defineix el proveïdor fent servir la variable region.

🌐 Pas 2: Xarxa i subxarxes
Crear una VPC amb el CIDR definit a vpc_cidr

Crear 2 subxarxes públiques i 2 privades utilitzant count o for_each, segons la variable subnet_count

Crear un Internet Gateway (IGW) i associar-lo a la VPC

Crear una taula de rutes pública amb ruta per defecte (0.0.0.0/0) cap a l’IGW

Associar la taula de rutes a les subxarxes públiques

🛡️ Pas 3: Instàncies EC2
Crear un Security Group que:

Permeti HTTP (port 80) des de qualsevol IP

Permeti SSH (port 22) només des de la IP de l’institut o casa (my_ip)

Permeti ICMP només des de dins la VPC

Permeti tot el trànsit sortint cap a qualsevol IP

Crear instàncies EC2 públiques i privades amb count o for_each

Assignar-les correctament a les subxarxes corresponents

Utilitzar la clau vockey i etiquetar-les amb el nom del projecte

🪣 Pas 4: Bucket S3 condicional
Crear un bucket S3 només si create_s3_bucket = true

Utilitzar condicions (count = var.create_s3_bucket ? 1 : 0) per controlar la creació

📤 Pas 5: Outputs
Crear un fitxer outputs.tf que:

Retorni les ID, IP pública i IP privada de totes les instàncies EC2

Retorni el nom del bucket S3 si s’ha creat

📌 Requisits addicionals
Afegir tags amb el nom del projecte a tots els recursos

Documentar cada recurs amb comentaris explicatius

Utilitzar depends_on quan sigui necessari per gestionar dependències entre recursos

📁 Estructura de carpetes a GitHub
Código
📁 exercicis
├── 📁 pt-1-5
│   ├── 📁 assets
│   │   └── 🖼️ Imatges (opcionales, diagrama de la infraestructura, captures, etc.)
│   ├── 📄 README.md          # Explicació de l'exercici i instruccions pas a pas
│   ├── 📄 main.tf            # Fitxer principal amb els recursos Terraform
│   ├── 📄 variables.tf       # Variables definides per l'exercici
│   ├── 📄 outputs.tf         # Outputs definits per l'exercici
│   └── 📄 provider.tf        # Configuració del provider AWS
🚀 Guia de desplegament

Inicialitza Terraform:

bash
terraform init

Previsualitza el pla:

bash
terraform plan

Aplica la infraestructura:

bash
terraform apply
Confirma amb yes quan se’t demani.

Puc afegir una taula de validació ràpida amb els recursos desplegats i com comprovar-los a AWS si vols deixar el README encara més complet.