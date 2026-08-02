resource "signoz_rule" "node_readiness" {
  alert      = "Node Readiness"
  alert_type = "METRIC_BASED_ALERT"
  annotations = {
    description = "This alert is fired when the defined metric (current value: {{$value}}) crosses the threshold ({{$threshold}})"
    summary     = "This alert is fired when the defined metric (current value: {{$value}}) crosses the threshold ({{$threshold}})"
  }
  condition = {
    absent_for      = null
    alert_on_absent = null
    algorithm       = null
    composite_query = {
      panel_type = "graph"
      queries = [
        {
          builder_formula = null
          builder_query = {
            spec = {
              logs = null
              metrics = {
                aggregations = [
                  {
                    comparison_space_aggregation_param = null
                    metric_name                        = "k8s.node.condition_ready"
                    reduce_to                          = null
                    space_aggregation                  = "avg"
                    temporality                        = "unspecified"
                    time_aggregation                   = "latest"
                  },
                ]
                cursor   = null
                disabled = null
                filter = {
                  expression = ""
                }
                functions = null
                group_by = [
                  {
                    description     = null
                    field_context   = "attribute"
                    field_data_type = "string"
                    name            = "k8s.cluster.name"
                    signal          = null
                    unit            = null
                  },
                  {
                    description     = null
                    field_context   = "attribute"
                    field_data_type = "string"
                    name            = "k8s.node.uid"
                    signal          = null
                    unit            = null
                  },
                  {
                    description     = null
                    field_context   = "attribute"
                    field_data_type = "string"
                    name            = "k8s.node.name"
                    signal          = null
                    unit            = null
                  },
                ]
                having = {
                  expression = ""
                }
                legend                 = "{{k8s.cluster.name}} {{k8s.node.name}}"
                limit                  = null
                limit_by               = null
                name                   = "A"
                offset                 = null
                order                  = null
                secondary_aggregations = null
                select_fields          = null
                signal                 = "metrics"
                source                 = ""
              }
              traces = null
            }
            type = "builder_query"
          }
          builder_trace_operator = null
          clickhouse_sql         = null
          promql                 = null
        },
      ]
      query_type = "builder"
      unit       = "{bool}"
    }
    require_min_points  = null
    required_num_points = null
    seasonality         = null
    selected_query_name = "A"
    thresholds = {
      basic = {
        kind = "basic"
        spec = [
          {
            channels        = var.alert_channels
            match_type      = "at_least_once"
            name            = "critical"
            op              = "equal"
            recovery_target = null
            target          = 0
            target_unit     = ""
          },
        ]
      }
    }
  }
  description = null
  disabled    = false
  evaluation = {
    cumulative = null
    rolling = {
      kind = "rolling"
      spec = {
        eval_window = "5m0s"
        frequency   = "1m"
      }
    }
  }
  labels = null
  notification_settings = {
    group_by             = null
    new_group_eval_delay = null
    renotify = {
      alert_states = null
      enabled      = false
      interval     = "30m"
    }
    use_policy = null
  }
  rule_type      = "threshold_rule"
  schema_version = "v2alpha1"
}

resource "signoz_rule" "pod_failure" {
  alert      = "Pod Failure"
  alert_type = "METRIC_BASED_ALERT"
  annotations = {
    description = "This alert is fired when the defined metric (current value: {{$value}}) crosses the threshold ({{$threshold}})"
    summary     = "This alert is fired when the defined metric (current value: {{$value}}) crosses the threshold ({{$threshold}})"
  }
  condition = {
    absent_for      = null
    alert_on_absent = null
    algorithm       = null
    composite_query = {
      panel_type = "graph"
      queries = [
        {
          builder_formula = null
          builder_query = {
            spec = {
              logs = null
              metrics = {
                aggregations = [
                  {
                    comparison_space_aggregation_param = null
                    metric_name                        = "k8s.pod.phase"
                    reduce_to                          = null
                    space_aggregation                  = "avg"
                    temporality                        = "unspecified"
                    time_aggregation                   = "latest"
                  },
                ]
                cursor   = null
                disabled = null
                filter = {
                  expression = "k8s.namespace.name NOT LIKE 'pde-%'"
                }
                functions = null
                group_by = [
                  {
                    description     = null
                    field_context   = "attribute"
                    field_data_type = "string"
                    name            = "k8s.namespace.name"
                    signal          = null
                    unit            = null
                  },
                  {
                    description     = null
                    field_context   = "attribute"
                    field_data_type = "string"
                    name            = "k8s.pod.name"
                    signal          = null
                    unit            = null
                  },
                  {
                    description     = null
                    field_context   = "attribute"
                    field_data_type = "string"
                    name            = "k8s.cluster.name"
                    signal          = null
                    unit            = null
                  },
                ]
                having = {
                  expression = ""
                }
                legend                 = "{{k8s.cluster.name}} {{k8s.namespace.name}} {{k8s.pod.name}}"
                limit                  = null
                limit_by               = null
                name                   = "A"
                offset                 = null
                order                  = null
                secondary_aggregations = null
                select_fields          = null
                signal                 = "metrics"
                source                 = ""
              }
              traces = null
            }
            type = "builder_query"
          }
          builder_trace_operator = null
          clickhouse_sql         = null
          promql                 = null
        },
      ]
      query_type = "builder"
      unit       = "{count}"
    }
    require_min_points  = null
    required_num_points = null
    seasonality         = null
    selected_query_name = "A"
    thresholds = {
      basic = {
        kind = "basic"
        spec = [
          {
            channels        = var.alert_channels
            match_type      = "at_least_once"
            name            = "critical"
            op              = "equal"
            recovery_target = null
            target          = 4
            target_unit     = "{count}"
          }
        ]
      }
    }
  }
  description = null
  disabled    = false
  evaluation = {
    cumulative = null
    rolling = {
      kind = "rolling"
      spec = {
        eval_window = "5m0s"
        frequency   = "1m"
      }
    }
  }
  labels = null
  notification_settings = {
    group_by             = null
    new_group_eval_delay = null
    renotify = {
      alert_states = null
      enabled      = false
      interval     = "30m"
    }
    use_policy = null
  }
  rule_type      = "threshold_rule"
  schema_version = "v2alpha1"
}

