resource "azurerm_postgresql_flexible_server" "timeline" {
  name                          = "shotyourpet-timeline-db-server" # Nom du serveur PostgreSQL
  location                      = azurerm_resource_group.shotyourpet.location
  resource_group_name           = azurerm_resource_group.shotyourpet.name
  public_network_access_enabled = true # TODO: make it work

  administrator_login          = "adminuser"       # Identifiant admin
  administrator_password       = "P@ssw0rd1234!"   # Mot de passe (personnalisable avec précaution)
  sku_name                     = "B_Standard_B1ms" # Taille du serveur
  version                      = "16"              # Version PostgreSQL
  storage_mb                   = 32768             # Taille de stockage (modifiable selon les besoins)
  backup_retention_days        = 7                 # Jours de rétention des sauvegardes
  geo_redundant_backup_enabled = false

  lifecycle {
    ignore_changes = [
      zone,
      high_availability.0.standby_availability_zone
    ]
  }
}

resource "azurerm_postgresql_flexible_server_database" "timeline" {
  name      = "shotyourpet-timeline-db" # Nom de la base de données
  server_id = azurerm_postgresql_flexible_server.timeline.id
  charset   = "utf8"       # Jeu de caractères
  collation = "en_US.utf8" # Collation
}


# Allow connections from other Azure Services
resource "azurerm_postgresql_flexible_server_firewall_rule" "timeline" {
  name             = "shotyourpet-timeline-db-fw"
  server_id        = azurerm_postgresql_flexible_server.timeline.id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.0"
}


resource "azurerm_container_app" "timeline" {
  name                         = "shotyourpet-timeline-capp"
  container_app_environment_id = azurerm_container_app_environment.shotyourpet.id
  resource_group_name          = azurerm_resource_group.shotyourpet.name
  revision_mode                = "Single"

  depends_on = [
    azurerm_postgresql_flexible_server.timeline,
    azurerm_container_app.rabbit
  ]

  template {
    container {
      name   = "timeline"
      image  = "ghcr.io/shot-your-pet/timeline:main"
      cpu    = 0.25
      memory = "0.5Gi"


      env {
        name  = "ConnectionStrings__ShotYourPet"
        value = "Host=${azurerm_postgresql_flexible_server.timeline.fqdn};Database=timeline;Password=${azurerm_postgresql_flexible_server.timeline.administrator_password};Username=${azurerm_postgresql_flexible_server.timeline.administrator_login}"
      }

      env {
        name  = "ConnectionStrings__RabbitMQ"
        value = "amqp://guest:guest@rabbit:5672/"
      }
    }
  }
}
