resource "aws_ebs_volume" "ebs" {
  availability_zone = "us-east-1a"
  size              = var.ebs_size

  tags = {
    Name = "ebs_yamen"
  }
}



output "ebs_Id" {
 
  value = aws_ebs_volume.ebs.id

}