resource "signoz_rule" "node_inode" {
  alert      = "Node Inode Usage"
  alert_type = "METRIC_BASED_ALERT"
  annotations = {
    description = "This alert is fired when the defined metric (current value: {{$value}}) crosses the threshold ({{$threshold}})"
    summary     = "This alert is fired when the defined metric (current value: {{$value}}) crosses the threshold ({{$threshold}})"
  }
  condition = {
    absent_for      = null
    alert_on_absent = null
    algorithm       = null
    composite_query = {
      panel_type = "graph"
      queries = [
        {
          builder_formula = null
          builder_query = {
            spec = {
              logs = null
              metrics = {
                aggregations = [
                  {
                    comparison_space_aggregation_param = null
                    metric_name                        = "system.filesystem.inodes.usage"
                    reduce_to                          = null
                    space_aggregation                  = "avg"
                    temporality                        = ""
                    time_aggregation                   = "avg"
                  },
                ]
                cursor   = null
                disabled = true
                filter = {
                  expression = "state = 'used'"
                }
                functions = null
                group_by = [
                  {
                    description     = null
                    field_context   = "attribute"
                    field_data_type = "string"
                    name            = "k8s.node.name"
                    signal          = null
                    unit            = null
                  },
                  {
                    description     = null
                    field_context   = "attribute"
                    field_data_type = "string"
                    name            = "k8s.cluster.name"
                    signal          = null
                    unit            = null
                  },
                  {
                    description     = null
                    field_context   = "attribute"
                    field_data_type = "string"
                    name            = "device"
                    signal          = null
                    unit            = null
                  },
                  {
                    description     = null
                    field_context   = "attribute"
                    field_data_type = "string"
                    name            = "k8s.node.uid"
                    signal          = null
                    unit            = null
                  },
                ]
                having = {
                  expression = ""
                }
                legend                 = "{{k8s.cluster.name}} {{k8s.node.name}} {{device}}"
                limit                  = null
                limit_by               = null
                name                   = "A"
                offset                 = null
                order                  = null
                secondary_aggregations = null
                select_fields          = null
                signal                 = "metrics"
                source                 = ""
              }
              traces = null
            }
            type = "builder_query"
          }
          builder_trace_operator = null
          clickhouse_sql         = null
          promql                 = null
        },
        {
          builder_formula = null
          builder_query = {
            spec = {
              logs = null
              metrics = {
                aggregations = [
                  {
                    comparison_space_aggregation_param = null
                    metric_name                        = "system.filesystem.inodes.usage"
                    reduce_to                          = null
                    space_aggregation                  = "avg"
                    temporality                        = ""
                    time_aggregation                   = "avg"
                  },
                ]
                cursor   = null
                disabled = true
                filter = {
                  expression = "state = 'free'"
                }
                functions = null
                group_by = [
                  {
                    description     = null
                    field_context   = "attribute"
                    field_data_type = "string"
                    name            = "k8s.node.name"
                    signal          = null
                    unit            = null
                  },
                  {
                    description     = null
                    field_context   = "attribute"
                    field_data_type = "string"
                    name            = "k8s.cluster.name"
                    signal          = null
                    unit            = null
                  },
                  {
                    description     = null
                    field_context   = "attribute"
                    field_data_type = "string"
                    name            = "device"
                    signal          = null
                    unit            = null
                  },
                  {
                    description     = null
                    field_context   = "attribute"
                    field_data_type = "string"
                    name            = "k8s.node.uid"
                    signal          = null
                    unit            = null
                  },
                ]
                having = {
                  expression = ""
                }
                legend                 = "{{k8s.cluster.name}} {{k8s.node.name}} {{device}}"
                limit                  = null
                limit_by               = null
                name                   = "B"
                offset                 = null
                order                  = null
                secondary_aggregations = null
                select_fields          = null
                signal                 = "metrics"
                source                 = ""
              }
              traces = null
            }
            type = "builder_query"
          }
          builder_trace_operator = null
          clickhouse_sql         = null
          promql                 = null
        },
        {
          builder_formula = {
            spec = {
              disabled   = null
              expression = "(A/(A+B)) * 100"
              functions  = null
              having     = null
              legend     = "{{k8s.cluster.name}} {{k8s.node.name}} {{device}}"
              limit      = null
              name       = "F1"
              order      = null
            }
            type = "builder_formula"
          }
          builder_query          = null
          builder_trace_operator = null
          clickhouse_sql         = null
          promql                 = null
        },
      ]
      query_type = "builder"
      unit       = "%"
    }
    require_min_points  = null
    required_num_points = null
    seasonality         = null
    selected_query_name = "F1"
    thresholds = {
      basic = {
        kind = "basic"
        spec = [
          {
            channels        = var.alert_channels
            match_type      = "at_least_once"
            name            = "critical"
            op              = "above"
            recovery_target = null
            target          = 95
            target_unit     = "%"
          },
          {
            channels        = var.alert_channels
            match_type      = "at_least_once"
            name            = "warning"
            op              = "above"
            recovery_target = null
            target          = 85
            target_unit     = "%"
          },
        ]
      }
    }
  }
  description = null
  disabled    = false
  evaluation = {
    cumulative = null
    rolling = {
      kind = "rolling"
      spec = {
        eval_window = "5m0s"
        frequency   = "1m"
      }
    }
  }
  labels = null
  notification_settings = {
    group_by             = null
    new_group_eval_delay = null
    renotify = {
      alert_states = null
      enabled      = false
      interval     = "30m"
    }
    use_policy = null
  }
  rule_type      = "threshold_rule"
  schema_version = "v2alpha1"
}

