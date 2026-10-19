## iam role and policy (allows ec2 instance access to s3 bucket)
__last update__ - oct 19, 2026 

#### what did i learn 
- how different IAM components work in aws
- deploying IAM components (using ui and tf) 
- the hierarchy of using IAM:
for example, using IAM to allow an ec2 to view/read/write from a s3 bucket:

```text
[ S3 BUCKET ]              <--- The Target Asset (Storage Box)
       ^
       | (Controlled by)
[ IAM POLICY ]            <--- The Rules (Contract stating what actions are allowed)
       ^
       | (Attached to)
[ IAM ROLE ]              <--- The Identity (The security badge carrying the policy)
       ^
       | (Wrapped inside)
[ IAM INSTANCE PROFILE ]  <--- The Compatibility Wrapper (The lanyard holding the badge)
       ^
       | (Assigned to)
[ EC2 INSTANCE ]          <--- The Compute Server (The entity executing your application)
```

#### related resources 

#### what this module might need in the future 
- might be best to split into an iam role and iam policy modules, to allow for more flexibility 
- also, this module does only one thing, and might be best to make it more dynamic in the future but as this is a learning exercise, i might revisit later on 
