locals {
  dashboards_file = [
    for dashboard_path in fileset("${path.module}/dashboards", "*.json") :
    file("${path.module}/dashboards/${dashboard_path}")
  ]
  dashboards_http = [
    for url in var.dashboard_urls :
    data.http.dashboard[url].response_body
  ]
  dashboards = toset(concat(local.dashboards_file, local.dashboards_http))
}

data "http" "dashboard" {
  for_each = toset(var.dashboard_urls)

  url = each.value
  request_headers = {
    Accept = "application/json"
  }
}

resource "signoz_dashboard" "imported" {
  for_each = local.dashboards

  collapsable_rows_migrated = lookup(jsondecode(each.value), "collapsableRowsMigrated", false)
  description               = lookup(jsondecode(each.value), "description", "")
  layout                    = jsonencode(lookup(jsondecode(each.value), "layout", []))
  name = lookup(jsondecode(each.value), "name", replace(
    basename(each.key),
    ".json", ""
  ))
  title            = lookup(jsondecode(each.value), "title", "")
  uploaded_grafana = lookup(jsondecode(each.value), "uploadedGrafana", false)
  variables        = jsonencode(lookup(jsondecode(each.value), "variables", {}))

  # TODO: produced an unexpected new value: .version: was cty.StringVal("v4"), but now cty.StringVal("v5").
  # version = "v5"
  version          = lookup(jsondecode(each.value), "version", "")

  widgets = jsonencode(lookup(jsondecode(each.value), "widgets", []))

  panel_map = jsonencode(lookup(jsondecode(each.value), "panelMap", {}))
  tags      = lookup(jsondecode(each.value), "tags", [])

  lifecycle {
    ignore_changes = [panel_map, version]
  }
}
