#NSX-T Segments
resource "nsxt_policy_segment" "web-network" {
  display_name        = "${terraform.workspace}-${var.nsxt_networks[terraform.workspace].web.display_name}"
  description         = var.nsxt_networks[terraform.workspace].web.description
  connectivity_path   = data.nsxt_policy_tier1_gateway.t1.path
  transport_zone_path = data.nsxt_policy_transport_zone.overlay_tz.path
  subnet {
    cidr = var.nsxt_networks[terraform.workspace].web.cidr
  }
}
resource "nsxt_policy_segment" "app-network" {
  display_name        = "${terraform.workspace}-${var.nsxt_networks[terraform.workspace].app.display_name}"
  description         = var.nsxt_networks[terraform.workspace].app.description
  connectivity_path   = data.nsxt_policy_tier1_gateway.t1.path
  transport_zone_path = data.nsxt_policy_transport_zone.overlay_tz.path
  subnet {
    cidr = var.nsxt_networks[terraform.workspace].app.cidr
  }
}
resource "nsxt_policy_segment" "db-network" {
  display_name        = "${terraform.workspace}-${var.nsxt_networks[terraform.workspace].db.display_name}"
  description         = var.nsxt_networks[terraform.workspace].db.description
  connectivity_path   = data.nsxt_policy_tier1_gateway.t1.path
  transport_zone_path = data.nsxt_policy_transport_zone.overlay_tz.path
  subnet {
    cidr = var.nsxt_networks[terraform.workspace].db.cidr
  }
}

#NSX-T Load Balancer
#Pool
resource "nsxt_policy_lb_pool" "webservice" {
  display_name         = "${var.application_name}-${terraform.workspace}-load-balancer-pool"
  description          = "Terraform provisioned LB Pool"
  algorithm            = "IP_HASH"
  min_active_members   = 2
  active_monitor_path  = "/infra/lb-monitor-profiles/default-icmp-lb-monitor"
  passive_monitor_path = "/infra/lb-monitor-profiles/default-passive-lb-monitor"
  member {
    admin_state                = "ENABLED"
    backup_member              = false
    display_name               = "vm-${terraform.workspace}-${var.virtualmachine.web.a_computer_name}"
    ip_address                 = var.virtualmachine.web.a_ipv4_address
    max_concurrent_connections = 12
    port                       = "80"
    weight                     = 1
  }
  member {
    admin_state                = "ENABLED"
    backup_member              = false
    display_name               = "vm-${terraform.workspace}-${var.virtualmachine.web.b_computer_name}"
    ip_address                 = var.virtualmachine.web.b_ipv4_address
    max_concurrent_connections = 12
    port                       = "80"
    weight                     = 1
  }
  snat {
    type = "AUTOMAP"
  }
  tcp_multiplexing_enabled = true
  tcp_multiplexing_number  = 8
}

#Loadbalancer
resource "nsxt_policy_lb_virtual_server" "webservice" {
  display_name               = "${var.application_name}-${terraform.workspace}-load-balancer"
  description                = "Terraform provisioned Virtual Server"
  access_log_enabled         = true
  application_profile_path   = data.nsxt_policy_lb_app_profile.default.path
  enabled                    = true
  ip_address                 = var.virtual_server[terraform.workspace].ip
  ports                      = ["443"]
  default_pool_member_ports  = ["80"]
  service_path               = data.nsxt_policy_lb_service.webservice.path
  max_concurrent_connections = 6
  max_new_connection_rate    = 20
  pool_path                  = nsxt_policy_lb_pool.webservice.path

}