resource "signoz_rule" "pod_logflood" {
  alert      = "Pod Log Flood"
  alert_type = "LOGS_BASED_ALERT"
  annotations = {
    description = "This alert is fired when the defined metric (current value: {{$value}}) crosses the threshold ({{$threshold}})"
    summary     = "This alert is fired when the defined metric (current value: {{$value}}) crosses the threshold ({{$threshold}})"
  }
  condition = {
    absent_for      = null
    alert_on_absent = null
    algorithm       = null
    composite_query = {
      panel_type = "graph"
      queries = [
        {
          builder_formula = null
          builder_query = {
            spec = {
              logs = {
                aggregations = [
                  {
                    alias      = null
                    expression = "count()"
                  },
                ]
                cursor   = null
                disabled = null
                filter = {
                  expression = ""
                }
                functions = null
                group_by = [
                  {
                    description     = null
                    field_context   = "resource"
                    field_data_type = "string"
                    name            = "k8s.cluster.name"
                    signal          = null
                    unit            = null
                  },
                  {
                    description     = null
                    field_context   = "resource"
                    field_data_type = "string"
                    name            = "k8s.namespace.name"
                    signal          = null
                    unit            = null
                  },
                  {
                    description     = null
                    field_context   = "resource"
                    field_data_type = "string"
                    name            = "k8s.pod.name"
                    signal          = null
                    unit            = null
                  },
                ]
                having = {
                  expression = ""
                }
                legend                 = "{{k8s.cluster.name}} {{k8s.namespace.name}} {{k8s.pod.name}}"
                limit                  = null
                limit_by               = null
                name                   = "A"
                offset                 = null
                order                  = null
                secondary_aggregations = null
                select_fields          = null
                signal                 = "logs"
                source                 = ""
              }
              metrics = null
              traces  = null
            }
            type = "builder_query"
          }
          builder_trace_operator = null
          clickhouse_sql         = null
          promql                 = null
        },
      ]
      query_type = "builder"
      unit       = "{count}"
    }
    require_min_points  = null
    required_num_points = null
    seasonality         = null
    selected_query_name = "A"
    thresholds = {
      basic = {
        kind = "basic"
        spec = [
          {
            channels        = var.alert_channels
            match_type      = "at_least_once"
            name            = "critical"
            op              = "above"
            recovery_target = null
            target          = 10000
            target_unit     = ""
          }
        ]
      }
    }
  }
  description = null
  disabled    = false
  evaluation = {
    cumulative = null
    rolling = {
      kind = "rolling"
      spec = {
        eval_window = "5m0s"
        frequency   = "1m"
      }
    }
  }
  labels = null
  notification_settings = {
    group_by             = null
    new_group_eval_delay = null
    renotify = {
      alert_states = null
      enabled      = false
      interval     = "30m"
    }
    use_policy = null
  }
  rule_type      = "threshold_rule"
  schema_version = "v2alpha1"
}

