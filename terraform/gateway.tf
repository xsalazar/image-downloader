resource "aws_apigatewayv2_api" "instance" {
  name          = "image-downloader-api-gateway"
  protocol_type = "HTTP"
  cors_configuration {
    allow_origins = ["https://emojikitchen.dev"]
    allow_methods = ["GET"]
    allow_headers = ["*"]
  }
}

resource "aws_apigatewayv2_integration" "instance" {
  api_id                 = aws_apigatewayv2_api.instance.id
  integration_type       = "AWS_PROXY"
  integration_uri        = aws_lambda_function.instance.invoke_arn
  payload_format_version = "2.0"
}

resource "aws_apigatewayv2_route" "instance" {
  api_id    = aws_apigatewayv2_api.instance.id
  route_key = "GET /"
  target    = "integrations/${aws_apigatewayv2_integration.instance.id}"
}

resource "aws_apigatewayv2_stage" "instance" {
  api_id      = aws_apigatewayv2_api.instance.id
  name        = "$default"
  auto_deploy = true

  default_route_settings {
    throttling_burst_limit = 50
    throttling_rate_limit  = 50
  }
}
