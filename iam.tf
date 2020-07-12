# Define IAM resources.
# https://aws.amazon.com/iam

resource "aws_iam_role" "appsync_datasource_query_hello" {
  name = "appsync_datasource_query_hello"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "appsync.amazonaws.com"
      },
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "appsync_datasource_query_hello_policy" {
  name = "appsync_datasource_query_hello_policy"
  role = aws_iam_role.appsync_datasource_query_hello.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "lambda:InvokeFunction"
      ],
      "Effect": "Allow",
      "Resource": [
        "${aws_lambda_function.query_hello.arn}"
      ]
    }
  ]
}
EOF
}

resource "aws_iam_role" "lambda_query_hello" {
  name = "lambda_query_hello"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow"
    }
  ]
}
EOF
}
