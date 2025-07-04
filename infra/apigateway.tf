module "api_gateway" {
  source = "terraform-aws-modules/apigateway-v2/aws"

  name                           = "Weather MCP Server API"
  description                    = "Weather MCP Server API"
  protocol_type                  = "HTTP"
  create                         = true # to disable all resources
  create_domain_name             = false
  create_stage                   = false
  create_certificate             = false
  create_domain_records          = false
  create_routes_and_integrations = true # to control creation of routes and integrations

  cors_configuration = {
    allow_headers = ["content-type", "x-amz-date", "authorization", "x-api-key", "x-amz-security-token", "x-amz-user-agent"]
    allow_methods = ["*"]
    allow_origins = ["*"]
  }

    # API
    body = templatefile("api.yaml", {
      lambada_function_arn = module.lambda_function.lambda_function_arn
    })

  # Access logs
  stage_access_log_settings = {
    create_log_group = false
  }

  # Authorizer(s)
  authorizers = {
  }

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }

  depends_on = [ module.lambda_function ]

}

resource "aws_apigatewayv2_stage" "this" {
  api_id      = module.api_gateway.api_id
  name        = "prod"
  auto_deploy = true
}