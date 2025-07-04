output "lambda_arn" {
  value = module.lambda_function.lambda_function_arn
}

output "policy_arn" {
  value = aws_iam_policy.this.arn
}

output "role_arn" {
  value = aws_iam_role.this.arn
}

output "stage_url" {
  description = "Stage url"
  value       = aws_apigatewayv2_stage.this.invoke_url
}

output "mcp_url" {
  description = "Stage url"
  value       = "${aws_apigatewayv2_stage.this.invoke_url}/mcp"
}