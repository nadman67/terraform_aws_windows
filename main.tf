resource "aws_instance" "my-test-instance" {
  ami             = "ami-0a7f9ce0459523133"
  instance_type   = "t2.micro"
  
  security_groups = [
	"${aws_security_group.allow_ssh.name}",
	"${aws_security_group.allow_hs.name}",
	"${aws_security_group.allow_outbound.name}"
  ]
  key_name = "${aws_key_pair.my-test-key.key_name}"
  
  user_data = "${data.template_file.user_data.rendered}"
  tags {
    Name = "test-instance"
  }
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow-sshrdp"
  description = "Allow SSH inbound traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

    ingress {
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
}

resource "aws_security_group" "allow_hs" {
  name        = "allow-hs"
  description = "Allow HealthShare inbound traffic"

  ingress {
    from_port   = 57772
    to_port     = 57772
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "allow_outbound" {
  name        = "allow-all-outbound"
  description = "Allow all outbound traffic"

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "my-test-key" {
  key_name   = "test-key"
  public_key = "${file("my_test_key.pub")}"
}

data "template_file" "user_data" {
  template = "${file("HS_Install.ps1")}"

}