resource "aws_instance" "ec2_instance" {
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = var.subnet_id

  tags = {
    Name = var.name
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("~/.ssh/id_rsa")
    timeout     = "2m"
    host        = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install software-properties-common -y",
      "sudo add-apt-repository --yes --update ppa:ansible/ansible",
      "sudo apt-get update",
      "sudo apt-get install ansible -y",
      "ansible-playbook /tmp/playbook.yml"
    ]
  }

  provisioner "file" {
    source = "playbook.yml"
    destination = "/tmp/playbook.yml"
  }

  provisioner "local-exec" {
    command = "ansible-playbook -i '${self.public_ip},' playbook.yml"
  }
}