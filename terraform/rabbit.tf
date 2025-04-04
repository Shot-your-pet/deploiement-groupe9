resource "azurerm_container_app" "rabbit" {
  name                         = "shotyourpet-rabbit-containerapp"
  container_app_environment_id = azurerm_container_app_environment.shotyourpet.id
  resource_group_name          = azurerm_resource_group.shotyourpet.name
  revision_mode                = "Single"
  ingress {
    transport   = "tcp"
    target_port = 5672
    traffic_weight {
      percentage      = 100
      latest_revision = true
    }
  }

  template {
    container {
      name   = "rabbit"
      image  = "rabbitmq:4-alpine"
      cpu    = 0.25
      memory = "0.5Gi"
    }
  }
}