resource "signoz_rule" "node_memmory" {
  alert      = "Node Memmory Usage"
  alert_type = "METRIC_BASED_ALERT"
  annotations = {
    description = "This alert is fired when the defined metric (current value: {{$value}}) crosses the threshold ({{$threshold}})"
    summary     = "This alert is fired when the defined metric (current value: {{$value}}) crosses the threshold ({{$threshold}})"
  }
  condition = {
    absent_for      = null
    alert_on_absent = null
    algorithm       = null
    composite_query = {
      panel_type = "graph"
      queries = [
        {
          builder_formula = null
          builder_query = {
            spec = {
              logs = null
              metrics = {
                aggregations = [
                  {
                    comparison_space_aggregation_param = null
                    metric_name                        = "k8s.node.memory.rss"
                    reduce_to                          = null
                    space_aggregation                  = "avg"
                    temporality                        = "unspecified"
                    time_aggregation                   = "avg"
                  },
                ]
                cursor   = null
                disabled = true
                filter = {
                  expression = ""
                }
                functions = null
                group_by = [
                  {
                    description     = null
                    field_context   = "attribute"
                    field_data_type = "string"
                    name            = "k8s.node.uid"
                    signal          = null
                    unit            = null
                  },
                  {
                    description     = null
                    field_context   = "attribute"
                    field_data_type = "string"
                    name            = "k8s.node.name"
                    signal          = null
                    unit            = null
                  },
                  {
                    description     = null
                    field_context   = "attribute"
                    field_data_type = "string"
                    name            = "k8s.cluster.name"
                    signal          = null
                    unit            = null
                  },
                ]
                having = {
                  expression = ""
                }
                legend                 = "{{k8s.cluster.name}} {{k8s.node.name}}"
                limit                  = null
                limit_by               = null
                name                   = "A"
                offset                 = null
                order                  = null
                secondary_aggregations = null
                select_fields          = null
                signal                 = "metrics"
                source                 = ""
              }
              traces = null
            }
            type = "builder_query"
          }
          builder_trace_operator = null
          clickhouse_sql         = null
          promql                 = null
        },
        {
          builder_formula = null
          builder_query = {
            spec = {
              logs = null
              metrics = {
                aggregations = [
                  {
                    comparison_space_aggregation_param = null
                    metric_name                        = "k8s.node.allocatable_memory"
                    reduce_to                          = null
                    space_aggregation                  = "avg"
                    temporality                        = "unspecified"
                    time_aggregation                   = "avg"
                  },
                ]
                cursor   = null
                disabled = true
                filter = {
                  expression = ""
                }
                functions = null
                group_by = [
                  {
                    description     = null
                    field_context   = "attribute"
                    field_data_type = "string"
                    name            = "k8s.node.uid"
                    signal          = null
                    unit            = null
                  },
                  {
                    description     = null
                    field_context   = "attribute"
                    field_data_type = "string"
                    name            = "k8s.node.name"
                    signal          = null
                    unit            = null
                  },
                  {
                    description     = null
                    field_context   = "attribute"
                    field_data_type = "string"
                    name            = "k8s.cluster.name"
                    signal          = null
                    unit            = null
                  },
                ]
                having = {
                  expression = ""
                }
                legend                 = "{{k8s.cluster.name}} {{k8s.node.name}}"
                limit                  = null
                limit_by               = null
                name                   = "B"
                offset                 = null
                order                  = null
                secondary_aggregations = null
                select_fields          = null
                signal                 = "metrics"
                source                 = ""
              }
              traces = null
            }
            type = "builder_query"
          }
          builder_trace_operator = null
          clickhouse_sql         = null
          promql                 = null
        },
        {
          builder_formula = {
            spec = {
              disabled   = null
              expression = "(A/B) * 100"
              functions  = null
              having     = null
              legend     = "{{k8s.cluster.name}} {{k8s.node.name}}"
              limit      = null
              name       = "F1"
              order      = null
            }
            type = "builder_formula"
          }
          builder_query          = null
          builder_trace_operator = null
          clickhouse_sql         = null
          promql                 = null
        },
      ]
      query_type = "builder"
      unit       = "%"
    }
    require_min_points  = null
    required_num_points = null
    seasonality         = null
    selected_query_name = "F1"
    thresholds = {
      basic = {
        kind = "basic"
        spec = [
          {
            channels        = var.alert_channels
            match_type      = "at_least_once"
            name            = "critical"
            op              = "above"
            recovery_target = null
            target          = 90
            target_unit     = "%"
          },
          {
            channels        = var.alert_channels
            match_type      = "at_least_once"
            name            = "warning"
            op              = "above"
            recovery_target = null
            target          = 85
            target_unit     = "%"
          },
        ]
      }
    }
  }
  description = null
  disabled    = false
  evaluation = {
    cumulative = null
    rolling = {
      kind = "rolling"
      spec = {
        eval_window = "5m0s"
        frequency   = "1m"
      }
    }
  }
  labels = null
  notification_settings = {
    group_by             = null
    new_group_eval_delay = null
    renotify = {
      alert_states = null
      enabled      = false
      interval     = "30m"
    }
    use_policy = null
  }
  rule_type      = "threshold_rule"
  schema_version = "v2alpha1"
}

