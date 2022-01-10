#  --------------------------------------------------------------------------------------------------------------------
#  1. CREACIÓN DEL AUTOSCALING GROUP
#  --------------------------------------------------------------------------------------------------------------------
# CENTOS - APACHE
resource "aws_autoscaling_group" "my-centos-ucsp-ec2" {
  launch_configuration = aws_launch_configuration.my-centos-ucsp-ec2.name
  vpc_zone_identifier  = [aws_subnet.public_zone_1a.id, aws_subnet.public_zone_1b.id]

  target_group_arns = [aws_lb_target_group.asg-target-group.arn]
  health_check_type = "ELB"
  
  min_size              = 1
  max_size              = 5
  desired_capacity      = 3

  tag {
    key                 = "Name"
    value               = "Autoscaling-UCSP-001"
    propagate_at_launch = true
  }
}

#  --------------------------------------------------------------------------------------------------------------------
#  2. CREACIÓN DE UN LAUNCH CONFIGURATION
#  --------------------------------------------------------------------------------------------------------------------
# Definicon del AMI y del tipo de instancia
resource "aws_launch_configuration" "my-centos-ucsp-ec2" {
  lifecycle { create_before_destroy = false }
  image_id      = var.image_id
  instance_type = "t2.micro"

  security_groups             = [aws_security_group.instance.id]
  associate_public_ip_address = true
  user_data                   = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              echo "Bienvenidos UCSP al Bootcamp de EC2. Identificador $RANDOM" > /var/www/html/index.html
    EOF
}
