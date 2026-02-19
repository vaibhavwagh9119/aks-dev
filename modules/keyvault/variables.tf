
variable "name" {}
variable "location" {}
variable "resource_group_name" {}
variable "tags" { type = map(string) }
variable "vnet_id" {}
variable "private_endpoint_subnet_id" {}