locals {
  role_name = "${var.function_name}-role"
  runtime   = var.function_runtime
}

module "package_with_commands_and_patterns" {
  source = "terraform-aws-modules/lambda/aws"

  layer_name      = "${var.function_name}-requirements-layer"
  create_function = false
  create_layer    = true

  runtime = local.runtime
  source_path = [
    {
      path = "${path.module}/../app"
      commands = [
        ":zip",
        "cd `mktemp -d`",
        "pip install --target=. -r ${abspath(path.module)}/../app/requirements.txt -t python",
        ":zip ."
      ]
      patterns = [
        "!.venv/.*",
        "!__pycache__/.*",
        "!.vscode/.*"
      ]
    }
  ]
}

module "lambda_function" {
  source = "terraform-aws-modules/lambda/aws"

  function_name = var.function_name
  description   = var.function_description
  handler       = var.handler
  runtime       = var.function_runtime
  lambda_role   = aws_iam_role.this.arn

  create_package = true
  source_path = [
    {
      path             = "${path.module}/../app"
      pip_requirements = false
      patterns = [
        "!.venv/.*",
        "!__pycache__/.*",
        "!.vscode/.*"
      ]
    }
  ]

  layers = [
    module.package_with_commands_and_patterns.lambda_layer_arn,
  ]


  tags = {
    Name = var.function_name
  }

  depends_on = [aws_iam_role.this, module.package_with_commands_and_patterns]
}
