data "http" "dashboard" {
  for_each = toset(var.dashboards)
  url      = each.value
  request_headers = {
    Accept = "application/json"
  }
}

resource "signoz_dashboard" "imported" {
  for_each = data.http.dashboard

  collapsable_rows_migrated = lookup(jsondecode(each.value.response_body), "collapsableRowsMigrated", false)
  description               = lookup(jsondecode(each.value.response_body), "description", "")
  layout                    = jsonencode(lookup(jsondecode(each.value.response_body), "layout", []))
  name = lookup(jsondecode(each.value.response_body), "name", replace(
    basename(each.key),
    ".json", ""
  ))
  title            = lookup(jsondecode(each.value.response_body), "title", "")
  uploaded_grafana = lookup(jsondecode(each.value.response_body), "uploadedGrafana", false)
  variables        = jsonencode(lookup(jsondecode(each.value.response_body), "variables", {}))

  # TODO: produced an unexpected new value: .version: was cty.StringVal("v4"), but now cty.StringVal("v5").
  # version          = lookup(jsondecode(each.value.response_body), "version", "")
  version = "v5"

  widgets = jsonencode(lookup(jsondecode(each.value.response_body), "widgets", []))

  panel_map = jsonencode(lookup(jsondecode(each.value.response_body), "panelMap", {}))
  tags      = lookup(jsondecode(each.value.response_body), "tags", [])

  lifecycle {
    ignore_changes = [panel_map, version]
  }
}
