output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = module.network.vpc_cidr_block
}