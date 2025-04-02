provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "shotyourpet" {
  name     = "shotyourpet-resources"
  location = var.location
}

resource "azurerm_container_app_environment" "shotyourpet" {
  name                = "shotyourpet-env"
  location            = azurerm_resource_group.shotyourpet.location
  resource_group_name = azurerm_resource_group.shotyourpet.name
}

resource "azurerm_container_app" "gateway" {
  name                         = "shotyourpet-gateway-containerapp"
  container_app_environment_id = azurerm_container_app_environment.shotyourpet.id
  resource_group_name          = azurerm_resource_group.shotyourpet.name
  revision_mode                = "Single"

  ingress {
    allow_insecure_connections = false
    external_enabled           = true
    target_port                = 80
    traffic_weight {
      percentage      = 100
      latest_revision = true
    }
  }

  secret {
    name  = "nginx-config"
    value = filebase64("../nginx.conf")
  }

  template {
    volume {
      name         = "nginx-config"
      storage_type = "Secret"
    }

    container {
      name   = "nginx"
      image  = "nginx:alpine"
      cpu    = 0.25
      memory = "0.5Gi"
      volume_mounts {
        name = "nginx-config"
        path = "/etc/nginx/nginx.conf"
      }
    }
  }
}
