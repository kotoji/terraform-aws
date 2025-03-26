module "emr_serverless" {
  source  = "terraform-aws-modules/emr/aws//modules/serverless"
  version = "2.4.0"

  create = var.create

  name                 = var.name
  type                 = "spark"
  architecture         = "ARM64"
  release_label_prefix = "emr-7.8.0"

  initial_capacity = {
    driver = {
      initial_capacity_type = "Driver"

      initial_capacity_config = {
        worker_count = 1
        worker_configuration = {
          cpu    = "1 vCPU"
          memory = "6 GB"
          disk   = "40 GB"
        }
      }
    }

    executor = {
      initial_capacity_type = "Executor"

      initial_capacity_config = {
        worker_count = 1
        worker_configuration = {
          cpu    = "2 vCPU"
          memory = "10 GB"
          disk   = "40 GB"
        }
      }
    }
  }

  maximum_capacity = {
    cpu    = "16 vCPU"
    memory = "64 GB"
    disk   = "300 GB"
  }

  network_configuration = {
    subnet_ids = var.subnet_ids
  }

  security_group_rules = {
    egress_all = {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  interactive_configuration = {
    studio_enabled = true
  }

  auto_start_configuration = {
    enabled = true
  }

  auto_stop_configuration = {
    enabled              = true
    idle_timeout_minutes = 5
  }
}
