output "frontend_1_ip" {
  value = aws_eip.frontend_1_ip.public_ip
}

output "frontend_2_ip" {
  value = aws_eip.frontend_2_ip.public_ip
}

output "backend_ip" {
  value = aws_eip.backend_ip.public_ip
}

output "nfs_ip" {
  value = aws_eip.nfs_ip.public_ip
}

output "lb_ip" {
  value = aws_eip.lb_ip.public_ip
}
