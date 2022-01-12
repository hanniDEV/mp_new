#--------------------------------------------------------
#                ++++SG++++
module "s_g" {
  source = "../modules/sg"
}
#--------------------------------------------------------
#                ++++EC2++++
module "ec2-prod" {
  source = "../modules/ec2"
  admin = "yamen"
  sg_name = module.s_g.sg_output_name
  instance_type = "t2.micro"
  key_name = "tp_z"
}

#--------------------------------------------------------
#                ++++EBS++++

module "vol_ebs" {
  source = "../modules/ebs"
}

resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdh"
  volume_id   = module.vol_ebs.ebs_Id
  instance_id = module.ec2-prod.ec2_Id
}
#-------------------------------------------------------
#         ++++IP_Pub+++++++


module "eip" {
  source = "../modules/eip"
}

resource "aws_eip_association" "eip_assoc" {
  instance_id   = module.ec2-prod.ec2_Id
  allocation_id = module.eip.eip_alloc_Id
}
#-------------------------------------------------------


resource "file" "find_IP" {
 filename = "file2_ip_ec2.txt" 
 content = "IP_pub est:  ${module.eip.eip-adr}"
}
