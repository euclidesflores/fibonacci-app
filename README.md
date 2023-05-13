# Deploying a Go API using AWS Lambda and AWS regional Rest API Gateway with Terraform

This is a sample AWS Lambda function written in Golang which uses AWS API Gateway Rest API. Infrastructure as Code is managed using Terraform.

```
├── Dockerfile
├── Makefile
├── README.md
├── cmd
│   ├── main.go
│   └── main_test.go
├── coverage.txt
├── go.mod
├── go.sum
└── infrastructure
    ├── apigw.tf
    ├── main.tf
    ├── outputs.tf
    ├── terraform.tf
    └── variables.tf
```


```
curl -X POST https://qz4tp1ohjj.execute-api.us-east-2.amazonaws.com/dev/main -d '{"base": 12}'

{"sequence":[0,1,1,2,3,5,8,13,21,34,55,89],"base":12,"region":"us-east-2","requestID":"70893424-ca3b-4c01-a93b-3f4a34badaec"}

```