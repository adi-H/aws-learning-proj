# these are the availability zones available for the current region
# to assign availability zones for each public subnet dynamically
data "aws_availability_zones" "zones" {
  state = "available"
}
