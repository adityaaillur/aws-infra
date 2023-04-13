resource "aws_key_pair" "deployer" {
  key_name   = "ec2-ub"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCveZqnIs4Dc8HoMmy4EHJFUUqWTZbi1DqnpJV5ZCBYPS0KXf3uZTN4Vs983Eux95mGQd6ODJgC8JNjuuQhYXZyRwXA9NeZodT8cxPFOLWfgxpht2LLUdk23datCrBN5uWiNTsZx4M459uhgWhkoZSMAvJOuAMOir0rlYwpv05H8YXu1CY9TTVEXJ9vakA4q2iwh2WEP5/PBpF5mwEgi+i18cJfTTO47t9canB91mXspDlAJXjX+8ccW1q2WX2IjLxOEvchp9wysqX69gsWEn5wQCTcIDvu7iEjmApr3Kww6+yVY9m0rAwqp+CdkYdfcXWblsZxKXy5DMUXGsHHs9gi6wwOKRXoHewT8K+dpEre9J/I5CwFupIvgHoHt1YXwSuuNjZRla/oseOubTUV8sitOf1M4jHpG+cl65cKb33PY1iHBP5ktCDIpby24MFzqaaI0wgbWXjCgISzYIVpw+bwhKj/yJBpJW8GSaT0CtJoyv3MJYl6g+JQukNYs+ofTIs= ace@DESKTOP-NFSV25F"
}

resource "aws_iam_instance_profile" "EC2-CSYE6225_instance_profile" {
  name = "EC2-CSYE6225_Role_Instance_profile"
  role = aws_iam_role.EC2-CSYE6225.name
}