resource "signoz_rule" "node_cpu" {
  alert      = "Node CPU Usage"
  alert_type = "METRIC_BASED_ALERT"
  annotations = {
    description = "This alert is fired when the defined metric (current value: {{$value}}) crosses the threshold ({{$threshold}})"
    summary     = "This alert is fired when the defined metric (current value: {{$value}}) crosses the threshold ({{$threshold}})"
  }
  condition = {
    absent_for      = null
    alert_on_absent = null
    algorithm       = null
    composite_query = {
      panel_type = "graph"
      queries = [
        {
          builder_formula = null
          builder_query = {
            spec = {
              logs = null
              metrics = {
                aggregations = [
                  {
                    comparison_space_aggregation_param = null
                    metric_name                        = "k8s.node.cpu.usage"
                    reduce_to                          = null
                    space_aggregation                  = "avg"
                    temporality                        = "unspecified"
                    time_aggregation                   = "avg"
                  },
                ]
                cursor   = null
                disabled = true
                filter = {
                  expression = ""
                }
                functions = null
                group_by = [
                  {
                    description     = null
                    field_context   = "attribute"
                    field_data_type = "string"
                    name            = "k8s.node.uid"
                    signal          = null
                    unit            = null
                  },
                  {
                    description     = null
                    field_context   = "attribute"
                    field_data_type = "string"
                    name            = "k8s.node.name"
                    signal          = null
                    unit            = null
                  },
                  {
                    description     = null
                    field_context   = "attribute"
                    field_data_type = "string"
                    name            = "k8s.cluster.name"
                    signal          = null
                    unit            = null
                  },
                ]
                having = {
                  expression = ""
                }
                legend                 = "{{k8s.cluster.name}} {{k8s.node.name}}"
                limit                  = null
                limit_by               = null
                name                   = "A"
                offset                 = null
                order                  = null
                secondary_aggregations = null
                select_fields          = null
                signal                 = "metrics"
                source                 = ""
              }
              traces = null
            }
            type = "builder_query"
          }
          builder_trace_operator = null
          clickhouse_sql         = null
          promql                 = null
        },
        {
          builder_formula = null
          builder_query = {
            spec = {
              logs = null
              metrics = {
                aggregations = [
                  {
                    comparison_space_aggregation_param = null
                    metric_name                        = "k8s.node.allocatable_cpu"
                    reduce_to                          = null
                    space_aggregation                  = "avg"
                    temporality                        = "unspecified"
                    time_aggregation                   = "avg"
                  },
                ]
                cursor   = null
                disabled = true
                filter = {
                  expression = ""
                }
                functions = null
                group_by = [
                  {
                    description     = null
                    field_context   = "attribute"
                    field_data_type = "string"
                    name            = "k8s.node.uid"
                    signal          = null
                    unit            = null
                  },
                  {
                    description     = null
                    field_context   = "attribute"
                    field_data_type = "string"
                    name            = "k8s.node.name"
                    signal          = null
                    unit            = null
                  },
                  {
                    description     = null
                    field_context   = "attribute"
                    field_data_type = "string"
                    name            = "k8s.cluster.name"
                    signal          = null
                    unit            = null
                  },
                ]
                having = {
                  expression = ""
                }
                legend                 = "{{k8s.cluster.name}} {{k8s.node.name}}"
                limit                  = null
                limit_by               = null
                name                   = "B"
                offset                 = null
                order                  = null
                secondary_aggregations = null
                select_fields          = null
                signal                 = "metrics"
                source                 = ""
              }
              traces = null
            }
            type = "builder_query"
          }
          builder_trace_operator = null
          clickhouse_sql         = null
          promql                 = null
        },
        {
          builder_formula = {
            spec = {
              disabled   = null
              expression = "(A/B) * 100"
              functions  = null
              having     = null
              legend     = "{{k8s.cluster.name}} {{k8s.node.name}}"
              limit      = null
              name       = "F1"
              order      = null
            }
            type = "builder_formula"
          }
          builder_query          = null
          builder_trace_operator = null
          clickhouse_sql         = null
          promql                 = null
        },
      ]
      query_type = "builder"
      unit       = "%"
    }
    require_min_points  = null
    required_num_points = null
    seasonality         = null
    selected_query_name = "F1"
    thresholds = {
      basic = {
        kind = "basic"
        spec = [
          {
            channels        = var.alert_channels
            match_type      = "at_least_once"
            name            = "critical"
            op              = "above"
            recovery_target = null
            target          = 95
            target_unit     = "%"
          },
          {
            channels        = var.alert_channels
            match_type      = "at_least_once"
            name            = "warning"
            op              = "above"
            recovery_target = null
            target          = 90
            target_unit     = "%"
          },
        ]
      }
    }
  }
  description = null
  disabled    = false
  evaluation = {
    cumulative = null
    rolling = {
      kind = "rolling"
      spec = {
        eval_window = "5m0s"
        frequency   = "1m"
      }
    }
  }
  labels = null
  notification_settings = {
    group_by             = null
    new_group_eval_delay = null
    renotify = {
      alert_states = null
      enabled      = false
      interval     = "30m"
    }
    use_policy = null
  }
  rule_type      = "threshold_rule"
  schema_version = "v2alpha1"
}

