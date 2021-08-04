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

  tenant      = aci_rest.fvTenant.content.name
  name        = "DHCP-OPTION1"
  description = "My Description"
  options = [{
    id   = 1
    data = "DATA1"
    name = "OPTION1"
  }]
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

  equal "descr" {
    description = "descr"
    got         = data.aci_rest.dhcpOptionPol.content.descr
    want        = "My Description"
  }
}

data "aci_rest" "dhcpOption" {
  dn = "${data.aci_rest.dhcpOptionPol.id}/opt-OPTION1"

  depends_on = [module.main]
}

resource "test_assertions" "dhcpOption" {
  component = "dhcpOption"

  equal "name" {
    description = "name"
    got         = data.aci_rest.dhcpOption.content.name
    want        = "OPTION1"
  }

  equal "id" {
    description = "id"
    got         = data.aci_rest.dhcpOption.content.id
    want        = "1"
  }

  equal "data" {
    description = "data"
    got         = data.aci_rest.dhcpOption.content.data
    want        = "DATA1"
  }
}
