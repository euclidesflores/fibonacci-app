terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=4.60.0"
    }
  }

  required_version = "~>1.3.0"
}

resource "aws_codecommit_repository" "main" {
  repository_name = var.repository_name
  description     = var.description
}

resource "aws_iam_user_ssh_key" "code_commit" {
	username = var.user_name
	encoding = "SSH"
	public_key = file("~/.ssh/id_rsa.pub")
}

