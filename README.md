# aws-learning-proj

terraform modules for learning aws: ec2, s3, iam and networking (vpc, private subnet, nat gateway, application load balancer).

## learning logs
the process, problems and lessons are documented in [learn-logs](learn-logs/README.md), and each module has its own `learn-log.md`.

## roadmap
- [x] ec2 module with its own security group, deployed through an example (sept 6)
- [x] s3 bucket module using `bucket_prefix` for unique names
- [x] iam role and policy module that gives an ec2 read/write access to one bucket
- [x] httpd web server on ec2 (user_data) with access to the s3 bucket (oct 20)
- [x] networking module: custom vpc, 2 public subnets, private subnet, internet gateway and nat gateway
- [x] application load balancer in front of the private ec2, with a target group and health checks (oct 26)
- [x] ssm access to the private instance through a combined iam role and instance profile
- [x] security groups that reference each other (app only accepts port 80 from the alb)
- [x] terraform-docs readmes for every module
- [x] learn logs for every module and project milestone
- [ ] plan tests with mock providers for every module (networking already has an apply test)
- [ ] remote state backend in s3 (`use_lockfile = true`) with a `bootstrap/` folder
- [ ] ci with github actions (fmt, validate, tflint, security scan, plan) using an oidc role
- [ ] auto scaling group across 2 availability zones instead of a single ec2
- [ ] cloudwatch alarms (unhealthy hosts, 5xx, cpu) with sns email alerts
- [ ] "forbidden" s3 bucket, bucket hardening and an s3 gateway vpc endpoint
- [ ] run the same app on ecs fargate and compare it to the ec2 version
