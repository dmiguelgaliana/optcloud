# Exercici Terraform 2

## Objectiu
Crear una infraestructura a AWS amb una VPC, 3 subxarxes i 6 instàncies EC2 tipus `t3.micro` amb **Amazon Linux 2023** a la regió `us-east-1`.

---

## Configuració Terraform
El fitxer `main.tf` defineix:
- El proveïdor AWS amb la regió `us-east-1`
- 1 VPC
- 3 subxarxes (SubnetA, SubnetB, SubnetC)
- 1 grup de seguretat amb accés SSH (port 22)
- 6 instàncies EC2 (`t3.micro`), 2 per subxarxa

### Execució

```bash
terraform init
terraform plan
terraform apply
```

![Topologia Ejercicio 2](/exercicis/pt1-3-ex2/assets/Imatges/Topologia2.png)
Aquí tenemos la Topologia del Ejercicio 2.