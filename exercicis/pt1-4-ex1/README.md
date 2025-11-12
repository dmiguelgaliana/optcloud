🛠 Exercici: Infraestructura bàsica a AWS amb Terraform

Aquest projecte desplega una infraestructura bàsica a AWS utilitzant Terraform.

🌍 Regió i proveïdor

Proveïdor: AWS

Regió: us-east-1


🧱 Recursos creats

🔹 VPC
Nom: VPC-03
CIDR: 10.0.0.0/16

🔹 Subxarxes públiques

Public Subnet A
CIDR: 10.0.1.0/24
Zona de disponibilitat: us-east-1a
IP pública automàtica: activada


Public Subnet B
CIDR: 10.0.2.0/24
Zona de disponibilitat: us-east-1b
IP pública automàtica: activada


🔹 Internet Gateway i taula de rutes

Internet Gateway associat a la VPC
Taula de rutes pública amb ruta per defecte (0.0.0.0/0) cap a l’Internet Gateway
Associació de la taula de rutes amb les dues subxarxes públiques

🔹 Grup de seguretat
Nom: EC2-SG

Regles:

- Permet connexions SSH des de qualsevol lloc (0.0.0.0/0)
- Permet trànsit ICMP només des de dins de la VPC (10.0.0.0/16)
- Permet tot el trànsit sortint cap a qualsevol destinació

🔹 Instàncies EC2

Tipus: t3.micro
AMI: Amazon Linux 2023 (ami-052064a798f08f0d3)
Clau SSH: vockey
Instàncies:

ec2-a en Public Subnet A

ec2-b en Public Subnet B

Grup de seguretat: EC2-SG


![Topologia Ejercicio 2](/exercicis/pt1-4-ex1/assets/Imatges/Topologia%20practica%202.png)
Aquí tenemos la Topologia del Ejercicio.