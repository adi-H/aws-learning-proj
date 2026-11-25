## iam role and policy (allows ec2 instance access to s3 bucket)
__last update__ - nov 25, 2026 

#### what did i learn 
- how different IAM components work in aws
- deploying IAM components (using ui and tf) 
- iam entities are global - they aren't tied to a region like ec2 is
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

> note (oct 26): the ec2 module now builds its own combined role and instance profile, so the root only uses this module's `iam_policy_arn` output. the role and instance profile created here aren't attached to anything at the moment.

#### related resources 
- [s3-bucket](../s3-bucket/learn-log.md) - the target bucket
- [ec2](../ec2/learn-log.md) - attaches the policy through its combined role
- project log: [oct 20](../../learn-logs/oct-20-26.md)

#### what this module might need in the future 
- might be best to split into an iam role and iam policy modules, to allow for more flexibility 
- also, this module does only one thing, and might be best to make it more dynamic in the future but as this is a learning exercise, i might revisit later on 
