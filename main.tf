resource "aci_rest" "dhcpOptionPol" {
  dn         = "uni/tn-${var.tenant}/dhcpoptpol-${var.name}"
  class_name = "dhcpOptionPol"
  content = {
    descr = var.description
    name  = var.name
  }
}

resource "aci_rest" "dhcpOption" {
  for_each   = { for opt in var.options : opt.name => opt }
  dn         = "${aci_rest.dhcpOptionPol.dn}/opt-${each.value.name}"
  class_name = "dhcpOption"
  content = {
    id   = each.value.id != null ? each.value.id : ""
    data = each.value.data != null ? each.value.data : ""
    name = each.value.name
  }
}
