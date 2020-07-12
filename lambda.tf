# Define Lambda resources.
# https://aws.amazon.com/lambda

# https://www.terraform.io/docs/providers/aws/r/lambda_function.html
resource "aws_lambda_function" "query_hello" {
  # The path to the function's deployment package within the local filesystem.
  # This is a .zip of your code (a Go executable) and any dependencies.
  filename = "lambdas/query-hello.zip"

  # A unique name for your Lambda Function.
  function_name = "query-hello"

  # Description of what your Lambda Function does.
  description = "Return a generic welcome message."

  # IAM role attached to the Lambda Function.
  role = aws_iam_role.lambda_query_hello.arn

  # The function entrypoint in your code.
  handler = "query-hello/main"

  # Used to trigger updates.
  source_code_hash = filebase64sha256("lambdas/query-hello.zip")

  # Valid Values: nodejs10.x | nodejs12.x | java8 | java11 | python2.7 |
  # python3.6 | python3.7 | python3.8 | dotnetcore2.1 | dotnetcore3.1 |
  # go1.x | ruby2.5 | ruby2.7 | provided
  runtime = "go1.x"

  # Amount of memory (MB) your Lambda can use at runtime.
  # Between 128 MB to 3,008 MB, in 64 MB increments. Defaults to 128 MB.
  memory_size = 192

  # The amount of time your Lambda Function has to run in seconds.
  # Defaults to 3 with a maximum of 900 seconds (15 minutes).
  timeout = 10
}
