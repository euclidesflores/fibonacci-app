//go:build linux || darwin
// +build linux darwin

package main

import (
	"context"
	"os"

	"github.com/aws/aws-lambda-go/lambda"
	"github.com/aws/aws-lambda-go/lambdacontext"
)

type Base struct {
	N int `json:"base"`
}

type Fibonacci struct {
	Sequence  []int  `json:"sequence"`
	Base      int    `json:"base"`
	Region    string `json:"region"`
	RequestID string `json:"requestID"`
}

func HandleRequest(ctx context.Context, base Base) (Fibonacci, error) {
	region := os.Getenv("AWS_REGION")
	lc, _ := lambdacontext.FromContext(ctx)

	sequence := GetFibonacciSeq(base.N)
	return Fibonacci{sequence, base.N, region, lc.AwsRequestID}, nil
}

func main() {
	lambda.Start(HandleRequest)
}

func GetFibonacciSeq(n int) []int {
	m := make([]int, n)
	a, b := 0, 1
	for i := range m {
		m[i] = a
		a, b = b, a+b
	}
	return m
}
