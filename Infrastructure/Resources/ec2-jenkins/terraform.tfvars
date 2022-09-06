instance_count              = 1
name                        = "jenkins-server"
ami                         = "ami-074771aa49ab046e7" # need to be changed based on region
instance_type               = "t2.micro"
subnet_filter               = "pub-sub-*"
associate_public_ip_address = true
key_name                    = "equalexperts" # need to be changed based on account
iam_instance_profile        = "jenkinsadmin"
user_data                   = "user_data.sh"

root_block_device = [
    {
        volume_type           = "gp2"
        volume_size           = 10
        delete_on_termination = "true"
        encypted              = "false"
    }
]

volume_tags = {
    "Name"      = "jenkins_server"
    "encrypted" = "false"
}

tags = {
    "type" = "jenkins-server"
    "description" = "EC2 instance for jenkins server"
}

sg_name = "jenkins_sg"

sg_tags = {
    "descrition" = "The security group that allows SSH and Jenkins port access from anywhere"
}

sg_rules = [
    {
        type        = "ingress" 
        description = "Allows SSH access from anywhere"
        from_port   = "22"
        to_port     = "22"
        protocol    = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
    },
    {
        type        = "ingress" 
        description = "Allows Jenkins port access from anywhere"
        from_port   = "8080"
        to_port     = "8080"
        protocol    = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
    }
]