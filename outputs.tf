output "dn" {
  value       = aci_rest.dhcpOptionPol.id
  description = "Distinguished name of `dhcpOptionPol` object."
}

output "name" {
  value       = aci_rest.dhcpOptionPol.content.name
  description = "DHCP option policy name."
}
