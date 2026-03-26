# Opella Infrastructure

Azure infrastructure deployment using Terraform modules.

## Resources

- **3 Resource Groups**: Network, Storage, Compute
- **Virtual Network**: 10.0.0.0/16 with 2 subnets
- **Route Table**: Internet routing
- **Storage Account**: Blob storage with network isolation
- **Windows VM**: Server 2022 Datacenter (Standard_D2s_v3)

## Modules

- `azure-resource-group` - Resource group management
- `azure-vnet` - Virtual network and subnets
- `azure-route-table` - Route tables and associations
- `azure-storage-account` - Storage accounts with security
- `azure-nic` - Network interfaces
- `azure-vm-windows` - Windows virtual machines
- `azure-tags` - Corporate tagging

## Deploy

```bash
terraform init
terraform apply
