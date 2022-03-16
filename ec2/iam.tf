data "aws_iam_policy_document" "assume_role" {
  statement {
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role_policy_attachment" "webapp-policy" {
  role       = aws_iam_role.webapp-role.id
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_role" "webapp-role" {
  name               = "webapp-role"
  description        = "The role for the developer resources EC2"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_instance_profile" "webapp-profile" {
  name = "ssm-profile"
  role = aws_iam_role.webapp-role.id
}
