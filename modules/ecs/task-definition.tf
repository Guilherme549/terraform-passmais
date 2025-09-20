
resource "aws_ecs_task_definition" "passmais_task" {
  family                   = "passmais-task-v1"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "1024"
  memory                   = "2048"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([
    {
      name      = "frontend",
      image     = "${var.ECR_URI_IMAGE}:frontend",
      cpu       = 512,
      memory    = 1024,
      essential = true,
      portMappings = [
        {
          containerPort = 3000,
          protocol      = "tcp",
          appProtocol   = "http"
        }
      ],
      environmentFiles = [
        {
          type  = "s3",
          value = var.ARN_S3_env
        }
      ],
      logConfiguration = {
        logDriver = "awslogs",
        options = {
          awslogs-group         = "/ecs/passmais-task-v1",
          mode                  = "non-blocking",
          awslogs-create-group  = "true",
          max-buffer-size       = "25m",
          awslogs-region        = "us-east-1",
          awslogs-stream-prefix = "ecs"
        }
      }
    },
    {
      name      = "backend",
      image     = "${var.ECR_URI_IMAGE}:backend",
      cpu       = 512,
      memory    = 1024,
      essential = true,
      portMappings = [
        {
          containerPort = 8080,
          protocol      = "tcp",
          appProtocol   = "http"
        },
        {
          containerPort = 5432,
          protocol      = "tcp",
          appProtocol   = "http"
        },
        {
          containerPort = 5433,
          protocol      = "tcp",
          appProtocol   = "http"
        },
      ],
      environmentFiles = [
        {
          type  = "s3",
          value = var.ARN_S3_env_backend
        }
      ],
      logConfiguration = {
        logDriver = "awslogs",
        options = {
          awslogs-group         = "/ecs/passmais-task-v1",
          mode                  = "non-blocking",
          awslogs-create-group  = "true",
          max-buffer-size       = "25m",
          awslogs-region        = "us-east-1",
          awslogs-stream-prefix = "ecs"
        }
      }
    },

  ])
}

# 6. ECS Service
resource "aws_ecs_service" "passmais_service" {
  name            = "passmais-v1-service-h2j663g521"
  cluster         = aws_ecs_cluster.passmais_cluster.id
  task_definition = aws_ecs_task_definition.passmais_task.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = [var.passmais_subnet_public_1a, var.passmais_subnet_public_1b]
    assign_public_ip = true
    security_groups  = [var.passmais_sg_id]
  }

  deployment_minimum_healthy_percent = 50
  deployment_maximum_percent         = 200

  enable_execute_command = true

  load_balancer {
    target_group_arn = var.passmais_target_group_arn
    container_name   = "frontend"
    container_port   = 3000
  }

  load_balancer {
    target_group_arn = var.passmais_target_group_backend_arn
    container_name   = "backend"
    container_port   = 8080
  }

  depends_on = [ var.load_balancer_arn, aws_ecs_task_definition.passmais_task, var.aws_lb_listener_https, var.aws_lb_listener_http ]

  lifecycle {
    ignore_changes = [task_definition, desired_count, network_configuration, enable_execute_command]
  }
}
