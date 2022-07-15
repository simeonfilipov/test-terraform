#creating efs volume with lifecycle policy to transition to IA in 90 days
resource "aws_efs_file_system" "efs-instances" {
  lifecycle_policy {
    transition_to_ia = "AFTER_90_DAYS"
  }
  #key_name = "ubuntu"
  tags = {
    "name" = "efsforEC2"
  }
}

resource "aws_efs_mount_target" "efs-mount-sub1" {
  file_system_id  = aws_efs_file_system.efs-instances.id
  subnet_id       = aws_subnet.staging-subnet.id
  security_groups = [aws_security_group.efs-sg.id]
}

resource "aws_efs_mount_target" "efs-mount-sub2" {
  file_system_id  = aws_efs_file_system.efs-instances.id
  subnet_id       = aws_subnet.staging-subnet2.id
  security_groups = [aws_security_group.efs-sg.id]
}
