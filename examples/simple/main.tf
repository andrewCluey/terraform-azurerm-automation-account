provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "logging" {
  name     = "rg-dev-logging"
  location = "uksouth"
}

module "automation" {
  source = "../../"

  resource_group_name        = azurerm_resource_group.logging.name
  automation_account_name    = "automationdev"
  enable_diagnostic_settings = true

  aa_diagnostic_settings = {
    name                       = "aaDiagnostics"
    log_analytics_workspace_id = module.log_analytics.la_id
  }

  tags = {
    "deployedBy" = "Terraform"
  }
}

module "log_analytics" {
  source  = "andrewCluey/log-analytics/azurerm"
  version = "0.2.2"

  location            = "uksouth"
  resource_group_name = azurerm_resource_group.logging.name
  solution_plan_map   = local.solution_plan_map

  workspace = {
    name                       = "dev-log-workspace"
    sku                        = "PerGB2018"
    retention_in_days          = 32
    daily_quota_gb             = 1
    internet_ingestion_enabled = true
    internet_query_enabled     = true
  }
}