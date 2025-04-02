####################################################################################################
# DATA 
####################################################################################################
data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

data "aws_internet_gateway" "default" {
  filter {
    name   = "attachment.vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}

####################################################################################################
# SUBNET
####################################################################################################

resource "aws_subnet" "private" {
  count             = 2
  vpc_id            = data.aws_vpc.default.id
  cidr_block        = var.private_subnet_cidrs[count.index]
  availability_zone = var.availability_zones[count.index]

  tags = {
    Name        = "${var.environment}-private-subnet-${count.index + 1}"
    Environment = var.environment
  }
}

####################################################################################################
# EIP
####################################################################################################

resource "aws_eip" "nat" {
  domain = "vpc"
  
  tags = {
    Name        = "${var.environment}-nat-eip"
    Environment = var.environment
  }
}

####################################################################################################
# NAT GATEWAY
####################################################################################################

resource "aws_nat_gateway" "main" {
  count         = 1
  allocation_id = aws_eip.nat.id
  # Use first default subnet
  subnet_id     = tolist(data.aws_subnets.default.ids)[0]

  tags = {
    Name        = "${var.environment}-nat"
    Environment = var.environment
  }
}

####################################################################################################
# RT
####################################################################################################

resource "aws_route_table" "private" {
  vpc_id = data.aws_vpc.default.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main[0].id
  }

  tags = {
    Name        = "${var.environment}-private-rt"
    Environment = var.environment
  }
}

resource "aws_route_table_association" "private" {
  count          = 2
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}