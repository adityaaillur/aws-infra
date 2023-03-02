resource "aws_key_pair" "deployer" {
  key_name   = "ec2-ub"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDDRS9777vz5vG5xmPUrW4ljJN1M9rRXx0s71/Y156lxoAHySXim8SdORyGcLhZ1PN5rxcq2BTYKQ/U0ZdyMx5NLK3ba/gHRBkOxLMjaseMkhJsmHXr0xncF4iflNLVA40sj72hCwUOOgCpLH00M6DlHWr4yBE3Mncr/kUY8H2Ak89SFswQFrWaVS7eSg9y3ktdxrgFX4EKWfx1Syc/rMg4MHR++oDr65JKIsykXfUr8aGECBw9nYz5g6pJUlQxsbuh4MwJVL2xp//Dkpwma+ECBgXbjqCWMjIM/Hx7DrEJqqrH3R8htsjAIcQ/aJPOVtypkQ9P48e6+jvd037mLdyxfkk/NXPA/MiQ1hKiBdy8vLSeVKhY1Luk1KRb4vCXuLuDDv0FxkfCGn1qtbYr6xLvnK6L2d8P7Ed/eR45Fv47NopLi0/lyxZCYb4kG/Mil+ld5R9VfV+vRxxafUbatZlUw9E0kM/RGf5I0InusDvgggF5MNCwJHzCcp2R+Xn7Ag0= adityaillur@illur.local"
}

resource "aws_instance" "ec2_instance" {
  ami                     = var.ami_id
  instance_type           = var.instance_type
  subnet_id               = aws_subnet.public_subnets[0].id
  vpc_security_group_ids  = [aws_security_group.security_group.id]
  key_name                = aws_key_pair.deployer.key_name
  disable_api_termination = false
  depends_on = [
    aws_security_group.security_group
  ]
  root_block_device {
    volume_size = var.instance_volume_size
    volume_type = var.instance_volume_type
  }
  iam_instance_profile = aws_iam_instance_profile.EC2-CSYE6225_instance_profile.name
  tags = {
    Name = "Webapp Instance"
  }
  user_data = <<EOF
    #!/bin/bash
    echo "[Unit]
    Description=Webapp Service
    After=network.target

    [Service]
    Environment="DB_HOST=${element(split(":", aws_db_instance.main.endpoint), 0)}"
    Environment="DB_USER=${aws_db_instance.main.username}"
    Environment="DB_PASSWORD=${aws_db_instance.main.password}"
    Environment="DB_DATABASE=${aws_db_instance.main.db_name}"
    Environment="AWS_BUCKET_NAME=${aws_s3_bucket.private.id}"
    Environment="AWS_REGION=${var.region}"
    Environment="AWS_ACCESS_KEY_ID=${var.AWS_ACCESS_KEY_ID}"
    Environment="AWS_SECRET_ACCESS_KEY=${var.AWS_SECRET_ACCESS_KEY}"
    Type=simple
    User=ec2-user
    WorkingDirectory=/home/ec2-user/webapp
    ExecStart=/usr/bin/node /home/ec2-user/webapp/index.js
    Restart=on-failure

    [Install]
    WantedBy=multi-user.target" > /etc/systemd/system/webapp.service
    sudo systemctl daemon-reload
    sudo systemctl start webapp.service
    sudo systemctl enable webapp.service
  EOF
}

resource "aws_iam_instance_profile" "EC2-CSYE6225_instance_profile" {
  name = "EC2-CSYE6225_Role_Instance_profile"
  role = aws_iam_role.EC2-CSYE6225.name
}