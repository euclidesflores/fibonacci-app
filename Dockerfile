FROM public.ecr.aws/lambda/go:1.2023.03.21.16
COPY main ${LAMBDA_TASK_ROOT}
CMD ["main"]
