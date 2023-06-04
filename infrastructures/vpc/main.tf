resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  instance_tenancy = "default"

  tags = {
    "Name" = "main"
  }
}

resource "aws_default_security_group" "this" {
  vpc_id = aws_vpc.main.id

  ingress {
    protocol  = -1
    from_port = 0
    to_port   = 0
    self      = true
  }

  egress {
    protocol    = -1
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

// 10.0.0.0/20   -> public
// 10.0.64.0/20  -> (reserved)
// 10.0.128.0/20 -> private
// 10.0.192.0/20 -> (reserved)

resource "aws_subnet" "public" {
  for_each = toset(var.az_list)

  cidr_block        = format("10.0.%d.0/20", 0 + 16 * index(var.az_list, each.key))
  availability_zone = each.key
  vpc_id            = aws_vpc.main.id

  map_public_ip_on_launch = true

  tags = {
    "Name" = "main-public-${each.key}"
    "main" = "public"
  }
}

// NAT Gateway はお金がかかるので ACL でインバウンドを制限することでプライベートセグメントを実現する
resource "aws_subnet" "private" {
  for_each = toset(var.az_list)

  cidr_block        = format("10.0.%d.0/20", 128 + 16 * index(var.az_list, each.key))
  availability_zone = each.key
  vpc_id            = aws_vpc.main.id

  map_public_ip_on_launch = true

  tags = {
    "Name" = "main-private-${each.key}"
    "main" = "private"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags = {
    "Name" = "main"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  tags = {
    "Name" = "main-public"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id
  tags = {
    "Name" = "main-private"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

}

resource "aws_route_table_association" "public" {
  for_each = aws_subnet.public

  route_table_id = aws_route_table.public.id
  subnet_id      = each.value.id
}

resource "aws_route_table_association" "private" {
  for_each = aws_subnet.private

  route_table_id = aws_route_table.private.id
  subnet_id      = each.value.id
}

resource "aws_network_acl" "private" {
  vpc_id     = aws_vpc.main.id
  subnet_ids = values(aws_subnet.private)[*].id

  ingress {
    rule_no    = 100
    protocol   = -1
    from_port  = 0
    to_port    = 0
    cidr_block = "10.0.0.0/16"
    action     = "allow"
  }

  egress {
    rule_no    = 100
    protocol   = -1
    from_port  = 0
    to_port    = 0
    cidr_block = "0.0.0.0/0"
    action     = "allow"
  }

  tags = {
    Name = "private"
  }
}
