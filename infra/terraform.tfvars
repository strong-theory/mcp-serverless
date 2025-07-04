function_name        = "mcp-serverless"
function_description = "MCP serverless"
function_runtime     = "python3.12"
function_timeout     = 3
handler              = "handler.lambda_handler"

# SETADAS PELA PIPELINE
aws_region         = "us-west-1"
bucket_source_code = "bucket"
code_key           = "lambda.zip"