resource "signoz_rule" "pod_pvc" {
  alert      = "Pod PVC Usage"
  alert_type = "METRIC_BASED_ALERT"
  annotations = {
    description = "This alert is fired when the defined metric (current value: {{$value}}) crosses the threshold ({{$threshold}})"
    summary     = "This alert is fired when the defined metric (current value: {{$value}}) crosses the threshold ({{$threshold}})"
  }
  condition = {
    absent_for      = null
    alert_on_absent = null
    algorithm       = null
    composite_query = {
      panel_type = "graph"
      queries = [
        {
          builder_formula = null
          builder_query = {
            spec = {
              logs = null
              metrics = {
                aggregations = [
                  {
                    comparison_space_aggregation_param = null
                    metric_name                        = "k8s.volume.capacity"
                    reduce_to                          = null
                    space_aggregation                  = "avg"
                    temporality                        = "unspecified"
                    time_aggregation                   = "avg"
                  },
                ]
                cursor   = null
                disabled = true
                filter = {
                  expression = "k8s.volume.type = 'persistentVolumeClaim'"
                }
                functions = null
                group_by = [
                  {
                    description     = null
                    field_context   = "attribute"
                    field_data_type = "string"
                    name            = "k8s.namespace.name"
                    signal          = null
                    unit            = null
                  },
                  {
                    description     = null
                    field_context   = "attribute"
                    field_data_type = "string"
                    name            = "k8s.cluster.name"
                    signal          = null
                    unit            = null
                  },
                  {
                    description     = null
                    field_context   = null
                    field_data_type = null
                    name            = "k8s.persistentvolumeclaim.name"
                    signal          = null
                    unit            = null
                  },
                ]
                having = {
                  expression = ""
                }
                legend                 = "{{k8s.cluster.name}} {{k8s.namespace.name}} {{k8s.persistentvolumeclaim.name}}"
                limit                  = null
                limit_by               = null
                name                   = "A"
                offset                 = null
                order                  = null
                secondary_aggregations = null
                select_fields          = null
                signal                 = "metrics"
                source                 = ""
              }
              traces = null
            }
            type = "builder_query"
          }
          builder_trace_operator = null
          clickhouse_sql         = null
          promql                 = null
        },
        {
          builder_formula = null
          builder_query = {
            spec = {
              logs = null
              metrics = {
                aggregations = [
                  {
                    comparison_space_aggregation_param = null
                    metric_name                        = "k8s.volume.available"
                    reduce_to                          = null
                    space_aggregation                  = "avg"
                    temporality                        = "unspecified"
                    time_aggregation                   = "avg"
                  },
                ]
                cursor   = null
                disabled = true
                filter = {
                  expression = "k8s.volume.type = 'persistentVolumeClaim'"
                }
                functions = null
                group_by = [
                  {
                    description     = null
                    field_context   = "attribute"
                    field_data_type = "string"
                    name            = "k8s.namespace.name"
                    signal          = null
                    unit            = null
                  },
                  {
                    description     = null
                    field_context   = "attribute"
                    field_data_type = "string"
                    name            = "k8s.cluster.name"
                    signal          = null
                    unit            = null
                  },
                  {
                    description     = null
                    field_context   = null
                    field_data_type = null
                    name            = "k8s.persistentvolumeclaim.name"
                    signal          = null
                    unit            = null
                  },
                ]
                having = {
                  expression = ""
                }
                legend                 = "{{k8s.cluster.name}} {{k8s.namespace.name}} {{k8s.persistentvolumeclaim.name}}"
                limit                  = null
                limit_by               = null
                name                   = "B"
                offset                 = null
                order                  = null
                secondary_aggregations = null
                select_fields          = null
                signal                 = "metrics"
                source                 = ""
              }
              traces = null
            }
            type = "builder_query"
          }
          builder_trace_operator = null
          clickhouse_sql         = null
          promql                 = null
        },
        {
          builder_formula = {
            spec = {
              disabled   = null
              expression = "(1 - B/A) * 100"
              functions  = null
              having     = null
              legend     = "{{k8s.cluster.name}} {{k8s.namespace.name}} {{k8s.persistentvolumeclaim.name}}"
              limit      = null
              name       = "F1"
              order      = null
            }
            type = "builder_formula"
          }
          builder_query          = null
          builder_trace_operator = null
          clickhouse_sql         = null
          promql                 = null
        },
      ]
      query_type = "builder"
      unit       = "%"
    }
    require_min_points  = null
    required_num_points = null
    seasonality         = null
    selected_query_name = "F1"
    thresholds = {
      basic = {
        kind = "basic"
        spec = [
          {
            channels        = var.alert_channels
            match_type      = "at_least_once"
            name            = "critical"
            op              = "above"
            recovery_target = null
            target          = 98
            target_unit     = "%"
          },
          {
            channels        = var.alert_channels
            match_type      = "at_least_once"
            name            = "warning"
            op              = "above"
            recovery_target = null
            target          = 90
            target_unit     = "%"
          },
        ]
      }
    }
  }
  description = null
  disabled    = false
  evaluation = {
    cumulative = null
    rolling = {
      kind = "rolling"
      spec = {
        eval_window = "5m0s"
        frequency   = "1m"
      }
    }
  }
  labels = null
  notification_settings = {
    group_by             = null
    new_group_eval_delay = null
    renotify = {
      alert_states = null
      enabled      = false
      interval     = "30m"
    }
    use_policy = null
  }
  rule_type      = "threshold_rule"
  schema_version = "v2alpha1"
}

