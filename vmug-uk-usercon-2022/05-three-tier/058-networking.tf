#NSX-T Segments
data "nsxt_policy_tier1_gateway" "t1" {
  display_name = var.t1_name
}

data "nsxt_policy_transport_zone" "overlay_tz" {
  display_name = var.overlay_name
}

resource "nsxt_policy_segment" "web-network" {
  display_name        = "${terraform.workspace}-${var.nsxt_networks.web.display_name}"
  description         = var.nsxt_networks.web.description
  connectivity_path   = data.nsxt_policy_tier1_gateway.t1.path
  transport_zone_path = data.nsxt_policy_transport_zone.overlay_tz.path
  subnet {
    cidr = var.nsxt_networks[terraform.workspace].web.cidr
  }
}

resource "nsxt_policy_segment" "app-network" {
  display_name        = "${terraform.workspace}-${var.nsxt_networks.app.display_name}"
  description         = var.nsxt_networks.app.description
  connectivity_path   = data.nsxt_policy_tier1_gateway.t1.path
  transport_zone_path = data.nsxt_policy_transport_zone.overlay_tz.path
  subnet {
    cidr = var.nsxt_networks[terraform.workspace].app.cidr
  }
}
resource "nsxt_policy_segment" "db-network" {
  display_name        = "${terraform.workspace}-${var.nsxt_networks.db.display_name}"
  description         = var.nsxt_networks.db.description
  connectivity_path   = data.nsxt_policy_tier1_gateway.t1.path
  transport_zone_path = data.nsxt_policy_transport_zone.overlay_tz.path
  subnet {
    cidr = var.nsxt_networks[terraform.workspace].db.cidr
  }
}

