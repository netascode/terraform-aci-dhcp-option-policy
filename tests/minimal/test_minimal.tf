terraform {
  required_providers {
    test = {
      source = "terraform.io/builtin/test"
    }

    aci = {
      source  = "netascode/aci"
      version = ">=0.2.0"
    }
  }
}

resource "aci_rest" "fvTenant" {
  dn         = "uni/tn-TF"
  class_name = "fvTenant"
}

module "main" {
  source = "../.."

  tenant = aci_rest.fvTenant.content.name
  name   = "DHCP-OPTION1"
}

data "aci_rest" "dhcpOptionPol" {
  dn = module.main.dn

  depends_on = [module.main]
}

resource "test_assertions" "dhcpOptionPol" {
  component = "dhcpOptionPol"

  equal "name" {
    description = "name"
    got         = data.aci_rest.dhcpOptionPol.content.name
    want        = module.main.name
  }
}
