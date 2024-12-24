# ================= SERVERS =================
module "nc_server" {
  source = "github.com/MalchielUrias/kubecounty_infrastructure//terraform/aws/modules/ec2"
  ami           = var.ami
  instance_type = var.wp_type
  subnet_id     = var.subnet_id
  iam_instance_profile = var.instance_profile
  tags = merge(var.tags, {
    "Name" = "NextCloud Server"
  })
  key_name               = var.key_name
  vpc_security_group_ids = [ module.nc_server_sg.sg_id]

  user_data = file("${path.module}/user_data.sh")
}

# ================= NETWORK SECURITY GROUPS =================

module "nc_server_sg" {
  source      = "github.com/MalchielUrias/kubecounty_infrastructure//terraform/aws/modules/sg"
  name        = "${var.name}-wp-sg"
  description = var.sg_description
  tags        = var.tags
  vpc_id      = var.vpc_id
  rules = [
    {
      "type"        = "ingress"
      "from_port"   = 22,
      "to_port"     = 22,
      "protocol"    = "tcp",
      "cidr_blocks" = ["10.2.20.0/24"]
    },
    {
      "type"        = "ingress"
      "description" = "HTTP"
      "from_port"   = 80,
      "to_port"     = 80,
      "protocol"    = "tcp",
      "cidr_blocks" = ["10.2.20.0/24"]
    },
    {
      "type"        = "ingress"
      "description" = "HTTS"
      "from_port"   = 443,
      "to_port"     = 443,
      "protocol"    = "tcp",
      "cidr_blocks" = ["10.2.20.0/24"]
    },
    {
      "type"        = "egress"
      "from_port"   = 0,
      "to_port"     = 0,
      "protocol"    = "-1",
      "cidr_blocks" = ["0.0.0.0/0"]
    },
  ]
}