variable "region" {
  description = "Región de AWS donde se creará la infraestructura"
  type        = string
  default     = "us-east-1"
}

variable "ami_id" {
  description = "ID de la AMI"
  type        = string
  default     = "ami-0731becbf832f281e"
}

variable "instance_type" {
  description = "Tipo de instancia"
  type        = string
  default     = "t2.small"
}

variable "key_name" {
  description = "Nombre de la clave SSH"
  type        = string
  default     = "vockey"
}

# Definir los puertos de los grupos de seguridad
variable "frontend_ports" {
  type        = list(number)
  default     = [22, 80, 443]
}

variable "backend_ports" {
  type        = list(number)
  default     = [22, 3306]
}

variable "nfs_ports" {
  type        = list(number)
  default     = [2049]
}

variable "lb_ports" {
  type        = list(number)
  default     = [80, 443]
}
