resource "aws_eip" "example" {
  vpc = true
}



output "eip_alloc_Id" {
  value = aws_eip.example.allocation_id 
}

#------------
output "eip-adr" {
  value = aws_eip.example.public_ip
}
#---------------