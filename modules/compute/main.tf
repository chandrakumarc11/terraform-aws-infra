#Security Group

resource "aws_security_group" "web_sg" {

  name   = "web-sg"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


#IAM Role



resource "aws_iam_role" "ec2_role" {

  name = "ec2-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [{
      Effect = "Allow"

      Principal = {
        Service = "ec2.amazonaws.com"
      }

      Action = "sts:AssumeRole"
    }]
  })
}



#SSM Policy


resource "aws_iam_role_policy_attachment" "ssm" {

  role = aws_iam_role.ec2_role.name

  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}



# Instance Profile



resource "aws_iam_instance_profile" "profile" {

  name = "ec2-profile"

  role = aws_iam_role.ec2_role.name
}


# EC2 Instance


resource "aws_instance" "web" {

  ami = var.ami_id

  instance_type = var.instance_type

  subnet_id = var.subnet_id

  vpc_security_group_ids = [
    aws_security_group.web_sg.id
  ]

  iam_instance_profile = aws_iam_instance_profile.profile.name

  user_data = file("${path.root}/user-data.sh")

  tags = {
    Name = "terraform-web-server"
  }
}


# Elastic IP


resource "aws_eip" "web_eip" {

  instance = aws_instance.web.id

  domain = "vpc"
}



