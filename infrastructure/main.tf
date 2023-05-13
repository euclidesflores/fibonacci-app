provider "aws" {
  region = var.region
}

locals {
  account_id   = data.aws_caller_identity.current.account_id
  archive_file = "main.zip"
  handler      = "main"
  name         = "main"
  description  = "Main Rest API"
}

data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

data "aws_iam_policy_document" "logs" {
  statement {
    effect    = "Allow"
    actions   = ["logs:CreateLogGroup", "logs:CreateLogStream", "logs:PutLogEvents"]
    resources = ["arn:aws:logs:${var.region}:${local.account_id}:*"]
  }
}

resource "aws_iam_role" "iam_for_lambda" {
  name               = "iam-for-lambda"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_policy" "logs" {
  name   = "${local.name}-lambda-logs"
  policy = data.aws_iam_policy_document.logs.json
}

resource "aws_iam_role_policy_attachment" "log" {
  role       = aws_iam_role.iam_for_lambda.name
  policy_arn = aws_iam_policy.logs.arn
}

data "archive_file" "lambda" {
  type        = "zip"
  source_file = "../main"
  output_path = local.archive_file
}

resource "aws_lambda_function" "main" {
  filename      = local.archive_file
  function_name = local.name
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = local.handler

  source_code_hash = data.archive_file.lambda.output_base64sha256

  runtime = "go1.x"
}