resource "signoz_rule" "node_disk" {
  alert      = "Node Disk Usage"
  alert_type = "METRIC_BASED_ALERT"
  annotations = {
    description = "This alert is fired when the defined metric (current value: {{$value}}) crosses the threshold ({{$threshold}})"
    summary     = "This alert is fired when the defined metric (current value: {{$value}}) crosses the threshold ({{$threshold}})"
  }
  condition = {
    absent_for      = null
    alert_on_absent = null
    algorithm       = null
    composite_query = {
      panel_type = "graph"
      queries = [
        {
          builder_formula = null
          builder_query = {
            spec = {
              logs = null
              metrics = {
                aggregations = [
                  {
                    comparison_space_aggregation_param = null
                    metric_name                        = "k8s.node.filesystem.usage"
                    reduce_to                          = null
                    space_aggregation                  = "avg"
                    temporality                        = "unspecified"
                    time_aggregation                   = "avg"
                  },
                ]
                cursor   = null
                disabled = true
                filter = {
                  expression = ""
                }
                functions = null
                group_by = [
                  {
                    description     = null
                    field_context   = "attribute"
                    field_data_type = "string"
                    name            = "k8s.node.uid"
                    signal          = null
                    unit            = null
                  },
                  {
                    description     = null
                    field_context   = "attribute"
                    field_data_type = "string"
                    name            = "k8s.node.name"
                    signal          = null
                    unit            = null
                  },
                  {
                    description     = null
                    field_context   = "attribute"
                    field_data_type = "string"
                    name            = "k8s.cluster.name"
                    signal          = null
                    unit            = null
                  },
                ]
                having = {
                  expression = ""
                }
                legend                 = "{{k8s.node.name}}"
                limit                  = null
                limit_by               = null
                name                   = "A"
                offset                 = null
                order                  = null
                secondary_aggregations = null
                select_fields          = null
                signal                 = "metrics"
                source                 = ""
              }
              traces = null
            }
            type = "builder_query"
          }
          builder_trace_operator = null
          clickhouse_sql         = null
          promql                 = null
        },
        {
          builder_formula = null
          builder_query = {
            spec = {
              logs = null
              metrics = {
                aggregations = [
                  {
                    comparison_space_aggregation_param = null
                    metric_name                        = "k8s.node.filesystem.capacity"
                    reduce_to                          = null
                    space_aggregation                  = "avg"
                    temporality                        = "unspecified"
                    time_aggregation                   = "avg"
                  },
                ]
                cursor   = null
                disabled = true
                filter = {
                  expression = ""
                }
                functions = null
                group_by = [
                  {
                    description     = null
                    field_context   = "attribute"
                    field_data_type = "string"
                    name            = "k8s.node.uid"
                    signal          = null
                    unit            = null
                  },
                  {
                    description     = null
                    field_context   = "attribute"
                    field_data_type = "string"
                    name            = "k8s.node.name"
                    signal          = null
                    unit            = null
                  },
                  {
                    description     = null
                    field_context   = "attribute"
                    field_data_type = "string"
                    name            = "k8s.cluster.name"
                    signal          = null
                    unit            = null
                  },
                ]
                having = {
                  expression = ""
                }
                legend                 = "{{k8s.node.name}}"
                limit                  = null
                limit_by               = null
                name                   = "B"
                offset                 = null
                order                  = null
                secondary_aggregations = null
                select_fields          = null
                signal                 = "metrics"
                source                 = ""
              }
              traces = null
            }
            type = "builder_query"
          }
          builder_trace_operator = null
          clickhouse_sql         = null
          promql                 = null
        },
        {
          builder_formula = {
            spec = {
              disabled   = null
              expression = "(A/B) * 100"
              functions  = null
              having     = null
              legend     = "{{k8s.cluster.name}} {{k8s.node.name}}"
              limit      = null
              name       = "F1"
              order      = null
            }
            type = "builder_formula"
          }
          builder_query          = null
          builder_trace_operator = null
          clickhouse_sql         = null
          promql                 = null
        },
      ]
      query_type = "builder"
      unit       = "%"
    }
    require_min_points  = null
    required_num_points = null
    seasonality         = null
    selected_query_name = "F1"
    thresholds = {
      basic = {
        kind = "basic"
        spec = [
          {
            channels        = var.alert_channels
            match_type      = "at_least_once"
            name            = "critical"
            op              = "above"
            recovery_target = null
            target          = 95
            target_unit     = "%"
          },
          {
            channels        = var.alert_channels
            match_type      = "at_least_once"
            name            = "warning"
            op              = "above"
            recovery_target = null
            target          = 90
            target_unit     = "%"
          },
        ]
      }
    }
  }
  description = null
  disabled    = false
  evaluation = {
    cumulative = null
    rolling = {
      kind = "rolling"
      spec = {
        eval_window = "5m0s"
        frequency   = "1m"
      }
    }
  }
  labels = null
  notification_settings = {
    group_by             = null
    new_group_eval_delay = null
    renotify = {
      alert_states = null
      enabled      = false
      interval     = "30m"
    }
    use_policy = null
  }
  rule_type      = "threshold_rule"
  schema_version = "v2alpha1"
}

