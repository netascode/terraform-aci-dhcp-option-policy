<!-- BEGIN_TF_DOCS -->
[![Tests](https://github.com/netascode/terraform-aci-dhcp-option-policy/actions/workflows/test.yml/badge.svg)](https://github.com/netascode/terraform-aci-dhcp-option-policy/actions/workflows/test.yml)

# Terraform ACI DHCP Option Policy Module

Manages ACI DHCP Option Policy

Location in GUI:
`Tenants` » `XXX` » `Policies` » `Protocol` » `DHCP` » `Option Policies`

## Examples

```hcl
module "aci_dhcp_option_policy" {
  source = "netascode/dhcp-option-policy/aci"

  tenant      = "ABC"
  name        = "DHCP-OPTION1"
  description = "My Description"
  options = [{
    id   = 1
    data = "DATA1"
    name = "OPTION1"
  }]
}

```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_aci"></a> [aci](#requirement\_aci) | >= 0.2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aci"></a> [aci](#provider\_aci) | >= 0.2.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_tenant"></a> [tenant](#input\_tenant) | Tenant name. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | DHCP option policy name. | `string` | n/a | yes |
| <a name="input_description"></a> [description](#input\_description) | Description. | `string` | `""` | no |
| <a name="input_options"></a> [options](#input\_options) | List of DHCP options. | <pre>list(object({<br>    id   = optional(number)<br>    data = optional(string)<br>    name = string<br>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dn"></a> [dn](#output\_dn) | Distinguished name of `dhcpOptionPol` object. |
| <a name="output_name"></a> [name](#output\_name) | DHCP option policy name. |

## Resources

| Name | Type |
|------|------|
| [aci_rest.dhcpOption](https://registry.terraform.io/providers/netascode/aci/latest/docs/resources/rest) | resource |
| [aci_rest.dhcpOptionPol](https://registry.terraform.io/providers/netascode/aci/latest/docs/resources/rest) | resource |
<!-- END_TF_DOCS -->