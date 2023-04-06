# resource "aws_key_pair" "deployer" {
#   key_name   = "ec2-ub"
#   public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDDRS9777vz5vG5xmPUrW4ljJN1M9rRXx0s71/Y156lxoAHySXim8SdORyGcLhZ1PN5rxcq2BTYKQ/U0ZdyMx5NLK3ba/gHRBkOxLMjaseMkhJsmHXr0xncF4iflNLVA40sj72hCwUOOgCpLH00M6DlHWr4yBE3Mncr/kUY8H2Ak89SFswQFrWaVS7eSg9y3ktdxrgFX4EKWfx1Syc/rMg4MHR++oDr65JKIsykXfUr8aGECBw9nYz5g6pJUlQxsbuh4MwJVL2xp//Dkpwma+ECBgXbjqCWMjIM/Hx7DrEJqqrH3R8htsjAIcQ/aJPOVtypkQ9P48e6+jvd037mLdyxfkk/NXPA/MiQ1hKiBdy8vLSeVKhY1Luk1KRb4vCXuLuDDv0FxkfCGn1qtbYr6xLvnK6L2d8P7Ed/eR45Fv47NopLi0/lyxZCYb4kG/Mil+ld5R9VfV+vRxxafUbatZlUw9E0kM/RGf5I0InusDvgggF5MNCwJHzCcp2R+Xn7Ag0= adityaillur@illur.local"
# }

resource "aws_iam_instance_profile" "EC2-CSYE6225_instance_profile" {
  name = "EC2-CSYE6225_Role_Instance_profile"
  role = aws_iam_role.EC2-CSYE6225.name
}