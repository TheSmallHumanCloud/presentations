#Data
data "vsphere_datacenter" "dc" {
  name = var.vsphere_datacenter
}

data "vsphere_virtual_machine" "vm" {
  name          = var.virtual_machine_name
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_role" "administrator" {
  label = var.administrator_role
}

#Resources
resource "vsphere_role" "custom" {
  name            = var.custom_role
  role_privileges = [
    "VirtualMachine.Interact.AnswerQuestion",
    "VirtualMachine.Interact.ConsoleInteract",
    "VirtualMachine.Interact.DeviceConnection",
    "VirtualMachine.Interact.PowerOff",
    "VirtualMachine.Interact.PowerOn",
    "VirtualMachine.Interact.Reset",
    "VirtualMachine.Interact.SetCDMedia",
    "VirtualMachine.Interact.SetFloppyMedia",
    "VirtualMachine.Interact.Suspend",
    "VirtualMachine.Interact.ToolsInstall",
  ]
}

resource "vsphere_entity_permissions" "p1" {
  entity_id   = data.vsphere_virtual_machine.vm.id
  entity_type = "VirtualMachine"
  permissions {
    user_or_group = "corp.local\\vi_admins"
    propagate     = true
    is_group      = true
    role_id       = data.vsphere_role.administrator.id
  }
  permissions {
    user_or_group = "corp.local\\custom_role"
    propagate     = true
    is_group      = true
    role_id       = vsphere_role.custom.id
  }
}
