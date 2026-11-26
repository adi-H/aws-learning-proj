# these are the availability zones available for the current region
# to assign availability zones for each public subnet dynamically
data "aws_availability_zones" "zones" {
  #checkov:skip=CKV_AWS_394:only the first 2 zones are used, by index, so new zones don't change the subnets
  state = "available"
}
