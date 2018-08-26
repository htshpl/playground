# todo:
# secure group which allows traffic from port 22 and 8080
# rethink way to store public_key
# tune ec2 instance

provider "aws" {
  region = "us-east-2"
}

resource "aws_instance" "webserver" {
  ami = "ami-0552e3455b9bc8d50"
  instance_type = "t2.micro"
 
  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World" > index.html
              nohup busybox httpd -f -p "${var.server_port}" &
              EOF

  tags {
    Name = "webserver"
  }

  key_name = "deployer-key"
}

resource "aws_key_pair" "default_keypair" {
  key_name = "deployer-key"
  public_key = "ssh-rsa ..."
}