#NSX-T Segments
resource "nsxt_policy_segment" "web-network" {
  display_name        = "${terraform.workspace}-${var.nsxt_networks[terraform.workspace].web.display_name}"
  description         = var.nsxt_networks.web.description
  connectivity_path   = data.nsxt_policy_tier1_gateway.t1.path
  transport_zone_path = data.nsxt_policy_transport_zone.overlay_tz.path
  subnet {
    cidr = var.nsxt_networks[terraform.workspace].web.cidr
  }
}
resource "nsxt_policy_segment" "app-network" {
  display_name        = "${terraform.workspace}-${var.nsxt_networks[terraform.workspace].app.display_name}"
  description         = var.nsxt_networks.app.description
  connectivity_path   = data.nsxt_policy_tier1_gateway.t1.path
  transport_zone_path = data.nsxt_policy_transport_zone.overlay_tz.path
  subnet {
    cidr = var.nsxt_networks[terraform.workspace].app.cidr
  }
}
resource "nsxt_policy_segment" "db-network" {
  display_name        = "${terraform.workspace}-${var.nsxt_networks[terraform.workspace].db.display_name}"
  description         = var.nsxt_networks.db.description
  connectivity_path   = data.nsxt_policy_tier1_gateway.t1.path
  transport_zone_path = data.nsxt_policy_transport_zone.overlay_tz.path
  subnet {
    cidr = var.nsxt_networks[terraform.workspace].db.cidr
  }
}
