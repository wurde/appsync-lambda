# Define AppSync resources.
# https://aws.amazon.com/appsync

# https://www.terraform.io/docs/providers/aws/r/appsync_graphql_api.html
resource "aws_appsync_graphql_api" "main" {
  # A user-supplied name for the GraphQL API.
  name = "main"

  # Valid values: API_KEY, AWS_IAM, AMAZON_COGNITO_USER_POOLS, OPENID_CONNECT
  authentication_type = "API_KEY"

  # The schema definition, in GraphQL schema language format.
  schema = file("${path.module}/schema.graphql")
}

# https://www.terraform.io/docs/providers/aws/r/appsync_datasource.html
resource "aws_appsync_datasource" "query_hello" {
  # The API ID for the GraphQL API.
  api_id = aws_appsync_graphql_api.main.id

  # A user-supplied name for the Data Source. A name starts with a letter
  # and contains only numbers, letters, and underscores(_).
  name = "query_hello"

  # The IAM service role ARN.
  service_role_arn = aws_iam_role.appsync_datasource_query_hello.arn

  # Valid values: AWS_LAMBDA, AMAZON_DYNAMODB, AMAZON_ELASTICSEARCH, HTTP, NONE.
  type = "AWS_LAMBDA"

  lambda_config {
    # The ARN for the Lambda function.
    function_arn = aws_lambda_function.query_hello.arn
  }
}

# https://www.terraform.io/docs/providers/aws/r/appsync_resolver.html
resource "aws_appsync_resolver" "query_hello" {
  # The API ID for the GraphQL API.
  api_id = aws_appsync_graphql_api.main.id

  # The type name from the schema defined in the GraphQL API.
  type = "Query"

  # The field name from the schema defined in the GraphQL API.
  field = "hello"

  # The DataSource name.
  data_source = aws_appsync_datasource.query_hello.name

  # The resolver type. Valid values are UNIT and PIPELINE.
  kind = "UNIT"

  # The request mapping template for UNIT resolver or
  # 'before mapping template' for PIPELINE resolver.
  request_template = <<EOF
{
    "version": "2017-02-28",
    "operation": "Invoke",
    "payload": {
        "field": "hello",
        "arguments": $utils.toJson($context.arguments)
    }
}
EOF

  # The response mapping template for UNIT resolver or
  # 'after mapping template' for PIPELINE resolver.
  response_template = "$utils.toJson($context.result)"
}

# https://www.terraform.io/docs/providers/aws/r/appsync_api_key.html
resource "aws_appsync_api_key" "test" {
  # The ID of the associated AppSync API
  api_id  = aws_appsync_graphql_api.main.id

  # RFC3339 string representation of the expiry date.
  expires = "2020-07-15T00:00:00Z"
}
