provider "aws" {
  region = "eu-west-1"
}
resource "aws_apprunner_auto_scaling_configuration_version" "apprunner-autoscaling" {
  auto_scaling_configuration_name = "demo_auto_scalling"
  max_concurrency = 100
  max_size        = 5
  min_size        = 1
  tags = {
    Name = "demo_auto_scalling"
  }
}
resource "aws_apprunner_service" "apprunner-service-github" {
  service_name = "demo_apprunner"
  source_configuration {
    authentication_configuration {
    connection_arn = aws_apprunner_connection.connection-guthub.arn
  }
  code_repository {
    code_configuration {
      code_configuration_values {
        build_command = "npm install"
        port          = "3000"
        runtime       = "NODEJS_12"
        start_command = "npm run start"
  }
    configuration_source = "API"
  }
    repository_url = "https://github.com/skyface753/demo-application"
    source_code_version {
    type  = "BRANCH"
    value = "main"
    }
  }
  auto_deployments_enabled = true
#   auto_scaling_configuration_arn = aws_apprunner_auto_scaling_configuration_version.apprunner-autoscaling.arn
#   health_check_configuration {
#     healthy_threshold   = 1
#     interval            = 10
#     path                = "/"
#     protocol            = "TCP"
#     timeout             = 5
#     unhealthy_threshold = 5
#   }
# tags = {
#   Name = "demo_apprunner"
#   }
}
}
resource "aws_apprunner_connection" "connection-guthub" {
connection_name = "demo_apprunner_connection"
  provider_type   = "GITHUB"
  tags = {
    Name = "demo_apprunner_connection"
  }
}