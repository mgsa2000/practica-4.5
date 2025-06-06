# Configuramos el proveedor de AWS
provider "aws" {
  region = var.region
}


# GRUPOS DE SEGURIDAD

# Grupo de seguridad para el frontend
resource "aws_security_group" "frontend_sg" {
  name        = "frontend-sg"
}

resource "aws_security_group_rule" "frontend_ingress" {
  count             = length(var.frontend_ports)
  security_group_id = aws_security_group.frontend_sg.id
  type              = "ingress"
  from_port         = var.frontend_ports[count.index]
  to_port           = var.frontend_ports[count.index]
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

# Grupo de seguridad para el backend
resource "aws_security_group" "backend_sg" {
  name        = "backend-sg"
}

resource "aws_security_group_rule" "backend_ingress" {
  count             = length(var.backend_ports)
  security_group_id = aws_security_group.backend_sg.id
  type              = "ingress"
  from_port         = var.backend_ports[count.index]
  to_port           = var.backend_ports[count.index]
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

# Grupo de seguridad para  NFS
resource "aws_security_group" "nfs_sg" {
  name        = "nfs-sg"
}

resource "aws_security_group_rule" "nfs_ingress" {
  count             = length(var.nfs_ports)
  security_group_id = aws_security_group.nfs_sg.id
  type              = "ingress"
  from_port         = var.nfs_ports[count.index]
  to_port           = var.nfs_ports[count.index]
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

# Grupo de seguridad para el Load_Balancer
resource "aws_security_group" "lb_sg" {
  name        = "lb-sg"
}

resource "aws_security_group_rule" "lb_ingress" {
  count             = length(var.lb_ports)
  security_group_id = aws_security_group.lb_sg.id
  type              = "ingress"
  from_port         = var.lb_ports[count.index]
  to_port           = var.lb_ports[count.index]
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}


# creacion de instancias EC2

# Frontend 1
resource "aws_instance" "frontend_1" {
  ami             = var.ami_id
  instance_type   = var.instance_type
  key_name        = var.key_name
  security_groups = [aws_security_group.frontend_sg.name]

  tags = {
    Name = "frontend-1"
  }

  root_block_device {
    volume_size = 30
        volume_type = "standard"
  }
}

# Frontend 2
resource "aws_instance" "frontend_2" {
  ami             = var.ami_id
  instance_type   = var.instance_type
  key_name        = var.key_name
  security_groups = [aws_security_group.frontend_sg.name]

  tags = {
    Name = "frontend-2"
  }

 root_block_device {
    volume_size = 30
        volume_type = "standard"
  }

}

# Backend
resource "aws_instance" "backend" {
  ami             = var.ami_id
  instance_type   = var.instance_type
  key_name        = var.key_name
  security_groups = [aws_security_group.backend_sg.name]

  tags = {
    Name = "backend"
  }

 root_block_device {
    volume_size = 30
        volume_type = "standard"
  }

}

# NFS Server
resource "aws_instance" "nfs" {
  ami             = var.ami_id
  instance_type   = var.instance_type
  key_name        = var.key_name
  security_groups = [aws_security_group.nfs_sg.name]

  tags = {
    Name = "nfs"
  }

 root_block_device {
    volume_size = 30
        volume_type = "standard"
  }

}

# Load Balancer
resource "aws_instance" "loadbalancer" {
  ami             = var.ami_id
  instance_type   = var.instance_type
  key_name        = var.key_name
  security_groups = [aws_security_group.lb_sg.name]

  tags = {
    Name = "loadbalancer"
  }

 root_block_device {
    volume_size = 30
        volume_type = "standard"
  }

}

# 
# ips elasticas

resource "aws_eip" "frontend_1_ip" {
  instance = aws_instance.frontend_1.id
}

resource "aws_eip" "frontend_2_ip" {
  instance = aws_instance.frontend_2.id
}

resource "aws_eip" "backend_ip" {
  instance = aws_instance.backend.id
}

resource "aws_eip" "nfs_ip" {
  instance = aws_instance.nfs.id
}

resource "aws_eip" "lb_ip" {
  instance = aws_instance.loadbalancer.id
}






