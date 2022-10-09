
resource "aws_iam_role" "role" {
  name = "test-role"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
         "Service": [
           "build.apprunner.amazonaws.com",
           "tasks.apprunner.amazonaws.com"
         ]
       },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "test-attach" {
   role       = aws_iam_role.role.name
   policy_arn = "arn:aws:iam::aws:policy/service-role/AWSAppRunnerServicePolicyForECRAccess"
 }
