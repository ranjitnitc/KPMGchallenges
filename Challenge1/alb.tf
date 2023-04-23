module "alb" {
  source = "terraform-aws-modules/alb/aws"

  name = "ranjit-alb"
  vpc_id = module.vpc.vpc_id

  subnets = module.vpc.public_subnets

  security_groups = [module.alb_sg.security_group_id]

  tags = {
    Environment = var.Environment
  }

  http_tcp_listeners = [
    {
      port               = 80
      protocol           = "HTTP"
      target_group_index = 0
    },
  ]

  target_groups = [
    {
      name_prefix = "my-tg"
      backend_protocol = "HTTP"
      backend_port     = 80

      health_check = {
        path = "/health"
      }

      targets = [
        {
          target_id = module.ec2_instance.id
          port      = 80
        }

      ]
    }
  ]
}
