# Configurar proveedor
provider "aws" {
    region = "us-east-1"
}

# Crear instancia de EC2
resource "aws_instance" "EC2-1" {
    instance_type = "t3.micro"
    ami = "ami-052064a798f08f0d3"

    tags = {
        Name = "Terraform-Maquina-1"
    }
}

resource "aws_instance" "EC2-2" {
    instance_type = "t3.micro"
    ami = "ami-052064a798f08f0d3"

    tags = {
        Name = "Terraform-Maquina-2"
    }
}