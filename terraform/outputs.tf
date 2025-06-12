# Output the hub and spoke details
output "virtual_hub_id" {
  value = module.vwan.hub_id
}

output "spoke_vnet_ids" {
  value = {
    spoke1 = module.vnet1.id
    spoke2 = module.vnet2.id
    spoke3 = module.vnet3.id
  }
}