resource "signoz_rule" "postgresql_connection" {
  alert      = "Postgresql Connection Usage"
  alert_type = "METRIC_BASED_ALERT"
  annotations = {
    description = "This alert is fired when the defined metric (current value: {{$value}}) crosses the threshold ({{$threshold}})"
    summary     = "This alert is fired when the defined metric (current value: {{$value}}) crosses the threshold ({{$threshold}})"
  }
  condition = {
    absent_for      = null
    alert_on_absent = null
    algorithm       = null
    composite_query = {
      panel_type = "graph"
      queries = [
        {
          builder_formula = null
          builder_query = {
            spec = {
              logs = null
              metrics = {
                aggregations = [
                  {
                    comparison_space_aggregation_param = null
                    metric_name                        = "postgresql.connection.max"
                    reduce_to                          = null
                    space_aggregation                  = "avg"
                    temporality                        = "unspecified"
                    time_aggregation                   = "latest"
                  },
                ]
                cursor   = null
                disabled = true
                filter = {
                  expression = ""
                }
                functions = null
                group_by = [
                  {
                    description     = null
                    field_context   = "attribute"
                    field_data_type = "string"
                    name            = "k8s.cluster.name"
                    signal          = null
                    unit            = null
                  },
                  {
                    description     = null
                    field_context   = "attribute"
                    field_data_type = "string"
                    name            = "service.instance.id"
                    signal          = null
                    unit            = null
                  },
                ]
                having = {
                  expression = ""
                }
                legend                 = "max {{k8s.cluster.name}} {{service.instance.id}}"
                limit                  = null
                limit_by               = null
                name                   = "A"
                offset                 = null
                order                  = null
                secondary_aggregations = null
                select_fields          = null
                signal                 = "metrics"
                source                 = ""
              }
              traces = null
            }
            type = "builder_query"
          }
          builder_trace_operator = null
          clickhouse_sql         = null
          promql                 = null
        },
        {
          builder_formula = null
          builder_query = {
            spec = {
              logs = null
              metrics = {
                aggregations = [
                  {
                    comparison_space_aggregation_param = null
                    metric_name                        = "postgresql.backends"
                    reduce_to                          = null
                    space_aggregation                  = "sum"
                    temporality                        = ""
                    time_aggregation                   = "max"
                  },
                ]
                cursor   = null
                disabled = true
                filter = {
                  expression = ""
                }
                functions = null
                group_by = [
                  {
                    description     = null
                    field_context   = "attribute"
                    field_data_type = "string"
                    name            = "k8s.cluster.name"
                    signal          = null
                    unit            = null
                  },
                  {
                    description     = null
                    field_context   = "attribute"
                    field_data_type = "string"
                    name            = "service.instance.id"
                    signal          = null
                    unit            = null
                  },
                ]
                having = {
                  expression = ""
                }
                legend                 = "current {{k8s.cluster.name}} {{service.instance.id}}"
                limit                  = null
                limit_by               = null
                name                   = "C"
                offset                 = null
                order                  = null
                secondary_aggregations = null
                select_fields          = null
                signal                 = "metrics"
                source                 = ""
              }
              traces = null
            }
            type = "builder_query"
          }
          builder_trace_operator = null
          clickhouse_sql         = null
          promql                 = null
        },
        {
          builder_formula = {
            spec = {
              disabled   = null
              expression = "(C/A) * 100"
              functions  = null
              having     = null
              legend     = "{{k8s.cluster.name}} {{service.instance.id}}"
              limit      = null
              name       = "F1"
              order      = null
            }
            type = "builder_formula"
          }
          builder_query          = null
          builder_trace_operator = null
          clickhouse_sql         = null
          promql                 = null
        },
      ]
      query_type = "builder"
      unit       = "%"
    }
    require_min_points  = null
    required_num_points = null
    seasonality         = null
    selected_query_name = "F1"
    thresholds = {
      basic = {
        kind = "basic"
        spec = [
          {
            channels        = var.alert_channels
            match_type      = "at_least_once"
            name            = "critical"
            op              = "above"
            recovery_target = null
            target          = 99
            target_unit     = "%"
          },
          {
            channels        = var.alert_channels
            match_type      = "at_least_once"
            name            = "warning"
            op              = "above"
            recovery_target = null
            target          = 95
            target_unit     = "%"
          },
        ]
      }
    }
  }
  description = null
  disabled    = false
  evaluation = {
    cumulative = null
    rolling = {
      kind = "rolling"
      spec = {
        eval_window = "5m0s"
        frequency   = "1m"
      }
    }
  }
  labels = null
  notification_settings = {
    group_by             = null
    new_group_eval_delay = null
    renotify = {
      alert_states = null
      enabled      = false
      interval     = "30m"
    }
    use_policy = null
  }
  rule_type      = "threshold_rule"
  schema_version = "v2alpha1"
}
