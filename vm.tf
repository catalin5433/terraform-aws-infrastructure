resource "aws_key_pair" "key_pair1" {
  key_name   = "web-key1"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQChFFsr1Fwh+P7Zr1CLLaAlcOY3JYuZX0C7Mg/dk5T4kaUt/Jja8fqfkFbmvApaWhA09QJ8SHz22kAeKDXvRKqGzECVaoZJnQIY0Qs5VTCNSgy3zmB0hkUjl0gtIqMskY6Vah4BFfSczpsbYPkmytzZ9/qCZxKF6fjYdHJjNjClRNantH6g6Sq98oWXK2yq6k+I86ZDkR233XisxR+qDHpoDxnXIg0DsC3bqVrYpIx45wIqNPcsmGoW/otc9XbZC79tqsFnRaGFfvx7wzLUPtBLRhM8qR7jvykBrg1tnQ8F46nmoGOKFBjJnAZUDgUtcDvQB/MhCUEDjdc/18Lpl1l2G3RZdf4eux3oT5cf1vSw6X2IfOCdJL3eLK0uem4j3m5NV2C6x9XLJsQPaX9t4IgHHXF/sGxKciOkgs1ooJKAjRqSMI4JbN1csMqTWd+jRYqKnECnL2KLiNOgcxyFuEtiX5GpMyXZy/dXi4BOt3H3ggc6D1gcXqhEF3ANoOJnAhU= cata@RHELGui"
}



# The first EC2 instance
resource "aws_instance" "web_server_main" {
  ami                    = "ami-0a116fa7c861dd5f9"
  instance_type          = "c7i-flex.large"
  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.main.id]
  key_name               = aws_key_pair.key_pair1.key_name

  tags = {
    Name = "WebServer-Main"
  }
}


# The second EC2 instance
/*
resource "aws_instance" "web_server_test" {
  ami                    = "ami-0a116fa7c861dd5f9"
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.main.id]
  key_name               = aws_key_pair.key_pair1.key_name

  tags = {
    Name = "WebServer-Test"
  }
}
*/
