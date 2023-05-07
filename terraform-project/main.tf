provider "aws" {
  region = "us-east-1"
  access_key = ""
  secret_key = ""
}

module "vpc" {
  source = "./modules/vpc"
}

module "subnet" {
  source = "./modules/subnet"
  vpc_id = module.vpc.aws_vpc
}

module "gateway" {
  source = "./modules/gateway"
  vpc_id = module.vpc.vpc_id
  subnet_id = module.subnet.public_subnet_id
}

module "ec2-instance-1" {
  source = "./modules/ec2-instance-1"
  vpc_id = module.vpc.vpc_id
  subnet_id = module.subnet.private_subnet_id
  instance_type = "t2.micro"
  ami = "ami-08815c483b8bcfc3e"
  name = "ec2-instance-1"
}

#module "ec2-instance-2" {
  #source = "./modules/ec2-instance-2"
  #vpc_id = module.vpc.vpc_id
  #subnet_id = module.subnet.private_subnet_id
#}

#module "ec2-instance-3" {
  #source = "./modules/ec2-instance-3"
  #vpc_id = module.vpc.vpc_id
  #subnet_id = module.subnet.private_subnet_id
#}
