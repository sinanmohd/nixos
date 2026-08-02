resource "signoz_dashboard" "k8s_pod_overall" {
  name           = "kubernetes-pod-metrics-overall-bqp9op5i"
  schema_version = "v6"
  spec = {
    display = {
      name = "Kubernetes Pod Metrics - Overall"
    }
    layouts = [
      {
        grid = {
          kind = "Grid"
          spec = {
            items = [
              {
                content = {
                  ref = "#/spec/panels/e16d581d-1da9-49ff-9c3b-1bb51c2f7730"
                }
                height = 7
                width  = 6
                x      = 0
                y      = 0
              },
              {
                content = {
                  ref = "#/spec/panels/18c1653b-f826-460d-9302-90bc6d3f5e52"
                }
                height = 7
                width  = 6
                x      = 6
                y      = 0
              },
              {
                content = {
                  ref = "#/spec/panels/a2cd4e4a-0b81-4a85-937f-48ca5c9f183b"
                }
                height = 7
                width  = 6
                x      = 0
                y      = 7
              },
              {
                content = {
                  ref = "#/spec/panels/1406e6b6-0c99-46d4-9782-530f6e7e053a"
                }
                height = 7
                width  = 6
                x      = 6
                y      = 7
              },
            ]
          }
        }
      },
    ]
    links = [
    ]
    panels = {
      "1406e6b6-0c99-46d4-9782-530f6e7e053a" = {
        kind = "Panel"
        spec = {
          display = {
            name = "Pod filesystem usage"
          }
          links = [
          ]
          plugin = {
            time_series_panel = {
              kind = "signoz/TimeSeriesPanel"
              spec = {
                axes = {
                  is_log_scale = false
                  soft_max     = 0
                  soft_min     = 0
                }
                chart_appearance = {
                  fill_mode          = "none"
                  line_interpolation = "spline"
                  line_style         = "solid"
                  show_points        = false
                  span_gaps = {
                    fill_only_below = false
                  }
                }
                formatting = {
                  decimal_precision = "2"
                  unit              = "percentunit"
                }
                legend = {
                  mode     = "list"
                  position = "bottom"
                }
                visualization = {
                  fill_spans      = false
                  time_preference = "global_time"
                }
              }
            }
          }
          queries = [
            {
              kind = "time_series"
              spec = {
                plugin = {
                  composite_query = {
                    kind = "signoz/CompositeQuery"
                    spec = {
                      queries = [
                        {
                          builder_query = {
                            spec = {
                              metrics = {
                                aggregations = [
                                  {
                                    metric_name       = "k8s.pod.filesystem.available"
                                    reduce_to         = "sum"
                                    space_aggregation = "sum"
                                    time_aggregation  = "avg"
                                  },
                                ]
                                disabled = true
                                filter = {
                                  expression = "(k8s.cluster.name IN $k8s.cluster.name  AND k8s.node.name IN $k8s.node.name AND k8s.namespace.name IN $k8s.namespace.name)"
                                }
                                functions = [
                                ]
                                group_by = [
                                  {
                                    field_context   = "attribute"
                                    field_data_type = "string"
                                    name            = "k8s.node.name"
                                  },
                                  {
                                    field_context   = "attribute"
                                    field_data_type = "string"
                                    name            = "k8s.namespace.name"
                                  },
                                  {
                                    field_context   = "attribute"
                                    field_data_type = "string"
                                    name            = "k8s.pod.name"
                                  },
                                ]
                                having = {
                                }
                                name = "A"
                                order = [
                                ]
                                signal        = "metrics"
                              }
                            }
                            type = "builder_query"
                          }
                        },
                        {
                          builder_query = {
                            spec = {
                              metrics = {
                                aggregations = [
                                  {
                                    metric_name       = "k8s.pod.filesystem.capacity"
                                    reduce_to         = "sum"
                                    space_aggregation = "sum"
                                    time_aggregation  = "avg"
                                  },
                                ]
                                disabled = true
                                filter = {
                                  expression = "(k8s.cluster.name IN $k8s.cluster.name  AND k8s.node.name IN $k8s.node.name AND k8s.namespace.name IN $k8s.namespace.name)"
                                }
                                functions = [
                                ]
                                group_by = [
                                  {
                                    field_context   = "attribute"
                                    field_data_type = "string"
                                    name            = "k8s.node.name"
                                  },
                                  {
                                    field_context   = "attribute"
                                    field_data_type = "string"
                                    name            = "k8s.namespace.name"
                                  },
                                  {
                                    field_context   = "attribute"
                                    field_data_type = "string"
                                    name            = "k8s.pod.name"
                                  },
                                ]
                                having = {
                                }
                                name = "B"
                                order = [
                                ]
                                signal        = "metrics"
                              }
                            }
                            type = "builder_query"
                          }
                        },
                        {
                          builder_formula = {
                            spec = {
                              disabled   = false
                              expression = "(B-A)/B"
                              having = {
                              }
                              legend = "{{k8s.node.name}}-{{k8s.namespace.name}}-{{k8s.pod.name}}"
                              name   = "F1"
                            }
                            type = "builder_formula"
                          }
                        },
                      ]
                    }
                  }
                }
              }
            },
          ]
        }
      }
      "18c1653b-f826-460d-9302-90bc6d3f5e52" = {
        kind = "Panel"
        spec = {
          display = {
            name = "Pod memory usage (WSS)"
          }
          links = [
          ]
          plugin = {
            time_series_panel = {
              kind = "signoz/TimeSeriesPanel"
              spec = {
                axes = {
                  is_log_scale = false
                  soft_max     = 0
                  soft_min     = 0
                }
                chart_appearance = {
                  fill_mode          = "none"
                  line_interpolation = "spline"
                  line_style         = "solid"
                  show_points        = false
                  span_gaps = {
                    fill_only_below = false
                  }
                }
                formatting = {
                  decimal_precision = "2"
                  unit              = "bytes"
                }
                legend = {
                  mode     = "list"
                  position = "bottom"
                }
                visualization = {
                  fill_spans      = false
                  time_preference = "global_time"
                }
              }
            }
          }
          queries = [
            {
              kind = "time_series"
              spec = {
                name = "A"
                plugin = {
                  builder_query = {
                    kind = "signoz/BuilderQuery"
                    spec = {
                      metrics = {
                        aggregations = [
                          {
                            metric_name       = "k8s.pod.memory.working_set"
                            reduce_to         = "sum"
                            space_aggregation = "sum"
                            time_aggregation  = "avg"
                          },
                        ]
                        disabled = false
                        filter = {
                          expression = "(k8s.cluster.name IN $k8s.cluster.name  AND k8s.node.name IN $k8s.node.name AND k8s.namespace.name IN $k8s.namespace.name)"
                        }
                        functions = [
                        ]
                        group_by = [
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "k8s.node.name"
                          },
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "k8s.namespace.name"
                          },
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "k8s.pod.name"
                          },
                        ]
                        having = {
                        }
                        legend = "{{k8s.namespace.name}}-{{k8s.pod.name}}"
                        name   = "A"
                        order = [
                        ]
                        signal        = "metrics"
                      }
                    }
                  }
                }
              }
            },
          ]
        }
      }
      a2cd4e4a-0b81-4a85-937f-48ca5c9f183b = {
        kind = "Panel"
        spec = {
          display = {
            name = "Pod network IO"
          }
          links = [
          ]
          plugin = {
            time_series_panel = {
              kind = "signoz/TimeSeriesPanel"
              spec = {
                axes = {
                  is_log_scale = false
                  soft_max     = 0
                  soft_min     = 0
                }
                chart_appearance = {
                  fill_mode          = "none"
                  line_interpolation = "spline"
                  line_style         = "solid"
                  show_points        = false
                  span_gaps = {
                    fill_only_below = false
                  }
                }
                formatting = {
                  decimal_precision = "2"
                  unit              = "bytes"
                }
                legend = {
                  mode     = "list"
                  position = "bottom"
                }
                visualization = {
                  fill_spans      = false
                  time_preference = "global_time"
                }
              }
            }
          }
          queries = [
            {
              kind = "time_series"
              spec = {
                name = "A"
                plugin = {
                  builder_query = {
                    kind = "signoz/BuilderQuery"
                    spec = {
                      metrics = {
                        aggregations = [
                          {
                            metric_name       = "k8s.pod.network.io"
                            reduce_to         = "sum"
                            space_aggregation = "sum"
                            time_aggregation  = "rate"
                          },
                        ]
                        disabled = false
                        filter = {
                          expression = "(k8s.cluster.name IN $k8s.cluster.name  AND k8s.node.name IN $k8s.node.name AND k8s.namespace.name IN $k8s.namespace.name)"
                        }
                        functions = [
                        ]
                        group_by = [
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "interface"
                          },
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "direction"
                          },
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "k8s.node.name"
                          },
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "k8s.namespace.name"
                          },
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "k8s.pod.name"
                          },
                        ]
                        having = {
                        }
                        legend = "{{k8s.namespace.name}}-{{k8s.pod.name}}-{{interface}}-{{direction}}"
                        name   = "A"
                        order = [
                        ]
                        signal        = "metrics"
                      }
                    }
                  }
                }
              }
            },
          ]
        }
      }
      e16d581d-1da9-49ff-9c3b-1bb51c2f7730 = {
        kind = "Panel"
        spec = {
          display = {
            name = "Pod CPU usage"
          }
          links = [
          ]
          plugin = {
            time_series_panel = {
              kind = "signoz/TimeSeriesPanel"
              spec = {
                axes = {
                  is_log_scale = false
                  soft_max     = 0
                  soft_min     = 0
                }
                chart_appearance = {
                  fill_mode          = "none"
                  line_interpolation = "spline"
                  line_style         = "solid"
                  show_points        = false
                  span_gaps = {
                    fill_only_below = false
                  }
                }
                formatting = {
                  decimal_precision = "2"
                  unit              = "none"
                }
                legend = {
                  mode     = "list"
                  position = "bottom"
                }
                visualization = {
                  fill_spans      = false
                  time_preference = "global_time"
                }
              }
            }
          }
          queries = [
            {
              kind = "time_series"
              spec = {
                name = "A"
                plugin = {
                  builder_query = {
                    kind = "signoz/BuilderQuery"
                    spec = {
                      metrics = {
                        aggregations = [
                          {
                            metric_name       = "k8s.pod.cpu.time"
                            reduce_to         = "sum"
                            space_aggregation = "sum"
                            time_aggregation  = "rate"
                          },
                        ]
                        disabled = false
                        filter = {
                          expression = "(k8s.cluster.name IN $k8s.cluster.name  AND k8s.node.name IN $k8s.node.name AND k8s.namespace.name IN $k8s.namespace.name)"
                        }
                        functions = [
                        ]
                        group_by = [
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "k8s.node.name"
                          },
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "k8s.pod.name"
                          },
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "k8s.namespace.name"
                          },
                        ]
                        having = {
                        }
                        legend = "{{k8s.namespace.name}}-{{k8s.pod.name}}"
                        name   = "A"
                        order = [
                        ]
                        signal        = "metrics"
                      }
                    }
                  }
                }
              }
            },
          ]
        }
      }
    }
    variables = [
      {
        list_variable = {
          kind = "ListVariable"
          spec = {
            allow_all_value = false
            allow_multiple  = false
            display = {
              description = "The k8s.cluster.name"
              name        = "k8s.cluster.name"
            }
            name = "k8s.cluster.name"
            plugin = {
              dynamic_variable = {
                kind = "signoz/DynamicVariable"
                spec = {
                  name   = "k8s.cluster.name"
                  signal = "all"
                }
              }
            }
            sort = "none"
          }
        }
      },
      {
        list_variable = {
          kind = "ListVariable"
          spec = {
            allow_all_value = true
            allow_multiple  = true
            display = {
              description = "The k8s node name."
              name        = "k8s.node.name"
            }
            name = "k8s.node.name"
            plugin = {
              dynamic_variable = {
                kind = "signoz/DynamicVariable"
                spec = {
                  name   = "k8s.node.name"
                  signal = "all"
                }
              }
            }
            sort = "alphabetical-asc"
          }
        }
      },
      {
        list_variable = {
          kind = "ListVariable"
          spec = {
            allow_all_value = true
            allow_multiple  = true
            display = {
              description = "The k8s namespace name"
              name        = "k8s.namespace.name"
            }
            name = "k8s.namespace.name"
            plugin = {
              dynamic_variable = {
                kind = "signoz/DynamicVariable"
                spec = {
                  name   = "k8s.namespace.name"
                  signal = "all"
                }
              }
            }
            sort = "alphabetical-asc"
          }
        }
      },
    ]
  }
  tags = [
    {
      key   = "tag"
      value = "pod"
    },
    {
      key   = "tag"
      value = "k8s"
    },
  ]
}

resource "signoz_dashboard" "k8s_node_metrics_overall" {
  name           = "kubernetes-node-metrics-overall-4i624gs6"
  schema_version = "v6"
  spec = {
    display = {
      name = "Kubernetes Node Metrics - Overall"
    }
    layouts = [
      {
        grid = {
          kind = "Grid"
          spec = {
            items = [
              {
                content = {
                  ref = "#/spec/panels/e16d581d-1da9-49ff-9c3b-1bb51c2f7730"
                }
                height = 7
                width  = 6
                x      = 0
                y      = 0
              },
              {
                content = {
                  ref = "#/spec/panels/18c1653b-f826-460d-9302-90bc6d3f5e52"
                }
                height = 7
                width  = 6
                x      = 6
                y      = 0
              },
              {
                content = {
                  ref = "#/spec/panels/a2cd4e4a-0b81-4a85-937f-48ca5c9f183b"
                }
                height = 7
                width  = 6
                x      = 0
                y      = 7
              },
              {
                content = {
                  ref = "#/spec/panels/1406e6b6-0c99-46d4-9782-530f6e7e053a"
                }
                height = 7
                width  = 6
                x      = 6
                y      = 7
              },
            ]
          }
        }
      },
    ]
    links = [
    ]
    panels = {
      "1406e6b6-0c99-46d4-9782-530f6e7e053a" = {
        kind = "Panel"
        spec = {
          display = {
            name = "Node filesystem usage"
          }
          links = [
          ]
          plugin = {
            time_series_panel = {
              kind = "signoz/TimeSeriesPanel"
              spec = {
                axes = {
                  is_log_scale = false
                  soft_max     = 0
                  soft_min     = 0
                }
                chart_appearance = {
                  fill_mode          = "none"
                  line_interpolation = "spline"
                  line_style         = "solid"
                  show_points        = false
                  span_gaps = {
                    fill_only_below = false
                  }
                }
                formatting = {
                  decimal_precision = "2"
                  unit              = "percentunit"
                }
                legend = {
                  mode     = "list"
                  position = "bottom"
                }
                visualization = {
                  fill_spans      = false
                  time_preference = "global_time"
                }
              }
            }
          }
          queries = [
            {
              kind = "time_series"
              spec = {
                plugin = {
                  composite_query = {
                    kind = "signoz/CompositeQuery"
                    spec = {
                      queries = [
                        {
                          builder_query = {
                            spec = {
                              metrics = {
                                aggregations = [
                                  {
                                    metric_name       = "k8s.node.filesystem.available"
                                    reduce_to         = "sum"
                                    space_aggregation = "sum"
                                    time_aggregation  = "avg"
                                  },
                                ]
                                disabled = true
                                filter = {
                                  expression = "(k8s.cluster.name IN $k8s.cluster.name  AND k8s.node.name IN $k8s.node.name)"
                                }
                                functions = [
                                ]
                                group_by = [
                                  {
                                    field_context   = "attribute"
                                    field_data_type = "string"
                                    name            = "k8s.node.name"
                                  },
                                ]
                                having = {
                                }
                                name = "A"
                                order = [
                                ]
                                signal        = "metrics"
                              }
                            }
                            type = "builder_query"
                          }
                        },
                        {
                          builder_query = {
                            spec = {
                              metrics = {
                                aggregations = [
                                  {
                                    metric_name       = "k8s.node.filesystem.capacity"
                                    reduce_to         = "sum"
                                    space_aggregation = "sum"
                                    time_aggregation  = "avg"
                                  },
                                ]
                                disabled = true
                                filter = {
                                  expression = "(k8s.cluster.name IN $k8s.cluster.name  AND k8s.node.name IN $k8s.node.name)"
                                }
                                functions = [
                                ]
                                group_by = [
                                  {
                                    field_context   = "attribute"
                                    field_data_type = "string"
                                    name            = "k8s.node.name"
                                  },
                                ]
                                having = {
                                }
                                name = "B"
                                order = [
                                ]
                                signal        = "metrics"
                              }
                            }
                            type = "builder_query"
                          }
                        },
                        {
                          builder_formula = {
                            spec = {
                              disabled   = false
                              expression = "(B-A)/B"
                              having = {
                              }
                              legend = "{{k8s.node.name}}"
                              name   = "F1"
                            }
                            type = "builder_formula"
                          }
                        },
                      ]
                    }
                  }
                }
              }
            },
          ]
        }
      }
      "18c1653b-f826-460d-9302-90bc6d3f5e52" = {
        kind = "Panel"
        spec = {
          display = {
            name = "Node memory usage (WSS)"
          }
          links = [
          ]
          plugin = {
            time_series_panel = {
              kind = "signoz/TimeSeriesPanel"
              spec = {
                axes = {
                  is_log_scale = false
                  soft_max     = 0
                  soft_min     = 0
                }
                chart_appearance = {
                  fill_mode          = "none"
                  line_interpolation = "spline"
                  line_style         = "solid"
                  show_points        = false
                  span_gaps = {
                    fill_only_below = false
                  }
                }
                formatting = {
                  decimal_precision = "2"
                  unit              = "percentunit"
                }
                legend = {
                  mode     = "list"
                  position = "bottom"
                }
                visualization = {
                  fill_spans      = false
                  time_preference = "global_time"
                }
              }
            }
          }
          queries = [
            {
              kind = "time_series"
              spec = {
                plugin = {
                  composite_query = {
                    kind = "signoz/CompositeQuery"
                    spec = {
                      queries = [
                        {
                          builder_query = {
                            spec = {
                              metrics = {
                                aggregations = [
                                  {
                                    metric_name       = "k8s.node.memory.working_set"
                                    reduce_to         = "sum"
                                    space_aggregation = "sum"
                                    time_aggregation  = "avg"
                                  },
                                ]
                                disabled = true
                                filter = {
                                  expression = "(k8s.cluster.name IN $k8s.cluster.name  AND k8s.node.name IN $k8s.node.name)"
                                }
                                functions = [
                                ]
                                group_by = [
                                  {
                                    field_context   = "attribute"
                                    field_data_type = "string"
                                    name            = "k8s.node.name"
                                  },
                                ]
                                having = {
                                }
                                name = "A"
                                order = [
                                ]
                                signal        = "metrics"
                              }
                            }
                            type = "builder_query"
                          }
                        },
                        {
                          builder_query = {
                            spec = {
                              metrics = {
                                aggregations = [
                                  {
                                    metric_name       = "k8s.node.allocatable_memory"
                                    reduce_to         = "sum"
                                    space_aggregation = "sum"
                                    time_aggregation  = "avg"
                                  },
                                ]
                                disabled = true
                                filter = {
                                  expression = "(k8s.cluster.name IN $k8s.cluster.name  AND k8s.node.name IN $k8s.node.name)"
                                }
                                functions = [
                                ]
                                group_by = [
                                  {
                                    field_context   = "attribute"
                                    field_data_type = "string"
                                    name            = "k8s.node.name"
                                  },
                                ]
                                having = {
                                }
                                name = "B"
                                order = [
                                ]
                                signal        = "metrics"
                              }
                            }
                            type = "builder_query"
                          }
                        },
                        {
                          builder_formula = {
                            spec = {
                              disabled   = false
                              expression = "A/B"
                              having = {
                              }
                              legend = "{{k8s.node.name}}"
                              name   = "F1"
                            }
                            type = "builder_formula"
                          }
                        },
                      ]
                    }
                  }
                }
              }
            },
          ]
        }
      }
      a2cd4e4a-0b81-4a85-937f-48ca5c9f183b = {
        kind = "Panel"
        spec = {
          display = {
            name = "Node network IO"
          }
          links = [
          ]
          plugin = {
            time_series_panel = {
              kind = "signoz/TimeSeriesPanel"
              spec = {
                axes = {
                  is_log_scale = false
                  soft_max     = 0
                  soft_min     = 0
                }
                chart_appearance = {
                  fill_mode          = "none"
                  line_interpolation = "spline"
                  line_style         = "solid"
                  show_points        = false
                  span_gaps = {
                    fill_only_below = false
                  }
                }
                formatting = {
                  decimal_precision = "2"
                  unit              = "bytes"
                }
                legend = {
                  mode     = "list"
                  position = "bottom"
                }
                visualization = {
                  fill_spans      = false
                  time_preference = "global_time"
                }
              }
            }
          }
          queries = [
            {
              kind = "time_series"
              spec = {
                name = "A"
                plugin = {
                  builder_query = {
                    kind = "signoz/BuilderQuery"
                    spec = {
                      metrics = {
                        aggregations = [
                          {
                            metric_name       = "k8s.node.network.io"
                            reduce_to         = "sum"
                            space_aggregation = "sum"
                            time_aggregation  = "rate"
                          },
                        ]
                        disabled = false
                        filter = {
                          expression = "(k8s.cluster.name IN $k8s.cluster.name  AND k8s.node.name IN $k8s.node.name)"
                        }
                        functions = [
                        ]
                        group_by = [
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "interface"
                          },
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "direction"
                          },
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "k8s.node.name"
                          },
                        ]
                        having = {
                        }
                        legend = "{{k8s.node.name}}-{{interface}}-{{direction}}"
                        name   = "A"
                        order = [
                        ]
                        signal        = "metrics"
                      }
                    }
                  }
                }
              }
            },
          ]
        }
      }
      e16d581d-1da9-49ff-9c3b-1bb51c2f7730 = {
        kind = "Panel"
        spec = {
          display = {
            name = "Node CPU usage"
          }
          links = [
          ]
          plugin = {
            time_series_panel = {
              kind = "signoz/TimeSeriesPanel"
              spec = {
                axes = {
                  is_log_scale = false
                  soft_max     = 0
                  soft_min     = 0
                }
                chart_appearance = {
                  fill_mode          = "none"
                  line_interpolation = "spline"
                  line_style         = "solid"
                  show_points        = false
                  span_gaps = {
                    fill_only_below = false
                  }
                }
                formatting = {
                  decimal_precision = "2"
                  unit              = "percentunit"
                }
                legend = {
                  mode     = "list"
                  position = "bottom"
                }
                visualization = {
                  fill_spans      = false
                  time_preference = "global_time"
                }
              }
            }
          }
          queries = [
            {
              kind = "time_series"
              spec = {
                plugin = {
                  composite_query = {
                    kind = "signoz/CompositeQuery"
                    spec = {
                      queries = [
                        {
                          builder_query = {
                            spec = {
                              metrics = {
                                aggregations = [
                                  {
                                    metric_name       = "k8s.node.cpu.time"
                                    reduce_to         = "sum"
                                    space_aggregation = "sum"
                                    time_aggregation  = "rate"
                                  },
                                ]
                                disabled = true
                                filter = {
                                  expression = "(k8s.cluster.name IN $k8s.cluster.name  AND k8s.node.name IN $k8s.node.name)"
                                }
                                functions = [
                                ]
                                group_by = [
                                  {
                                    field_context   = "attribute"
                                    field_data_type = "string"
                                    name            = "k8s.node.name"
                                  },
                                ]
                                having = {
                                }
                                legend = "{{k8s.node.name}}"
                                name   = "A"
                                order = [
                                ]
                                signal        = "metrics"
                              }
                            }
                            type = "builder_query"
                          }
                        },
                        {
                          builder_query = {
                            spec = {
                              metrics = {
                                aggregations = [
                                  {
                                    metric_name       = "k8s.node.allocatable_cpu"
                                    reduce_to         = "sum"
                                    space_aggregation = "sum"
                                    time_aggregation  = "avg"
                                  },
                                ]
                                disabled = true
                                filter = {
                                  expression = "(k8s.cluster.name IN $k8s.cluster.name  AND k8s.node.name IN $k8s.node.name)"
                                }
                                functions = [
                                ]
                                group_by = [
                                  {
                                    field_context   = "attribute"
                                    field_data_type = "string"
                                    name            = "k8s.node.name"
                                  },
                                ]
                                having = {
                                }
                                legend = "{{k8s.node.name}}"
                                name   = "B"
                                order = [
                                ]
                                signal        = "metrics"
                              }
                            }
                            type = "builder_query"
                          }
                        },
                        {
                          builder_formula = {
                            spec = {
                              disabled   = false
                              expression = "A/B"
                              having = {
                              }
                              legend = "{{k8s.node.name}}"
                              name   = "F1"
                            }
                            type = "builder_formula"
                          }
                        },
                      ]
                    }
                  }
                }
              }
            },
          ]
        }
      }
    }
    variables = [
      {
        list_variable = {
          kind = "ListVariable"
          spec = {
            allow_all_value = false
            allow_multiple  = false
            display = {
              description = "The k8s.cluster.name"
              name        = "k8s.cluster.name"
            }
            name = "k8s.cluster.name"
            plugin = {
              dynamic_variable = {
                kind = "signoz/DynamicVariable"
                spec = {
                  name   = "k8s.cluster.name"
                  signal = "all"
                }
              }
            }
            sort = "none"
          }
        }
      },
      {
        list_variable = {
          kind = "ListVariable"
          spec = {
            allow_all_value = true
            allow_multiple  = true
            display = {
              description = "The k8s node name"
              name        = "k8s.node.name"
            }
            name = "k8s.node.name"
            plugin = {
              dynamic_variable = {
                kind = "signoz/DynamicVariable"
                spec = {
                  name   = "k8s.node.name"
                  signal = "all"
                }
              }
            }
            sort = "none"
          }
        }
      },
    ]
  }
  tags = [
    {
      key   = "tag"
      value = "node"
    },
    {
      key   = "tag"
      value = "k8s"
    },
    {
      key   = "tag"
      value = "kubelet"
    },
  ]
}

resource "signoz_dashboard" "k8s_pvc_metrics" {
  name           = "kubernetes-pvc-metrics-zjmvtmaa"
  schema_version = "v6"
  spec = {
    display = {
      name = "Kubernetes PVC Metrics"
    }
    layouts = [
      {
        grid = {
          kind = "Grid"
          spec = {
            items = [
              {
                content = {
                  ref = "#/spec/panels/94774ddd-6c72-4988-a7ed-07af51fab210"
                }
                height = 6
                width  = 6
                x      = 0
                y      = 0
              },
              {
                content = {
                  ref = "#/spec/panels/0ad5f32a-a508-4207-879a-73a5239be68a"
                }
                height = 6
                width  = 6
                x      = 6
                y      = 0
              },
              {
                content = {
                  ref = "#/spec/panels/378ee8aa-898c-4de2-b710-ff747ce1614b"
                }
                height = 6
                width  = 6
                x      = 0
                y      = 6
              },
              {
                content = {
                  ref = "#/spec/panels/3ddd26f4-886a-4e89-97a0-04e330e8647d"
                }
                height = 6
                width  = 6
                x      = 6
                y      = 6
              },
              {
                content = {
                  ref = "#/spec/panels/b1a1b62d-bbaa-4c49-a240-20e6f3a5c59d"
                }
                height = 6
                width  = 6
                x      = 0
                y      = 12
              },
              {
                content = {
                  ref = "#/spec/panels/8a17665f-d533-4591-a2e8-9ea5ada56f78"
                }
                height = 6
                width  = 6
                x      = 6
                y      = 12
              },
            ]
          }
        }
      },
    ]
    links = [
    ]
    panels = {
      "0ad5f32a-a508-4207-879a-73a5239be68a" = {
        kind = "Panel"
        spec = {
          display = {
            name = "Volume Usage"
          }
          links = [
          ]
          plugin = {
            time_series_panel = {
              kind = "signoz/TimeSeriesPanel"
              spec = {
                axes = {
                  is_log_scale = false
                  soft_max     = 0
                  soft_min     = 0
                }
                chart_appearance = {
                  fill_mode          = "none"
                  line_interpolation = "spline"
                  line_style         = "solid"
                  show_points        = false
                  span_gaps = {
                    fill_only_below = false
                  }
                }
                formatting = {
                  decimal_precision = "2"
                  unit              = "%"
                }
                legend = {
                  mode     = "list"
                  position = "bottom"
                }
                visualization = {
                  fill_spans      = false
                  time_preference = "global_time"
                }
              }
            }
          }
          queries = [
            {
              kind = "time_series"
              spec = {
                plugin = {
                  composite_query = {
                    kind = "signoz/CompositeQuery"
                    spec = {
                      queries = [
                        {
                          builder_query = {
                            spec = {
                              metrics = {
                                aggregations = [
                                  {
                                    metric_name       = "k8s.volume.capacity"
                                    reduce_to         = "sum"
                                    space_aggregation = "sum"
                                    time_aggregation  = "avg"
                                  },
                                ]
                                disabled = true
                                filter = {
                                  expression = "(k8s.cluster.name in $k8s.cluster.name AND k8s.node.name IN $k8s.node.name AND k8s.namespace.name IN $k8s.namespace.name AND k8s.volume.type = 'persistentVolumeClaim') "
                                }
                                functions = [
                                ]
                                group_by = [
                                  {
                                    field_context   = "attribute"
                                    field_data_type = "string"
                                    name            = "k8s.namespace.name"
                                  },
                                  {
                                    field_context   = "attribute"
                                    field_data_type = "string"
                                    name            = "k8s.pod.name"
                                  },
                                  {
                                    field_context   = "attribute"
                                    field_data_type = "string"
                                    name            = "k8s.volume.name"
                                  },
                                ]
                                having = {
                                }
                                legend = "{{k8s.namespace.name}}-{{k8s.pod.name}}-{{k8s.volume.name}}"
                                name   = "A"
                                order = [
                                ]
                                signal        = "metrics"
                              }
                            }
                            type = "builder_query"
                          }
                        },
                        {
                          builder_query = {
                            spec = {
                              metrics = {
                                aggregations = [
                                  {
                                    metric_name       = "k8s.volume.available"
                                    reduce_to         = "sum"
                                    space_aggregation = "sum"
                                    time_aggregation  = "avg"
                                  },
                                ]
                                disabled = true
                                filter = {
                                  expression = "(k8s.cluster.name in $k8s.cluster.name AND k8s.node.name IN $k8s.node.name AND k8s.namespace.name IN $k8s.namespace.name AND k8s.volume.type = 'persistentVolumeClaim') "
                                }
                                functions = [
                                ]
                                group_by = [
                                  {
                                    field_context   = "attribute"
                                    field_data_type = "string"
                                    name            = "k8s.namespace.name"
                                  },
                                  {
                                    field_context   = "attribute"
                                    field_data_type = "string"
                                    name            = "k8s.pod.name"
                                  },
                                  {
                                    field_context   = "attribute"
                                    field_data_type = "string"
                                    name            = "k8s.volume.name"
                                  },
                                ]
                                having = {
                                }
                                legend = "{{k8s.namespace.name}}-{{k8s.pod.name}}-{{k8s.volume.name}}"
                                name   = "B"
                                order = [
                                ]
                                signal        = "metrics"
                              }
                            }
                            type = "builder_query"
                          }
                        },
                        {
                          builder_formula = {
                            spec = {
                              disabled   = false
                              expression = "(1 - B/A) * 100"
                              having = {
                              }
                              legend = "{{k8s.namespace.name}}-{{k8s.pod.name}}-{{k8s.volume.name}}"
                              name   = "F1"
                            }
                            type = "builder_formula"
                          }
                        },
                      ]
                    }
                  }
                }
              }
            },
          ]
        }
      }
      "378ee8aa-898c-4de2-b710-ff747ce1614b" = {
        kind = "Panel"
        spec = {
          display = {
            name = "Volume capacity"
          }
          links = [
          ]
          plugin = {
            time_series_panel = {
              kind = "signoz/TimeSeriesPanel"
              spec = {
                axes = {
                  is_log_scale = false
                  soft_max     = 0
                  soft_min     = 0
                }
                chart_appearance = {
                  fill_mode          = "none"
                  line_interpolation = "spline"
                  line_style         = "solid"
                  show_points        = false
                  span_gaps = {
                    fill_only_below = false
                  }
                }
                formatting = {
                  decimal_precision = "2"
                  unit              = "bytes"
                }
                legend = {
                  mode     = "list"
                  position = "bottom"
                }
                visualization = {
                  fill_spans      = false
                  time_preference = "global_time"
                }
              }
            }
          }
          queries = [
            {
              kind = "time_series"
              spec = {
                name = "A"
                plugin = {
                  builder_query = {
                    kind = "signoz/BuilderQuery"
                    spec = {
                      metrics = {
                        aggregations = [
                          {
                            metric_name       = "k8s.volume.capacity"
                            reduce_to         = "sum"
                            space_aggregation = "sum"
                            time_aggregation  = "avg"
                          },
                        ]
                        disabled = false
                        filter = {
                          expression = "(k8s.cluster.name in $k8s.cluster.name AND k8s.node.name IN $k8s.node.name AND k8s.namespace.name IN $k8s.namespace.name AND k8s.volume.type = 'persistentVolumeClaim') "
                        }
                        functions = [
                        ]
                        group_by = [
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "k8s.namespace.name"
                          },
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "k8s.pod.name"
                          },
                        ]
                        having = {
                        }
                        legend = "{{k8s.namespace.name}}-{{k8s.pod.name}}"
                        name   = "A"
                        order = [
                        ]
                        signal        = "metrics"
                      }
                    }
                  }
                }
              }
            },
          ]
        }
      }
      "3ddd26f4-886a-4e89-97a0-04e330e8647d" = {
        kind = "Panel"
        spec = {
          display = {
            name = "Volume inodes"
          }
          links = [
          ]
          plugin = {
            time_series_panel = {
              kind = "signoz/TimeSeriesPanel"
              spec = {
                axes = {
                  is_log_scale = false
                  soft_max     = 0
                  soft_min     = 0
                }
                chart_appearance = {
                  fill_mode          = "none"
                  line_interpolation = "spline"
                  line_style         = "solid"
                  show_points        = false
                  span_gaps = {
                    fill_only_below = false
                  }
                }
                formatting = {
                  decimal_precision = "2"
                  unit              = "short"
                }
                legend = {
                  mode     = "list"
                  position = "bottom"
                }
                visualization = {
                  fill_spans      = false
                  time_preference = "global_time"
                }
              }
            }
          }
          queries = [
            {
              kind = "time_series"
              spec = {
                name = "A"
                plugin = {
                  builder_query = {
                    kind = "signoz/BuilderQuery"
                    spec = {
                      metrics = {
                        aggregations = [
                          {
                            metric_name       = "k8s.volume.inodes"
                            reduce_to         = "sum"
                            space_aggregation = "sum"
                            time_aggregation  = "avg"
                          },
                        ]
                        disabled = false
                        filter = {
                          expression = "(k8s.cluster.name in $k8s.cluster.name AND k8s.node.name IN $k8s.node.name AND k8s.namespace.name IN $k8s.namespace.name AND k8s.volume.type = 'persistentVolumeClaim')"
                        }
                        functions = [
                        ]
                        group_by = [
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "k8s.namespace.name"
                          },
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "k8s.pod.name"
                          },
                        ]
                        having = {
                        }
                        legend = "{{k8s.namespace.name}}-{{k8s.pod.name}}"
                        name   = "A"
                        order = [
                        ]
                        signal        = "metrics"
                      }
                    }
                  }
                }
              }
            },
          ]
        }
      }
      "8a17665f-d533-4591-a2e8-9ea5ada56f78" = {
        kind = "Panel"
        spec = {
          display = {
            name = "Volume inodes free"
          }
          links = [
          ]
          plugin = {
            time_series_panel = {
              kind = "signoz/TimeSeriesPanel"
              spec = {
                axes = {
                  is_log_scale = false
                  soft_max     = 0
                  soft_min     = 0
                }
                chart_appearance = {
                  fill_mode          = "none"
                  line_interpolation = "spline"
                  line_style         = "solid"
                  show_points        = false
                  span_gaps = {
                    fill_only_below = false
                  }
                }
                formatting = {
                  decimal_precision = "2"
                  unit              = "short"
                }
                legend = {
                  mode     = "list"
                  position = "bottom"
                }
                visualization = {
                  fill_spans      = false
                  time_preference = "global_time"
                }
              }
            }
          }
          queries = [
            {
              kind = "time_series"
              spec = {
                name = "A"
                plugin = {
                  builder_query = {
                    kind = "signoz/BuilderQuery"
                    spec = {
                      metrics = {
                        aggregations = [
                          {
                            metric_name       = "k8s.volume.inodes.free"
                            reduce_to         = "sum"
                            space_aggregation = "sum"
                            time_aggregation  = "avg"
                          },
                        ]
                        disabled = false
                        filter = {
                          expression = "(k8s.cluster.name in $k8s.cluster.name AND k8s.node.name IN $k8s.node.name AND k8s.namespace.name IN $k8s.namespace.name AND k8s.volume.type = 'persistentVolumeClaim')"
                        }
                        functions = [
                        ]
                        group_by = [
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "k8s.namespace.name"
                          },
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "k8s.pod.name"
                          },
                        ]
                        having = {
                        }
                        legend = "{{k8s.namespace.name}}-{{k8s.pod.name}}"
                        name   = "A"
                        order = [
                        ]
                        signal        = "metrics"
                      }
                    }
                  }
                }
              }
            },
          ]
        }
      }
      "94774ddd-6c72-4988-a7ed-07af51fab210" = {
        kind = "Panel"
        spec = {
          display = {
            name = "Volume available"
          }
          links = [
          ]
          plugin = {
            time_series_panel = {
              kind = "signoz/TimeSeriesPanel"
              spec = {
                axes = {
                  is_log_scale = false
                  soft_max     = 0
                  soft_min     = 0
                }
                chart_appearance = {
                  fill_mode          = "none"
                  line_interpolation = "spline"
                  line_style         = "solid"
                  show_points        = false
                  span_gaps = {
                    fill_only_below = false
                  }
                }
                formatting = {
                  decimal_precision = "2"
                  unit              = "bytes"
                }
                legend = {
                  mode     = "list"
                  position = "bottom"
                }
                visualization = {
                  fill_spans      = false
                  time_preference = "global_time"
                }
              }
            }
          }
          queries = [
            {
              kind = "time_series"
              spec = {
                name = "A"
                plugin = {
                  builder_query = {
                    kind = "signoz/BuilderQuery"
                    spec = {
                      metrics = {
                        aggregations = [
                          {
                            metric_name       = "k8s.volume.available"
                            reduce_to         = "sum"
                            space_aggregation = "sum"
                            time_aggregation  = "avg"
                          },
                        ]
                        disabled = false
                        filter = {
                          expression = "(k8s.cluster.name in $k8s.cluster.name AND k8s.node.name IN $k8s.node.name AND k8s.namespace.name IN $k8s.namespace.name AND k8s.volume.type = 'persistentVolumeClaim') "
                        }
                        functions = [
                        ]
                        group_by = [
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "k8s.namespace.name"
                          },
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "k8s.pod.name"
                          },
                        ]
                        having = {
                        }
                        legend = "{{k8s.namespace.name}}-{{k8s.pod.name}}"
                        name   = "A"
                        order = [
                        ]
                        signal        = "metrics"
                      }
                    }
                  }
                }
              }
            },
          ]
        }
      }
      b1a1b62d-bbaa-4c49-a240-20e6f3a5c59d = {
        kind = "Panel"
        spec = {
          display = {
            name = "Volume inodes used"
          }
          links = [
          ]
          plugin = {
            time_series_panel = {
              kind = "signoz/TimeSeriesPanel"
              spec = {
                axes = {
                  is_log_scale = false
                  soft_max     = 0
                  soft_min     = 0
                }
                chart_appearance = {
                  fill_mode          = "none"
                  line_interpolation = "spline"
                  line_style         = "solid"
                  show_points        = false
                  span_gaps = {
                    fill_only_below = false
                  }
                }
                formatting = {
                  decimal_precision = "2"
                  unit              = "short"
                }
                legend = {
                  mode     = "list"
                  position = "bottom"
                }
                visualization = {
                  fill_spans      = false
                  time_preference = "global_time"
                }
              }
            }
          }
          queries = [
            {
              kind = "time_series"
              spec = {
                name = "A"
                plugin = {
                  builder_query = {
                    kind = "signoz/BuilderQuery"
                    spec = {
                      metrics = {
                        aggregations = [
                          {
                            metric_name       = "k8s.volume.inodes.used"
                            reduce_to         = "sum"
                            space_aggregation = "sum"
                            time_aggregation  = "avg"
                          },
                        ]
                        disabled = false
                        filter = {
                          expression = "(k8s.cluster.name in $k8s.cluster.name AND k8s.node.name IN $k8s.node.name AND k8s.namespace.name IN $k8s.namespace.name AND k8s.volume.type = 'persistentVolumeClaim')"
                        }
                        functions = [
                        ]
                        group_by = [
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "k8s.namespace.name"
                          },
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "k8s.pod.name"
                          },
                        ]
                        having = {
                        }
                        legend = "{{k8s.namespace.name}}-{{k8s.pod.name}}"
                        name   = "A"
                        order = [
                        ]
                        signal        = "metrics"
                      }
                    }
                  }
                }
              }
            },
          ]
        }
      }
    }
    variables = [
      {
        list_variable = {
          kind = "ListVariable"
          spec = {
            allow_all_value = false
            allow_multiple  = false
            display = {
              description = "The k8s cluster name"
              name        = "k8s.cluster.name"
            }
            name = "k8s.cluster.name"
            plugin = {
              dynamic_variable = {
                kind = "signoz/DynamicVariable"
                spec = {
                  name   = "k8s.cluster.name"
                  signal = "all"
                }
              }
            }
            sort = "none"
          }
        }
      },
      {
        list_variable = {
          kind = "ListVariable"
          spec = {
            allow_all_value = true
            allow_multiple  = true
            display = {
              description = "The k8s node name."
              name        = "k8s.node.name"
            }
            name = "k8s.node.name"
            plugin = {
              dynamic_variable = {
                kind = "signoz/DynamicVariable"
                spec = {
                  name   = "k8s.node.name"
                  signal = "all"
                }
              }
            }
            sort = "alphabetical-asc"
          }
        }
      },
      {
        list_variable = {
          kind = "ListVariable"
          spec = {
            allow_all_value = true
            allow_multiple  = true
            display = {
              description = "The k8s namespace name"
              name        = "k8s.namespace.name"
            }
            name = "k8s.namespace.name"
            plugin = {
              dynamic_variable = {
                kind = "signoz/DynamicVariable"
                spec = {
                  name   = "k8s.namespace.name"
                  signal = "all"
                }
              }
            }
            sort = "none"
          }
        }
      },
    ]
  }
  tags = [
    {
      key   = "tag"
      value = "pvc"
    },
    {
      key   = "tag"
      value = "pod"
    },
    {
      key   = "tag"
      value = "volume"
    },
    {
      key   = "tag"
      value = "k8s"
    },
  ]
}

resource "signoz_dashboard" "k8s_pod_metrics_detailed" {
  name           = "kubernetes-pod-metrics-detailed-balv3oyu"
  schema_version = "v6"
  spec = {
    display = {
      name = "Kubernetes Pod Metrics - Detailed"
    }
    layouts = [
      {
        grid = {
          kind = "Grid"
          spec = {
            items = [
              {
                content = {
                  ref = "#/spec/panels/c5f29b09-8a63-44ba-825f-db91a3c79a54"
                }
                height = 7
                width  = 12
                x      = 0
                y      = 0
              },
              {
                content = {
                  ref = "#/spec/panels/9d0f96dc-d744-4baa-9910-ac1aef63cc34"
                }
                height = 6
                width  = 6
                x      = 0
                y      = 7
              },
              {
                content = {
                  ref = "#/spec/panels/960ff49f-d73b-49c2-ab4a-69df1e1abc51"
                }
                height = 6
                width  = 6
                x      = 6
                y      = 7
              },
              {
                content = {
                  ref = "#/spec/panels/2e864710-b418-4133-b248-2fa047e37fe3"
                }
                height = 6
                width  = 6
                x      = 0
                y      = 13
              },
              {
                content = {
                  ref = "#/spec/panels/75fdac11-19dd-472f-a155-63e4682b88df"
                }
                height = 6
                width  = 6
                x      = 6
                y      = 13
              },
              {
                content = {
                  ref = "#/spec/panels/8722151e-7690-4152-98c3-f2cc0f741d50"
                }
                height = 6
                width  = 6
                x      = 0
                y      = 19
              },
              {
                content = {
                  ref = "#/spec/panels/1f8965fb-5ad1-4679-9d28-9bd31d4e4cac"
                }
                height = 6
                width  = 6
                x      = 6
                y      = 19
              },
              {
                content = {
                  ref = "#/spec/panels/7403ba8f-36bf-4c31-8b91-a447a36eeca0"
                }
                height = 6
                width  = 6
                x      = 0
                y      = 25
              },
              {
                content = {
                  ref = "#/spec/panels/230f3562-5ac1-4fec-946d-0dd21057f4b3"
                }
                height = 6
                width  = 6
                x      = 6
                y      = 25
              },
            ]
          }
        }
      },
    ]
    links = [
    ]
    panels = {
      "1f8965fb-5ad1-4679-9d28-9bd31d4e4cac" = {
        kind = "Panel"
        spec = {
          display = {
            name = "Pod network errors"
          }
          links = [
          ]
          plugin = {
            time_series_panel = {
              kind = "signoz/TimeSeriesPanel"
              spec = {
                axes = {
                  is_log_scale = false
                  soft_max     = 0
                  soft_min     = 0
                }
                chart_appearance = {
                  fill_mode          = "none"
                  line_interpolation = "spline"
                  line_style         = "solid"
                  show_points        = false
                  span_gaps = {
                    fill_only_below = false
                  }
                }
                formatting = {
                  decimal_precision = "2"
                  unit              = "none"
                }
                legend = {
                  mode     = "list"
                  position = "bottom"
                }
                visualization = {
                  fill_spans      = false
                  time_preference = "global_time"
                }
              }
            }
          }
          queries = [
            {
              kind = "time_series"
              spec = {
                name = "A"
                plugin = {
                  builder_query = {
                    kind = "signoz/BuilderQuery"
                    spec = {
                      metrics = {
                        aggregations = [
                          {
                            metric_name       = "k8s.pod.network.errors"
                            reduce_to         = "sum"
                            space_aggregation = "sum"
                            time_aggregation  = "rate"
                          },
                        ]
                        disabled = false
                        filter = {
                          expression = "(k8s.cluster.name in $k8s.cluster.name  AND k8s.node.name IN $k8s.node.name AND k8s.namespace.name IN $k8s.namespace.name)"
                        }
                        functions = [
                        ]
                        group_by = [
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "k8s.node.name"
                          },
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "interface"
                          },
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "direction"
                          },
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "k8s.namespace.name"
                          },
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "k8s.pod.name"
                          },
                        ]
                        having = {
                        }
                        legend = "{{k8s.namespace.name}}-{{k8s.pod.name}}-{{interface}}-{{direction}}"
                        name   = "A"
                        order = [
                        ]
                        signal        = "metrics"
                      }
                    }
                  }
                }
              }
            },
          ]
        }
      }
      "230f3562-5ac1-4fec-946d-0dd21057f4b3" = {
        kind = "Panel"
        spec = {
          display = {
            name = "Pod filesystem available"
          }
          links = [
          ]
          plugin = {
            time_series_panel = {
              kind = "signoz/TimeSeriesPanel"
              spec = {
                axes = {
                  is_log_scale = false
                  soft_max     = 0
                  soft_min     = 0
                }
                chart_appearance = {
                  fill_mode          = "none"
                  line_interpolation = "spline"
                  line_style         = "solid"
                  show_points        = false
                  span_gaps = {
                    fill_only_below = false
                  }
                }
                formatting = {
                  decimal_precision = "2"
                  unit              = "bytes"
                }
                legend = {
                  mode     = "list"
                  position = "bottom"
                }
                visualization = {
                  fill_spans      = false
                  time_preference = "global_time"
                }
              }
            }
          }
          queries = [
            {
              kind = "time_series"
              spec = {
                name = "A"
                plugin = {
                  builder_query = {
                    kind = "signoz/BuilderQuery"
                    spec = {
                      metrics = {
                        aggregations = [
                          {
                            metric_name       = "k8s.pod.filesystem.available"
                            reduce_to         = "sum"
                            space_aggregation = "sum"
                            time_aggregation  = "avg"
                          },
                        ]
                        disabled = false
                        filter = {
                          expression = "(k8s.cluster.name in $k8s.cluster.name  AND k8s.node.name IN $k8s.node.name AND k8s.namespace.name IN $k8s.namespace.name)"
                        }
                        functions = [
                        ]
                        group_by = [
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "k8s.node.name"
                          },
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "k8s.namespace.name"
                          },
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "k8s.pod.name"
                          },
                        ]
                        having = {
                        }
                        legend = "{{k8s.node.name}}-{{k8s.namespace.name}}-{{k8s.pod.name}}"
                        name   = "A"
                        order = [
                        ]
                        signal        = "metrics"
                      }
                    }
                  }
                }
              }
            },
          ]
        }
      }
      "2e864710-b418-4133-b248-2fa047e37fe3" = {
        kind = "Panel"
        spec = {
          display = {
            name = "Pod network io"
          }
          links = [
          ]
          plugin = {
            time_series_panel = {
              kind = "signoz/TimeSeriesPanel"
              spec = {
                axes = {
                  is_log_scale = false
                  soft_max     = 0
                  soft_min     = 0
                }
                chart_appearance = {
                  fill_mode          = "none"
                  line_interpolation = "spline"
                  line_style         = "solid"
                  show_points        = false
                  span_gaps = {
                    fill_only_below = false
                  }
                }
                formatting = {
                  decimal_precision = "2"
                  unit              = "bytes"
                }
                legend = {
                  mode     = "list"
                  position = "bottom"
                }
                visualization = {
                  fill_spans      = false
                  time_preference = "global_time"
                }
              }
            }
          }
          queries = [
            {
              kind = "time_series"
              spec = {
                name = "A"
                plugin = {
                  builder_query = {
                    kind = "signoz/BuilderQuery"
                    spec = {
                      metrics = {
                        aggregations = [
                          {
                            metric_name       = "k8s.pod.network.io"
                            reduce_to         = "sum"
                            space_aggregation = "sum"
                            time_aggregation  = "rate"
                          },
                        ]
                        disabled = false
                        filter = {
                          expression = "(k8s.cluster.name in $k8s.cluster.name  AND k8s.node.name IN $k8s.node.name AND k8s.namespace.name IN $k8s.namespace.name)"
                        }
                        functions = [
                        ]
                        group_by = [
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "direction"
                          },
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "interface"
                          },
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "k8s.node.name"
                          },
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "k8s.namespace.name"
                          },
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "k8s.pod.name"
                          },
                        ]
                        having = {
                        }
                        legend = "{{k8s.namespace.name}}-{{k8s.pod.name}}-{{interface}}-{{direction}}"
                        name   = "A"
                        order = [
                        ]
                        signal        = "metrics"
                      }
                    }
                  }
                }
              }
            },
          ]
        }
      }
      "7403ba8f-36bf-4c31-8b91-a447a36eeca0" = {
        kind = "Panel"
        spec = {
          display = {
            name = "Pod filesystem capacity"
          }
          links = [
          ]
          plugin = {
            time_series_panel = {
              kind = "signoz/TimeSeriesPanel"
              spec = {
                axes = {
                  is_log_scale = false
                  soft_max     = 0
                  soft_min     = 0
                }
                chart_appearance = {
                  fill_mode          = "none"
                  line_interpolation = "spline"
                  line_style         = "solid"
                  show_points        = false
                  span_gaps = {
                    fill_only_below = false
                  }
                }
                formatting = {
                  decimal_precision = "2"
                  unit              = "bytes"
                }
                legend = {
                  mode     = "list"
                  position = "bottom"
                }
                visualization = {
                  fill_spans      = false
                  time_preference = "global_time"
                }
              }
            }
          }
          queries = [
            {
              kind = "time_series"
              spec = {
                name = "A"
                plugin = {
                  builder_query = {
                    kind = "signoz/BuilderQuery"
                    spec = {
                      metrics = {
                        aggregations = [
                          {
                            metric_name       = "k8s.pod.filesystem.capacity"
                            reduce_to         = "sum"
                            space_aggregation = "sum"
                            time_aggregation  = "avg"
                          },
                        ]
                        disabled = false
                        filter = {
                          expression = "(k8s.cluster.name IN $k8s.cluster.name  AND k8s.node.name IN $k8s.node.name AND k8s.namespace.name IN $k8s.namespace.name)"
                        }
                        functions = [
                        ]
                        group_by = [
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "k8s.node.name"
                          },
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "k8s.namespace.name"
                          },
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "k8s.pod.name"
                          },
                        ]
                        having = {
                        }
                        legend = "{{k8s.namespace.name}}-{{k8s.pod.name}}"
                        name   = "A"
                        order = [
                        ]
                        signal        = "metrics"
                      }
                    }
                  }
                }
              }
            },
          ]
        }
      }
      "75fdac11-19dd-472f-a155-63e4682b88df" = {
        kind = "Panel"
        spec = {
          display = {
            name = "Pod memory usage"
          }
          links = [
          ]
          plugin = {
            time_series_panel = {
              kind = "signoz/TimeSeriesPanel"
              spec = {
                axes = {
                  is_log_scale = false
                  soft_max     = 0
                  soft_min     = 0
                }
                chart_appearance = {
                  fill_mode          = "none"
                  line_interpolation = "spline"
                  line_style         = "solid"
                  show_points        = false
                  span_gaps = {
                    fill_only_below = false
                  }
                }
                formatting = {
                  decimal_precision = "2"
                  unit              = "bytes"
                }
                legend = {
                  mode     = "list"
                  position = "bottom"
                }
                visualization = {
                  fill_spans      = false
                  time_preference = "global_time"
                }
              }
            }
          }
          queries = [
            {
              kind = "time_series"
              spec = {
                name = "A"
                plugin = {
                  builder_query = {
                    kind = "signoz/BuilderQuery"
                    spec = {
                      metrics = {
                        aggregations = [
                          {
                            metric_name       = "k8s.pod.memory.usage"
                            reduce_to         = "sum"
                            space_aggregation = "sum"
                            time_aggregation  = "avg"
                          },
                        ]
                        disabled = false
                        filter = {
                          expression = "(k8s.cluster.name in $k8s.cluster.name  AND k8s.node.name IN $k8s.node.name AND k8s.namespace.name IN $k8s.namespace.name)"
                        }
                        functions = [
                        ]
                        group_by = [
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "k8s.node.name"
                          },
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "k8s.namespace.name"
                          },
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "k8s.pod.name"
                          },
                        ]
                        having = {
                        }
                        legend = "{{k8s.namespace.name}}-{{k8s.pod.name}}"
                        name   = "A"
                        order = [
                        ]
                        signal        = "metrics"
                      }
                    }
                  }
                }
              }
            },
          ]
        }
      }
      "8722151e-7690-4152-98c3-f2cc0f741d50" = {
        kind = "Panel"
        spec = {
          display = {
            name = "Pod filesystem usage"
          }
          links = [
          ]
          plugin = {
            time_series_panel = {
              kind = "signoz/TimeSeriesPanel"
              spec = {
                axes = {
                  is_log_scale = false
                  soft_max     = 0
                  soft_min     = 0
                }
                chart_appearance = {
                  fill_mode          = "none"
                  line_interpolation = "spline"
                  line_style         = "solid"
                  show_points        = false
                  span_gaps = {
                    fill_only_below = false
                  }
                }
                formatting = {
                  decimal_precision = "2"
                  unit              = "bytes"
                }
                legend = {
                  mode     = "list"
                  position = "bottom"
                }
                visualization = {
                  fill_spans      = false
                  time_preference = "global_time"
                }
              }
            }
          }
          queries = [
            {
              kind = "time_series"
              spec = {
                name = "A"
                plugin = {
                  builder_query = {
                    kind = "signoz/BuilderQuery"
                    spec = {
                      metrics = {
                        aggregations = [
                          {
                            metric_name       = "k8s.pod.filesystem.usage"
                            reduce_to         = "sum"
                            space_aggregation = "sum"
                            time_aggregation  = "avg"
                          },
                        ]
                        disabled = false
                        filter = {
                          expression = "(k8s.cluster.name in $k8s.cluster.name  AND k8s.node.name IN $k8s.node.name AND k8s.namespace.name IN $k8s.namespace.name)"
                        }
                        functions = [
                        ]
                        group_by = [
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "k8s.node.name"
                          },
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "k8s.namespace.name"
                          },
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "k8s.pod.name"
                          },
                        ]
                        having = {
                        }
                        legend = "{{k8s.node.name}}-{{k8s.namespace.name}}-{{k8s.pod.name}}"
                        name   = "A"
                        order = [
                        ]
                        signal        = "metrics"
                      }
                    }
                  }
                }
              }
            },
          ]
        }
      }
      "960ff49f-d73b-49c2-ab4a-69df1e1abc51" = {
        kind = "Panel"
        spec = {
          display = {
            name = "Pod memory working set"
          }
          links = [
          ]
          plugin = {
            time_series_panel = {
              kind = "signoz/TimeSeriesPanel"
              spec = {
                axes = {
                  is_log_scale = false
                  soft_max     = 0
                  soft_min     = 0
                }
                chart_appearance = {
                  fill_mode          = "none"
                  line_interpolation = "spline"
                  line_style         = "solid"
                  show_points        = false
                  span_gaps = {
                    fill_only_below = false
                  }
                }
                formatting = {
                  decimal_precision = "2"
                  unit              = "bytes"
                }
                legend = {
                  mode     = "list"
                  position = "bottom"
                }
                visualization = {
                  fill_spans      = false
                  time_preference = "global_time"
                }
              }
            }
          }
          queries = [
            {
              kind = "time_series"
              spec = {
                name = "A"
                plugin = {
                  builder_query = {
                    kind = "signoz/BuilderQuery"
                    spec = {
                      metrics = {
                        aggregations = [
                          {
                            metric_name       = "k8s.pod.memory.working_set"
                            reduce_to         = "sum"
                            space_aggregation = "sum"
                            time_aggregation  = "avg"
                          },
                        ]
                        disabled = false
                        filter = {
                          expression = "(k8s.cluster.name in $k8s.cluster.name  AND k8s.node.name IN $k8s.node.name AND k8s.namespace.name IN $k8s.namespace.name)"
                        }
                        functions = [
                        ]
                        group_by = [
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "k8s.node.name"
                          },
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "k8s.namespace.name"
                          },
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "k8s.pod.name"
                          },
                        ]
                        having = {
                        }
                        legend = "{{k8s.namespace.name}}-{{k8s.pod.name}}"
                        name   = "A"
                        order = [
                        ]
                        signal        = "metrics"
                      }
                    }
                  }
                }
              }
            },
          ]
        }
      }
      "9d0f96dc-d744-4baa-9910-ac1aef63cc34" = {
        kind = "Panel"
        spec = {
          display = {
            name = "Pod memory rss"
          }
          links = [
          ]
          plugin = {
            time_series_panel = {
              kind = "signoz/TimeSeriesPanel"
              spec = {
                axes = {
                  is_log_scale = false
                  soft_max     = 0
                  soft_min     = 0
                }
                chart_appearance = {
                  fill_mode          = "none"
                  line_interpolation = "spline"
                  line_style         = "solid"
                  show_points        = false
                  span_gaps = {
                    fill_only_below = false
                  }
                }
                formatting = {
                  decimal_precision = "2"
                  unit              = "bytes"
                }
                legend = {
                  mode     = "list"
                  position = "bottom"
                }
                visualization = {
                  fill_spans      = false
                  time_preference = "global_time"
                }
              }
            }
          }
          queries = [
            {
              kind = "time_series"
              spec = {
                name = "A"
                plugin = {
                  builder_query = {
                    kind = "signoz/BuilderQuery"
                    spec = {
                      metrics = {
                        aggregations = [
                          {
                            metric_name       = "k8s.pod.memory.rss"
                            reduce_to         = "sum"
                            space_aggregation = "sum"
                            time_aggregation  = "avg"
                          },
                        ]
                        disabled = false
                        filter = {
                          expression = "(k8s.cluster.name in $k8s.cluster.name  AND k8s.node.name IN $k8s.node.name AND k8s.namespace.name IN $k8s.namespace.name)"
                        }
                        functions = [
                        ]
                        group_by = [
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "k8s.node.name"
                          },
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "k8s.namespace.name"
                          },
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "k8s.pod.name"
                          },
                        ]
                        having = {
                        }
                        legend = "{{k8s.namespace.name}}-{{k8s.pod.name}}"
                        name   = "A"
                        order = [
                        ]
                        signal        = "metrics"
                      }
                    }
                  }
                }
              }
            },
          ]
        }
      }
      c5f29b09-8a63-44ba-825f-db91a3c79a54 = {
        kind = "Panel"
        spec = {
          display = {
            name = "Pod CPU usage"
          }
          links = [
          ]
          plugin = {
            time_series_panel = {
              kind = "signoz/TimeSeriesPanel"
              spec = {
                axes = {
                  is_log_scale = false
                  soft_max     = 0
                  soft_min     = 0
                }
                chart_appearance = {
                  fill_mode          = "none"
                  line_interpolation = "spline"
                  line_style         = "solid"
                  show_points        = false
                  span_gaps = {
                    fill_only_below = false
                  }
                }
                formatting = {
                  decimal_precision = "2"
                  unit              = "none"
                }
                legend = {
                  mode     = "list"
                  position = "bottom"
                }
                visualization = {
                  fill_spans      = false
                  time_preference = "global_time"
                }
              }
            }
          }
          queries = [
            {
              kind = "time_series"
              spec = {
                name = "A"
                plugin = {
                  builder_query = {
                    kind = "signoz/BuilderQuery"
                    spec = {
                      metrics = {
                        aggregations = [
                          {
                            metric_name       = "k8s.pod.cpu.usage"
                            reduce_to         = "avg"
                            space_aggregation = "avg"
                            time_aggregation  = "avg"
                          },
                        ]
                        disabled = false
                        filter = {
                          expression = "(k8s.cluster.name in $k8s.cluster.name  AND k8s.node.name IN $k8s.node.name AND k8s.namespace.name IN $k8s.namespace.name)"
                        }
                        functions = [
                        ]
                        group_by = [
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "k8s.node.name"
                          },
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "k8s.namespace.name"
                          },
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "k8s.pod.name"
                          },
                        ]
                        having = {
                        }
                        legend = "{{k8s.namespace.name}}-{{k8s.pod.name}}"
                        name   = "A"
                        order = [
                        ]
                        signal        = "metrics"
                      }
                    }
                  }
                }
              }
            },
          ]
        }
      }
    }
    variables = [
      {
        list_variable = {
          kind = "ListVariable"
          spec = {
            allow_all_value = false
            allow_multiple  = false
            display = {
              description = "Name of the cluster"
              name        = "k8s.cluster.name"
            }
            name = "k8s.cluster.name"
            plugin = {
              dynamic_variable = {
                kind = "signoz/DynamicVariable"
                spec = {
                  name   = "k8s.cluster.name"
                  signal = "all"
                }
              }
            }
            sort = "none"
          }
        }
      },
      {
        list_variable = {
          kind = "ListVariable"
          spec = {
            allow_all_value = true
            allow_multiple  = true
            display = {
              description = "The k8s node name."
              name        = "k8s.node.name"
            }
            name = "k8s.node.name"
            plugin = {
              dynamic_variable = {
                kind = "signoz/DynamicVariable"
                spec = {
                  name   = "k8s.node.name"
                  signal = "all"
                }
              }
            }
            sort = "alphabetical-asc"
          }
        }
      },
      {
        list_variable = {
          kind = "ListVariable"
          spec = {
            allow_all_value = true
            allow_multiple  = true
            display = {
              description = "The k8s namespace name."
              name        = "k8s.namespace.name"
            }
            name = "k8s.namespace.name"
            plugin = {
              dynamic_variable = {
                kind = "signoz/DynamicVariable"
                spec = {
                  name   = "k8s.namespace.name"
                  signal = "all"
                }
              }
            }
            sort = "alphabetical-asc"
          }
        }
      },
    ]
  }
  tags = [
    {
      key   = "tag"
      value = "pod"
    },
    {
      key   = "tag"
      value = "k8s"
    },
  ]
}

resource "signoz_dashboard" "redis_overview" {
  name           = "redis-overview-spcgl1at"
  schema_version = "v6"
  spec = {
    display = {
      description = "This dashboard shows the Redis instance overview. It includes latency, hit/miss rate, connections, and memory information.\n"
      name        = "Redis overview"
    }
    layouts = [
      {
        grid = {
          kind = "Grid"
          spec = {
            items = [
              {
                content = {
                  ref = "#/spec/panels/a77227c7-16f5-4353-952e-b183c715a61c"
                }
                height = 7
                width  = 6
                x      = 0
                y      = 0
              },
              {
                content = {
                  ref = "#/spec/panels/bf0deeeb-e926-4234-944c-82bacd96af47"
                }
                height = 7
                width  = 6
                x      = 6
                y      = 0
              },
              {
                content = {
                  ref = "#/spec/panels/b19c7058-b806-4ea2-974a-ca555b168991"
                }
                height = 7
                width  = 6
                x      = 0
                y      = 7
              },
              {
                content = {
                  ref = "#/spec/panels/f5ee1511-0d2b-4404-9ce0-e991837decc2"
                }
                height = 7
                width  = 6
                x      = 6
                y      = 7
              },
              {
                content = {
                  ref = "#/spec/panels/2fbaef0d-3cdb-4ce3-aa3c-9bbbb41786d9"
                }
                height = 7
                width  = 6
                x      = 3
                y      = 14
              },
              {
                content = {
                  ref = "#/spec/panels/d4c164bc-8fc2-4dbc-aadd-8d17479ca649"
                }
                height = 7
                width  = 6
                x      = 0
                y      = 21
              },
              {
                content = {
                  ref = "#/spec/panels/9698cee2-b1f3-4c0b-8c9f-3da4f0e05f17"
                }
                height = 7
                width  = 6
                x      = 6
                y      = 21
              },
              {
                content = {
                  ref = "#/spec/panels/64a5f303-d7db-44ff-9a0e-948e5c653320"
                }
                height = 7
                width  = 6
                x      = 0
                y      = 28
              },
              {
                content = {
                  ref = "#/spec/panels/3e80a918-69af-4c9a-bc57-a94e1d41b05c"
                }
                height = 7
                width  = 6
                x      = 6
                y      = 28
              },
            ]
          }
        }
      },
    ]
    links = [
    ]
    panels = {
      "2fbaef0d-3cdb-4ce3-aa3c-9bbbb41786d9" = {
        kind = "Panel"
        spec = {
          display = {
            name = "Command/s"
          }
          links = [
          ]
          plugin = {
            time_series_panel = {
              kind = "signoz/TimeSeriesPanel"
              spec = {
                axes = {
                  is_log_scale = false
                  soft_max     = 0
                  soft_min     = 0
                }
                chart_appearance = {
                  fill_mode          = "none"
                  line_interpolation = "spline"
                  line_style         = "solid"
                  show_points        = false
                  span_gaps = {
                    fill_only_below = false
                  }
                }
                formatting = {
                  decimal_precision = "2"
                  unit              = "ops"
                }
                legend = {
                  mode     = "list"
                  position = "bottom"
                }
                visualization = {
                  fill_spans      = false
                  time_preference = "global_time"
                }
              }
            }
          }
          queries = [
            {
              kind = "time_series"
              spec = {
                name = "A"
                plugin = {
                  builder_query = {
                    kind = "signoz/BuilderQuery"
                    spec = {
                      metrics = {
                        aggregations = [
                          {
                            metric_name       = "redis.commands"
                            reduce_to         = "sum"
                            space_aggregation = "sum"
                            time_aggregation  = "sum"
                          },
                        ]
                        disabled = false
                        filter = {
                          expression = "k8s.cluster.name in $k8s.cluster.name"
                        }
                        functions = [
                        ]
                        group_by = [
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "redis.version"
                          },
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "k8s.cluster.name"
                          },
                        ]
                        having = {
                        }
                        legend = "Redis {{redis.version}}"
                        name   = "A"
                        order = [
                        ]
                        signal        = "metrics"
                      }
                    }
                  }
                }
              }
            },
          ]
        }
      }
      "3e80a918-69af-4c9a-bc57-a94e1d41b05c" = {
        kind = "Panel"
        spec = {
          display = {
            description = "Number of evicted keys due to maxmemory limit"
            name        = "Eviction rate"
          }
          links = [
          ]
          plugin = {
            time_series_panel = {
              kind = "signoz/TimeSeriesPanel"
              spec = {
                axes = {
                  is_log_scale = false
                  soft_max     = 0
                  soft_min     = 0
                }
                chart_appearance = {
                  fill_mode          = "none"
                  line_interpolation = "spline"
                  line_style         = "solid"
                  show_points        = false
                  span_gaps = {
                    fill_only_below = false
                  }
                }
                formatting = {
                  decimal_precision = "2"
                  unit              = "short"
                }
                legend = {
                  mode     = "list"
                  position = "bottom"
                }
                visualization = {
                  fill_spans      = false
                  time_preference = "global_time"
                }
              }
            }
          }
          queries = [
            {
              kind = "time_series"
              spec = {
                name = "A"
                plugin = {
                  builder_query = {
                    kind = "signoz/BuilderQuery"
                    spec = {
                      metrics = {
                        aggregations = [
                          {
                            metric_name       = "redis.keys.evicted"
                            reduce_to         = "sum"
                            space_aggregation = "sum"
                            time_aggregation  = "rate"
                          },
                        ]
                        disabled = false
                        filter = {
                          expression = "k8s.cluster.name in $k8s.cluster.name"
                        }
                        functions = [
                        ]
                        group_by = [
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "k8s.cluster.name"
                          },
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "redis.version"
                          },
                        ]
                        having = {
                        }
                        legend = "Redis {{redis.version}}"
                        name   = "A"
                        order = [
                        ]
                        signal        = "metrics"
                      }
                    }
                  }
                }
              }
            },
          ]
        }
      }
      "64a5f303-d7db-44ff-9a0e-948e5c653320" = {
        kind = "Panel"
        spec = {
          display = {
            name = "Fragmentation ratio"
          }
          links = [
          ]
          plugin = {
            time_series_panel = {
              kind = "signoz/TimeSeriesPanel"
              spec = {
                axes = {
                  is_log_scale = false
                  soft_max     = 0
                  soft_min     = 0
                }
                chart_appearance = {
                  fill_mode          = "none"
                  line_interpolation = "spline"
                  line_style         = "solid"
                  show_points        = false
                  span_gaps = {
                    fill_only_below = false
                  }
                }
                formatting = {
                  decimal_precision = "2"
                  unit              = "short"
                }
                legend = {
                  mode     = "list"
                  position = "bottom"
                }
                visualization = {
                  fill_spans      = false
                  time_preference = "global_time"
                }
              }
            }
          }
          queries = [
            {
              kind = "time_series"
              spec = {
                name = "A"
                plugin = {
                  builder_query = {
                    kind = "signoz/BuilderQuery"
                    spec = {
                      metrics = {
                        aggregations = [
                          {
                            metric_name       = "redis.memory.fragmentation_ratio"
                            reduce_to         = "sum"
                            space_aggregation = "avg"
                            time_aggregation  = "avg"
                          },
                        ]
                        disabled = false
                        filter = {
                          expression = "k8s.cluster.name in $k8s.cluster.name"
                        }
                        functions = [
                        ]
                        group_by = [
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "redis.version"
                          },
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "k8s.cluster.name"
                          },
                        ]
                        having = {
                        }
                        legend = "Redis {{redis.version}}"
                        name   = "A"
                        order = [
                        ]
                        signal        = "metrics"
                      }
                    }
                  }
                }
              }
            },
          ]
        }
      }
      "9698cee2-b1f3-4c0b-8c9f-3da4f0e05f17" = {
        kind = "Panel"
        spec = {
          display = {
            name = "RSS Memory"
          }
          links = [
          ]
          plugin = {
            time_series_panel = {
              kind = "signoz/TimeSeriesPanel"
              spec = {
                axes = {
                  is_log_scale = false
                  soft_max     = 0
                  soft_min     = 0
                }
                chart_appearance = {
                  fill_mode          = "none"
                  line_interpolation = "spline"
                  line_style         = "solid"
                  show_points        = false
                  span_gaps = {
                    fill_only_below = false
                  }
                }
                formatting = {
                  decimal_precision = "2"
                  unit              = "bytes"
                }
                legend = {
                  mode     = "list"
                  position = "bottom"
                }
                visualization = {
                  fill_spans      = false
                  time_preference = "global_time"
                }
              }
            }
          }
          queries = [
            {
              kind = "time_series"
              spec = {
                name = "A"
                plugin = {
                  builder_query = {
                    kind = "signoz/BuilderQuery"
                    spec = {
                      metrics = {
                        aggregations = [
                          {
                            metric_name       = "redis.memory.rss"
                            reduce_to         = "sum"
                            space_aggregation = "sum"
                            time_aggregation  = "sum"
                          },
                        ]
                        disabled = false
                        filter = {
                          expression = "k8s.cluster.name in $k8s.cluster.name"
                        }
                        functions = [
                        ]
                        group_by = [
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "k8s.cluster.name"
                          },
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "redis.version"
                          },
                        ]
                        having = {
                        }
                        legend = "Redis {{redis.version}}"
                        name   = "A"
                        order = [
                        ]
                        signal        = "metrics"
                      }
                    }
                  }
                }
              }
            },
          ]
        }
      }
      a77227c7-16f5-4353-952e-b183c715a61c = {
        kind = "Panel"
        spec = {
          display = {
            description = "Rate successful lookup of keys in the main dictionary"
            name        = "Hits/s"
          }
          links = [
          ]
          plugin = {
            time_series_panel = {
              kind = "signoz/TimeSeriesPanel"
              spec = {
                axes = {
                  is_log_scale = false
                  soft_max     = 0
                  soft_min     = 0
                }
                chart_appearance = {
                  fill_mode          = "none"
                  line_interpolation = "spline"
                  line_style         = "solid"
                  show_points        = false
                  span_gaps = {
                    fill_only_below = false
                  }
                }
                formatting = {
                  decimal_precision = "2"
                  unit              = "none"
                }
                legend = {
                  mode     = "list"
                  position = "bottom"
                }
                visualization = {
                  fill_spans      = false
                  time_preference = "global_time"
                }
              }
            }
          }
          queries = [
            {
              kind = "time_series"
              spec = {
                name = "A"
                plugin = {
                  builder_query = {
                    kind = "signoz/BuilderQuery"
                    spec = {
                      metrics = {
                        aggregations = [
                          {
                            metric_name       = "redis.keyspace.hits"
                            reduce_to         = "sum"
                            space_aggregation = "sum"
                            time_aggregation  = "rate"
                          },
                        ]
                        disabled = false
                        filter = {
                          expression = "k8s.cluster.name in $k8s.cluster.name"
                        }
                        functions = [
                        ]
                        group_by = [
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "redis.version"
                          },
                        ]
                        having = {
                        }
                        legend = "Redis {{redis.version}}"
                        name   = "A"
                        order = [
                        ]
                        signal        = "metrics"
                      }
                    }
                  }
                }
              }
            },
          ]
        }
      }
      b19c7058-b806-4ea2-974a-ca555b168991 = {
        kind = "Panel"
        spec = {
          display = {
            name = "Keyspace Keys"
          }
          links = [
          ]
          plugin = {
            time_series_panel = {
              kind = "signoz/TimeSeriesPanel"
              spec = {
                axes = {
                  is_log_scale = false
                  soft_max     = 0
                  soft_min     = 0
                }
                chart_appearance = {
                  fill_mode          = "none"
                  line_interpolation = "spline"
                  line_style         = "solid"
                  show_points        = false
                  span_gaps = {
                    fill_only_below = false
                  }
                }
                formatting = {
                  decimal_precision = "2"
                  unit              = "none"
                }
                legend = {
                  mode     = "list"
                  position = "bottom"
                }
                visualization = {
                  fill_spans      = false
                  time_preference = "global_time"
                }
              }
            }
          }
          queries = [
            {
              kind = "time_series"
              spec = {
                name = "A"
                plugin = {
                  builder_query = {
                    kind = "signoz/BuilderQuery"
                    spec = {
                      metrics = {
                        aggregations = [
                          {
                            metric_name       = "redis.db.keys"
                            reduce_to         = "avg"
                            space_aggregation = "avg"
                            time_aggregation  = "avg"
                          },
                        ]
                        disabled = false
                        filter = {
                          expression = "k8s.cluster.name in $k8s.cluster.name"
                        }
                        functions = [
                        ]
                        group_by = [
                          {
                            name = "redis.version"
                          },
                          {
                            name = "k8s.cluster.name"
                          },
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "db"
                          },
                        ]
                        having = {
                        }
                        legend = "DB {{db}} - Redis {{redis.version}}"
                        name   = "A"
                        order = [
                        ]
                        signal        = "metrics"
                      }
                    }
                  }
                }
              }
            },
          ]
        }
      }
      bf0deeeb-e926-4234-944c-82bacd96af47 = {
        kind = "Panel"
        spec = {
          display = {
            description = "Number of clients pending on a blocking call"
            name        = "Clients blocked"
          }
          links = [
          ]
          plugin = {
            time_series_panel = {
              kind = "signoz/TimeSeriesPanel"
              spec = {
                axes = {
                  is_log_scale = false
                  soft_max     = 0
                  soft_min     = 0
                }
                chart_appearance = {
                  fill_mode          = "none"
                  line_interpolation = "spline"
                  line_style         = "solid"
                  show_points        = false
                  span_gaps = {
                    fill_only_below = false
                  }
                }
                formatting = {
                  decimal_precision = "2"
                  unit              = "none"
                }
                legend = {
                  mode     = "list"
                  position = "bottom"
                }
                visualization = {
                  fill_spans      = false
                  time_preference = "global_time"
                }
              }
            }
          }
          queries = [
            {
              kind = "time_series"
              spec = {
                name = "A"
                plugin = {
                  builder_query = {
                    kind = "signoz/BuilderQuery"
                    spec = {
                      metrics = {
                        aggregations = [
                          {
                            metric_name       = "redis.clients.blocked"
                            reduce_to         = "sum"
                            space_aggregation = "sum"
                            time_aggregation  = "sum"
                          },
                        ]
                        disabled = false
                        filter = {
                          expression = "k8s.cluster.name in $k8s.cluster.name"
                        }
                        functions = [
                        ]
                        group_by = [
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "k8s.cluster.name"
                          },
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "redis.version"
                          },
                        ]
                        having = {
                        }
                        legend = "Redis {{redis.version}}"
                        name   = "A"
                        order = [
                        ]
                        signal        = "metrics"
                      }
                    }
                  }
                }
              }
            },
          ]
        }
      }
      d4c164bc-8fc2-4dbc-aadd-8d17479ca649 = {
        kind = "Panel"
        spec = {
          display = {
            name = "Memory usage"
          }
          links = [
          ]
          plugin = {
            time_series_panel = {
              kind = "signoz/TimeSeriesPanel"
              spec = {
                axes = {
                  is_log_scale = false
                  soft_max     = 0
                  soft_min     = 0
                }
                chart_appearance = {
                  fill_mode          = "none"
                  line_interpolation = "spline"
                  line_style         = "solid"
                  show_points        = false
                  span_gaps = {
                    fill_only_below = false
                  }
                }
                formatting = {
                  decimal_precision = "2"
                  unit              = "bytes"
                }
                legend = {
                  mode     = "list"
                  position = "bottom"
                }
                visualization = {
                  fill_spans      = false
                  time_preference = "global_time"
                }
              }
            }
          }
          queries = [
            {
              kind = "time_series"
              spec = {
                plugin = {
                  composite_query = {
                    kind = "signoz/CompositeQuery"
                    spec = {
                      queries = [
                        {
                          builder_query = {
                            spec = {
                              metrics = {
                                aggregations = [
                                  {
                                    metric_name       = "redis.memory.used"
                                    reduce_to         = "sum"
                                    space_aggregation = "sum"
                                    time_aggregation  = "sum"
                                  },
                                ]
                                disabled = false
                                filter = {
                                  expression = "k8s.cluster.name in $k8s.cluster.name"
                                }
                                functions = [
                                ]
                                group_by = [
                                  {
                                    field_context   = "attribute"
                                    field_data_type = "string"
                                    name            = "redis.version"
                                  },
                                  {
                                    field_context   = "attribute"
                                    field_data_type = "string"
                                    name            = "k8s.cluster.name"
                                  },
                                ]
                                having = {
                                }
                                legend = "Used - Redis {{redis.version}}"
                                name   = "A"
                                order = [
                                ]
                                signal        = "metrics"
                              }
                            }
                            type = "builder_query"
                          }
                        },
                        {
                          builder_query = {
                            spec = {
                              metrics = {
                                aggregations = [
                                  {
                                    metric_name       = "redis.maxmemory"
                                    reduce_to         = "sum"
                                    space_aggregation = "max"
                                    time_aggregation  = "max"
                                  },
                                ]
                                disabled = false
                                filter = {
                                  expression = "k8s.cluster.name in $k8s.cluster.name"
                                }
                                functions = [
                                ]
                                group_by = [
                                  {
                                    field_context   = "attribute"
                                    field_data_type = "string"
                                    name            = "redis.version"
                                  },
                                  {
                                    field_context   = "attribute"
                                    field_data_type = "string"
                                    name            = "k8s.cluster.name"
                                  },
                                ]
                                having = {
                                }
                                legend = "Max - Redis {{redis.version}}"
                                name   = "B"
                                order = [
                                ]
                                signal        = "metrics"
                              }
                            }
                            type = "builder_query"
                          }
                        },
                      ]
                    }
                  }
                }
              }
            },
          ]
        }
      }
      f5ee1511-0d2b-4404-9ce0-e991837decc2 = {
        kind = "Panel"
        spec = {
          display = {
            description = "Number of changes since the last dump"
            name        = "Unsaved changes"
          }
          links = [
          ]
          plugin = {
            time_series_panel = {
              kind = "signoz/TimeSeriesPanel"
              spec = {
                axes = {
                  is_log_scale = false
                  soft_max     = 0
                  soft_min     = 0
                }
                chart_appearance = {
                  fill_mode          = "none"
                  line_interpolation = "spline"
                  line_style         = "solid"
                  show_points        = false
                  span_gaps = {
                    fill_only_below = false
                  }
                }
                formatting = {
                  decimal_precision = "2"
                  unit              = "none"
                }
                legend = {
                  mode     = "list"
                  position = "bottom"
                }
                visualization = {
                  fill_spans      = false
                  time_preference = "global_time"
                }
              }
            }
          }
          queries = [
            {
              kind = "time_series"
              spec = {
                name = "A"
                plugin = {
                  builder_query = {
                    kind = "signoz/BuilderQuery"
                    spec = {
                      metrics = {
                        aggregations = [
                          {
                            metric_name       = "redis.rdb.changes_since_last_save"
                            reduce_to         = "sum"
                            space_aggregation = "sum"
                            time_aggregation  = "sum"
                          },
                        ]
                        disabled = false
                        filter = {
                          expression = "k8s.cluster.name in $k8s.cluster.name"
                        }
                        functions = [
                        ]
                        group_by = [
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "k8s.cluster.name"
                          },
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "redis.version"
                          },
                        ]
                        having = {
                        }
                        legend = "Redis {{redis.version}}"
                        name   = "A"
                        order = [
                        ]
                        signal        = "metrics"
                      }
                    }
                  }
                }
              }
            },
          ]
        }
      }
    }
    variables = [
      {
        list_variable = {
          kind = "ListVariable"
          spec = {
            allow_all_value = false
            allow_multiple  = false
            display = {
              description = "The k8s.cluster.name"
              name        = "k8s.cluster.name"
            }
            name = "k8s.cluster.name"
            plugin = {
              dynamic_variable = {
                kind = "signoz/DynamicVariable"
                spec = {
                  name   = "k8s.cluster.name"
                  signal = "all"
                }
              }
            }
            sort = "none"
          }
        }
      },
    ]
  }
  tags = [
    {
      key   = "tag"
      value = "redis"
    },
    {
      key   = "tag"
      value = "database"
    },
  ]
}

resource "signoz_dashboard" "k8s_cluster_metrics" {
  name           = "kubernetes-cluster-metrics-pqmcwcgb"
  schema_version = "v6"
  spec = {
    display = {
      description = "This dashboard uses the metrics sent using `k8sclusterreceiver` to show the desired and currently running pods for deployments, daemonsets, statefulset, replicasets and pods count by phase."
      name        = "Kubernetes Cluster Metrics"
    }
    layouts = [
      {
        grid = {
          kind = "Grid"
          spec = {
            items = [
              {
                content = {
                  ref = "#/spec/panels/7c4b1efb-8b3a-4a28-927d-f7fe9fb124e8"
                }
                height = 5
                width  = 12
                x      = 0
                y      = 0
              },
              {
                content = {
                  ref = "#/spec/panels/50a86ebc-f028-44bf-93f4-a62cc0ba8dd9"
                }
                height = 7
                width  = 6
                x      = 0
                y      = 5
              },
              {
                content = {
                  ref = "#/spec/panels/f4c5050e-fcb8-46f7-88b7-e8f13c8d6fdd"
                }
                height = 7
                width  = 6
                x      = 6
                y      = 5
              },
              {
                content = {
                  ref = "#/spec/panels/889f2919-d0d7-4eab-8f83-3a51fa11bf41"
                }
                height = 6
                width  = 12
                x      = 0
                y      = 12
              },
              {
                content = {
                  ref = "#/spec/panels/e87e271c-727b-4ae1-8d11-609a1ffaa31d"
                }
                height = 6
                width  = 12
                x      = 0
                y      = 18
              },
              {
                content = {
                  ref = "#/spec/panels/cac6085f-b603-48fb-9094-61c7eedd3b1f"
                }
                height = 6
                width  = 12
                x      = 0
                y      = 24
              },
            ]
          }
        }
      },
    ]
    links = [
    ]
    panels = {
      "50a86ebc-f028-44bf-93f4-a62cc0ba8dd9" = {
        kind = "Panel"
        spec = {
          display = {
            name = "Deployments available and desired"
          }
          links = [
          ]
          plugin = {
            table_panel = {
              kind = "signoz/TablePanel"
              spec = {
                formatting = {
                  column_units = {
                    A = ""
                    B = ""
                  }
                  decimal_precision = "2"
                }
                visualization = {
                  time_preference = "global_time"
                }
              }
            }
          }
          queries = [
            {
              kind = "scalar"
              spec = {
                plugin = {
                  composite_query = {
                    kind = "signoz/CompositeQuery"
                    spec = {
                      queries = [
                        {
                          builder_query = {
                            spec = {
                              metrics = {
                                aggregations = [
                                  {
                                    metric_name       = "k8s.deployment.available"
                                    reduce_to         = "last"
                                    space_aggregation = "sum"
                                    time_aggregation  = "latest"
                                  },
                                ]
                                disabled = false
                                filter = {
                                  expression = "(k8s.cluster.name IN $k8s.cluster.name  AND k8s.namespace.name IN $k8s.namespace.name)"
                                }
                                functions = [
                                ]
                                group_by = [
                                  {
                                    field_context   = "attribute"
                                    field_data_type = "string"
                                    name            = "k8s.deployment.name"
                                  },
                                ]
                                having = {
                                }
                                legend = "available"
                                name   = "A"
                                order = [
                                ]
                                signal        = "metrics"
                              }
                            }
                            type = "builder_query"
                          }
                        },
                        {
                          builder_query = {
                            spec = {
                              metrics = {
                                aggregations = [
                                  {
                                    metric_name       = "k8s.deployment.desired"
                                    reduce_to         = "last"
                                    space_aggregation = "sum"
                                    time_aggregation  = "latest"
                                  },
                                ]
                                disabled = false
                                filter = {
                                  expression = "(k8s.cluster.name IN $k8s.cluster.name  AND k8s.namespace.name IN $k8s.namespace.name)"
                                }
                                functions = [
                                ]
                                group_by = [
                                  {
                                    field_context   = "attribute"
                                    field_data_type = "string"
                                    name            = "k8s.deployment.name"
                                  },
                                ]
                                having = {
                                }
                                legend = "desired"
                                name   = "B"
                                order = [
                                ]
                                signal        = "metrics"
                              }
                            }
                            type = "builder_query"
                          }
                        },
                      ]
                    }
                  }
                }
              }
            },
          ]
        }
      }
      "7c4b1efb-8b3a-4a28-927d-f7fe9fb124e8" = {
        kind = "Panel"
        spec = {
          display = {
            name = "Pod phase by namespace"
          }
          links = [
          ]
          plugin = {
            table_panel = {
              kind = "signoz/TablePanel"
              spec = {
                formatting = {
                  column_units = {
                    A = ""
                  }
                  decimal_precision = "2"
                }
                visualization = {
                  time_preference = "global_time"
                }
              }
            }
          }
          queries = [
            {
              kind = "scalar"
              spec = {
                name = "A"
                plugin = {
                  click_house_sql = {
                    kind = "signoz/ClickHouseSQL"
                    spec = {
                      disabled = false
                      name     = "A"
                      query    = "SELECT `k8s.namespace.name`, countIf(last_phase = 1) AS Pending, countIf(last_phase = 2) AS Running, countIf(last_phase = 3) AS Succeeded, countIf(last_phase = 4) AS Failed, countIf(last_phase = 5) AS Unknown FROM (SELECT `k8s.pod.name`, `k8s.namespace.name`, now() AS ts, anyLast(`value`) AS last_phase FROM signoz_metrics.distributed_samples_v4 INNER JOIN (SELECT DISTINCT JSONExtractString(labels, 'k8s.pod.name') AS `k8s.pod.name`, JSONExtractString(labels, 'k8s.namespace.name') AS `k8s.namespace.name`, JSONExtractString(labels, 'k8s.cluster.name') AS `k8s.cluster.name`, fingerprint FROM signoz_metrics.time_series_v4_1day WHERE (metric_name = 'k8s.pod.phase') AND (temporality = 'Unspecified') AND JSONExtractString(labels, 'k8s.cluster.name') = $k8s.cluster.name AND JSONExtractString(labels, 'k8s.namespace.name') IN $k8s.namespace.name) AS filtered_time_series USING fingerprint WHERE (metric_name = 'k8s.pod.phase') AND (unix_milli >= $start_timestamp_ms) AND (unix_milli < $end_timestamp_ms) GROUP BY `k8s.pod.name`, `k8s.namespace.name`, ts ORDER BY `k8s.namespace.name` ASC, `k8s.pod.name` ASC, ts ASC) GROUP BY `k8s.namespace.name` ORDER BY Running DESC\n"
                    }
                  }
                }
              }
            },
          ]
        }
      }
      "889f2919-d0d7-4eab-8f83-3a51fa11bf41" = {
        kind = "Panel"
        spec = {
          display = {
            name = "Jobs"
          }
          links = [
          ]
          plugin = {
            table_panel = {
              kind = "signoz/TablePanel"
              spec = {
                formatting = {
                  column_units = {
                    A = ""
                    B = ""
                    C = ""
                    D = ""
                  }
                  decimal_precision = "2"
                }
                visualization = {
                  time_preference = "global_time"
                }
              }
            }
          }
          queries = [
            {
              kind = "scalar"
              spec = {
                plugin = {
                  composite_query = {
                    kind = "signoz/CompositeQuery"
                    spec = {
                      queries = [
                        {
                          builder_query = {
                            spec = {
                              metrics = {
                                aggregations = [
                                  {
                                    metric_name       = "k8s.job.active_pods"
                                    reduce_to         = "last"
                                    space_aggregation = "sum"
                                    time_aggregation  = "max"
                                  },
                                ]
                                disabled = false
                                filter = {
                                  expression = "(k8s.cluster.name IN $k8s.cluster.name  AND k8s.namespace.name IN $k8s.namespace.name)"
                                }
                                functions = [
                                ]
                                group_by = [
                                  {
                                    field_context   = "attribute"
                                    field_data_type = "string"
                                    name            = "k8s.job.name"
                                  },
                                ]
                                having = {
                                }
                                legend = "running"
                                name   = "A"
                                order = [
                                ]
                                signal        = "metrics"
                              }
                            }
                            type = "builder_query"
                          }
                        },
                        {
                          builder_query = {
                            spec = {
                              metrics = {
                                aggregations = [
                                  {
                                    metric_name       = "k8s.job.successful_pods"
                                    reduce_to         = "last"
                                    space_aggregation = "sum"
                                    time_aggregation  = "max"
                                  },
                                ]
                                disabled = false
                                filter = {
                                  expression = "(k8s.cluster.name IN $k8s.cluster.name  AND k8s.namespace.name IN $k8s.namespace.name)"
                                }
                                functions = [
                                ]
                                group_by = [
                                  {
                                    field_context   = "attribute"
                                    field_data_type = "string"
                                    name            = "k8s.job.name"
                                  },
                                ]
                                having = {
                                }
                                legend = "successful"
                                name   = "B"
                                order = [
                                ]
                                signal        = "metrics"
                              }
                            }
                            type = "builder_query"
                          }
                        },
                        {
                          builder_query = {
                            spec = {
                              metrics = {
                                aggregations = [
                                  {
                                    metric_name       = "k8s.job.failed_pods"
                                    reduce_to         = "last"
                                    space_aggregation = "sum"
                                    time_aggregation  = "max"
                                  },
                                ]
                                disabled = false
                                filter = {
                                  expression = "(k8s.cluster.name IN $k8s.cluster.name  AND k8s.namespace.name IN $k8s.namespace.name)"
                                }
                                functions = [
                                ]
                                group_by = [
                                  {
                                    field_context   = "attribute"
                                    field_data_type = "string"
                                    name            = "k8s.job.name"
                                  },
                                ]
                                having = {
                                }
                                legend = "failed"
                                name   = "C"
                                order = [
                                ]
                                signal        = "metrics"
                              }
                            }
                            type = "builder_query"
                          }
                        },
                        {
                          builder_query = {
                            spec = {
                              metrics = {
                                aggregations = [
                                  {
                                    metric_name       = "k8s.job.desired_successful_pods"
                                    reduce_to         = "last"
                                    space_aggregation = "sum"
                                    time_aggregation  = "max"
                                  },
                                ]
                                disabled = false
                                filter = {
                                  expression = "(k8s.cluster.name IN $k8s.cluster.name  AND k8s.namespace.name IN $k8s.namespace.name)"
                                }
                                functions = [
                                ]
                                group_by = [
                                  {
                                    field_context   = "attribute"
                                    field_data_type = "string"
                                    name            = "k8s.job.name"
                                  },
                                ]
                                having = {
                                }
                                legend = "desired successful"
                                name   = "D"
                                order = [
                                ]
                                signal        = "metrics"
                              }
                            }
                            type = "builder_query"
                          }
                        },
                      ]
                    }
                  }
                }
              }
            },
          ]
        }
      }
      cac6085f-b603-48fb-9094-61c7eedd3b1f = {
        kind = "Panel"
        spec = {
          display = {
            name = "Pod replicas"
          }
          links = [
          ]
          plugin = {
            table_panel = {
              kind = "signoz/TablePanel"
              spec = {
                formatting = {
                  column_units = {
                    A = ""
                    B = ""
                    C = ""
                    D = ""
                  }
                  decimal_precision = "2"
                }
                visualization = {
                  time_preference = "global_time"
                }
              }
            }
          }
          queries = [
            {
              kind = "scalar"
              spec = {
                plugin = {
                  composite_query = {
                    kind = "signoz/CompositeQuery"
                    spec = {
                      queries = [
                        {
                          builder_query = {
                            spec = {
                              metrics = {
                                aggregations = [
                                  {
                                    metric_name       = "k8s.hpa.current_replicas"
                                    reduce_to         = "last"
                                    space_aggregation = "sum"
                                    time_aggregation  = "avg"
                                  },
                                ]
                                disabled = false
                                filter = {
                                  expression = "(k8s.cluster.name IN $k8s.cluster.name  AND k8s.namespace.name IN $k8s.namespace.name)"
                                }
                                functions = [
                                ]
                                group_by = [
                                  {
                                    field_context   = "attribute"
                                    field_data_type = "string"
                                    name            = "k8s.hpa.name"
                                  },
                                ]
                                having = {
                                }
                                legend = "current_replicas"
                                name   = "A"
                                order = [
                                ]
                                signal        = "metrics"
                              }
                            }
                            type = "builder_query"
                          }
                        },
                        {
                          builder_query = {
                            spec = {
                              metrics = {
                                aggregations = [
                                  {
                                    metric_name       = "k8s.hpa.desired_replicas"
                                    reduce_to         = "last"
                                    space_aggregation = "sum"
                                    time_aggregation  = "avg"
                                  },
                                ]
                                disabled = false
                                filter = {
                                  expression = "(k8s.cluster.name IN $k8s.cluster.name  AND k8s.namespace.name IN $k8s.namespace.name)"
                                }
                                functions = [
                                ]
                                group_by = [
                                  {
                                    field_context   = "attribute"
                                    field_data_type = "string"
                                    name            = "k8s.hpa.name"
                                  },
                                ]
                                having = {
                                }
                                legend = "desired_replicas"
                                name   = "B"
                                order = [
                                ]
                                signal        = "metrics"
                              }
                            }
                            type = "builder_query"
                          }
                        },
                        {
                          builder_query = {
                            spec = {
                              metrics = {
                                aggregations = [
                                  {
                                    metric_name       = "k8s.hpa.min_replicas"
                                    reduce_to         = "last"
                                    space_aggregation = "sum"
                                    time_aggregation  = "avg"
                                  },
                                ]
                                disabled = false
                                filter = {
                                  expression = "(k8s.cluster.name IN $k8s.cluster.name  AND k8s.namespace.name IN $k8s.namespace.name) "
                                }
                                functions = [
                                ]
                                group_by = [
                                  {
                                    field_context   = "attribute"
                                    field_data_type = "string"
                                    name            = "k8s.hpa.name"
                                  },
                                ]
                                having = {
                                }
                                legend = "min_replicas"
                                name   = "C"
                                order = [
                                ]
                                signal        = "metrics"
                              }
                            }
                            type = "builder_query"
                          }
                        },
                        {
                          builder_query = {
                            spec = {
                              metrics = {
                                aggregations = [
                                  {
                                    metric_name       = "k8s.hpa.max_replicas"
                                    reduce_to         = "last"
                                    space_aggregation = "sum"
                                    time_aggregation  = "avg"
                                  },
                                ]
                                disabled = false
                                filter = {
                                  expression = "(k8s.cluster.name IN $k8s.cluster.name  AND k8s.namespace.name IN $k8s.namespace.name)"
                                }
                                functions = [
                                ]
                                group_by = [
                                  {
                                    field_context   = "attribute"
                                    field_data_type = "string"
                                    name            = "k8s.hpa.name"
                                  },
                                ]
                                having = {
                                }
                                legend = "max_replicas"
                                name   = "D"
                                order = [
                                ]
                                signal        = "metrics"
                              }
                            }
                            type = "builder_query"
                          }
                        },
                      ]
                    }
                  }
                }
              }
            },
          ]
        }
      }
      e87e271c-727b-4ae1-8d11-609a1ffaa31d = {
        kind = "Panel"
        spec = {
          display = {
            name = "Statefulset pods"
          }
          links = [
          ]
          plugin = {
            table_panel = {
              kind = "signoz/TablePanel"
              spec = {
                formatting = {
                  column_units = {
                    A = ""
                    B = ""
                    C = ""
                    D = ""
                  }
                  decimal_precision = "2"
                }
                visualization = {
                  time_preference = "global_time"
                }
              }
            }
          }
          queries = [
            {
              kind = "scalar"
              spec = {
                plugin = {
                  composite_query = {
                    kind = "signoz/CompositeQuery"
                    spec = {
                      queries = [
                        {
                          builder_query = {
                            spec = {
                              metrics = {
                                aggregations = [
                                  {
                                    metric_name       = "k8s.statefulset.current_pods"
                                    reduce_to         = "last"
                                    space_aggregation = "sum"
                                    time_aggregation  = "max"
                                  },
                                ]
                                disabled = false
                                filter = {
                                  expression = "(k8s.cluster.name IN $k8s.cluster.name  AND k8s.namespace.name IN $k8s.namespace.name)"
                                }
                                functions = [
                                ]
                                group_by = [
                                  {
                                    field_context   = "attribute"
                                    field_data_type = "string"
                                    name            = "k8s.statefulset.name"
                                  },
                                ]
                                having = {
                                }
                                legend = "current"
                                name   = "A"
                                order = [
                                ]
                                signal        = "metrics"
                              }
                            }
                            type = "builder_query"
                          }
                        },
                        {
                          builder_query = {
                            spec = {
                              metrics = {
                                aggregations = [
                                  {
                                    metric_name       = "k8s.statefulset.desired_pods"
                                    reduce_to         = "last"
                                    space_aggregation = "sum"
                                    time_aggregation  = "max"
                                  },
                                ]
                                disabled = false
                                filter = {
                                  expression = "(k8s.cluster.name IN $k8s.cluster.name  AND k8s.namespace.name IN $k8s.namespace.name)"
                                }
                                functions = [
                                ]
                                group_by = [
                                  {
                                    field_context   = "attribute"
                                    field_data_type = "string"
                                    name            = "k8s.statefulset.name"
                                  },
                                ]
                                having = {
                                }
                                legend = "desired"
                                name   = "B"
                                order = [
                                ]
                                signal        = "metrics"
                              }
                            }
                            type = "builder_query"
                          }
                        },
                        {
                          builder_query = {
                            spec = {
                              metrics = {
                                aggregations = [
                                  {
                                    metric_name       = "k8s.statefulset.ready_pods"
                                    reduce_to         = "last"
                                    space_aggregation = "sum"
                                    time_aggregation  = "max"
                                  },
                                ]
                                disabled = false
                                filter = {
                                  expression = "(k8s.cluster.name IN $k8s.cluster.name  AND k8s.namespace.name IN $k8s.namespace.name)"
                                }
                                functions = [
                                ]
                                group_by = [
                                  {
                                    field_context   = "attribute"
                                    field_data_type = "string"
                                    name            = "k8s.statefulset.name"
                                  },
                                ]
                                having = {
                                }
                                legend = "ready"
                                name   = "C"
                                order = [
                                ]
                                signal        = "metrics"
                              }
                            }
                            type = "builder_query"
                          }
                        },
                        {
                          builder_query = {
                            spec = {
                              metrics = {
                                aggregations = [
                                  {
                                    metric_name       = "k8s.statefulset.updated_pods"
                                    reduce_to         = "last"
                                    space_aggregation = "sum"
                                    time_aggregation  = "max"
                                  },
                                ]
                                disabled = false
                                filter = {
                                  expression = "(k8s.cluster.name IN $k8s.cluster.name  AND k8s.namespace.name IN $k8s.namespace.name) "
                                }
                                functions = [
                                ]
                                group_by = [
                                  {
                                    field_context   = "attribute"
                                    field_data_type = "string"
                                    name            = "k8s.statefulset.name"
                                  },
                                ]
                                having = {
                                }
                                legend = "updated"
                                name   = "D"
                                order = [
                                ]
                                signal        = "metrics"
                              }
                            }
                            type = "builder_query"
                          }
                        },
                      ]
                    }
                  }
                }
              }
            },
          ]
        }
      }
      f4c5050e-fcb8-46f7-88b7-e8f13c8d6fdd = {
        kind = "Panel"
        spec = {
          display = {
            name = "Daemonset nodes"
          }
          links = [
          ]
          plugin = {
            table_panel = {
              kind = "signoz/TablePanel"
              spec = {
                formatting = {
                  column_units = {
                    A = ""
                    B = ""
                    C = ""
                  }
                  decimal_precision = "2"
                }
                visualization = {
                  time_preference = "global_time"
                }
              }
            }
          }
          queries = [
            {
              kind = "scalar"
              spec = {
                plugin = {
                  composite_query = {
                    kind = "signoz/CompositeQuery"
                    spec = {
                      queries = [
                        {
                          builder_query = {
                            spec = {
                              metrics = {
                                aggregations = [
                                  {
                                    metric_name       = "k8s.daemonset.current_scheduled_nodes"
                                    reduce_to         = "last"
                                    space_aggregation = "avg"
                                    time_aggregation  = "avg"
                                  },
                                ]
                                disabled = false
                                filter = {
                                  expression = "(k8s.cluster.name IN $k8s.cluster.name  AND k8s.namespace.name IN $k8s.namespace.name)"
                                }
                                functions = [
                                ]
                                group_by = [
                                  {
                                    field_context   = "attribute"
                                    field_data_type = "string"
                                    name            = "k8s.daemonset.name"
                                  },
                                ]
                                having = {
                                }
                                legend = "current_nodes"
                                name   = "A"
                                order = [
                                ]
                                signal        = "metrics"
                              }
                            }
                            type = "builder_query"
                          }
                        },
                        {
                          builder_query = {
                            spec = {
                              metrics = {
                                aggregations = [
                                  {
                                    metric_name       = "k8s.daemonset.desired_scheduled_nodes"
                                    reduce_to         = "last"
                                    space_aggregation = "avg"
                                    time_aggregation  = "avg"
                                  },
                                ]
                                disabled = false
                                filter = {
                                  expression = "(k8s.cluster.name IN $k8s.cluster.name  AND k8s.namespace.name IN $k8s.namespace.name)"
                                }
                                functions = [
                                ]
                                group_by = [
                                  {
                                    field_context   = "attribute"
                                    field_data_type = "string"
                                    name            = "k8s.daemonset.name"
                                  },
                                ]
                                having = {
                                }
                                legend = "desired_nodes"
                                name   = "B"
                                order = [
                                ]
                                signal        = "metrics"
                              }
                            }
                            type = "builder_query"
                          }
                        },
                        {
                          builder_query = {
                            spec = {
                              metrics = {
                                aggregations = [
                                  {
                                    metric_name       = "k8s.daemonset.ready_nodes"
                                    reduce_to         = "last"
                                    space_aggregation = "avg"
                                    time_aggregation  = "avg"
                                  },
                                ]
                                disabled = false
                                filter = {
                                  expression = "(k8s.cluster.name IN $k8s.cluster.name  AND k8s.namespace.name IN $k8s.namespace.name)"
                                }
                                functions = [
                                ]
                                group_by = [
                                  {
                                    field_context   = "attribute"
                                    field_data_type = "string"
                                    name            = "k8s.daemonset.name"
                                  },
                                ]
                                having = {
                                }
                                legend = "ready_nodes"
                                name   = "C"
                                order = [
                                ]
                                signal        = "metrics"
                              }
                            }
                            type = "builder_query"
                          }
                        },
                      ]
                    }
                  }
                }
              }
            },
          ]
        }
      }
    }
    variables = [
      {
        list_variable = {
          kind = "ListVariable"
          spec = {
            allow_all_value = false
            allow_multiple  = false
            display = {
              description = "The k8s.cluster.name"
              name        = "k8s.cluster.name"
            }
            name = "k8s.cluster.name"
            plugin = {
              dynamic_variable = {
                kind = "signoz/DynamicVariable"
                spec = {
                  name   = "k8s.cluster.name"
                  signal = "all"
                }
              }
            }
            sort = "none"
          }
        }
      },
      {
        list_variable = {
          kind = "ListVariable"
          spec = {
            allow_all_value = true
            allow_multiple  = true
            display = {
              description = "The k8s namespace name.\t"
              name        = "k8s.namespace.name"
            }
            name = "k8s.namespace.name"
            plugin = {
              dynamic_variable = {
                kind = "signoz/DynamicVariable"
                spec = {
                  name   = "k8s.namespace.name"
                  signal = "all"
                }
              }
            }
            sort = "alphabetical-asc"
          }
        }
      },
    ]
  }
  tags = [
    {
      key   = "tag"
      value = "k8s"
    },
    {
      key   = "tag"
      value = "cluster"
    },
    {
      key   = "tag"
      value = "k8sclusterreceiver"
    },
  ]
}

resource "signoz_dashboard" "postgres_overview" {
  name           = "postgres-overview-2uz6e7iq"
  schema_version = "v6"
  spec = {
    display = {
      description = "This dashboard provides a high-level overview of PostgreSQL databases"
      name        = "Postgres overview"
    }
    layouts = [
      {
        grid = {
          kind = "Grid"
          spec = {
            items = [
              {
                content = {
                  ref = "#/spec/panels/191d09a6-40b0-4de8-a5b0-aa4254454b99"
                }
                height = 7
                width  = 6
                x      = 0
                y      = 0
              },
              {
                content = {
                  ref = "#/spec/panels/fa941c00-ce19-49cc-baf2-c38598767dee"
                }
                height = 7
                width  = 6
                x      = 6
                y      = 0
              },
              {
                content = {
                  ref = "#/spec/panels/114fcf80-e1de-4716-b1aa-0e0738dba10e"
                }
                height = 7
                width  = 6
                x      = 0
                y      = 7
              },
              {
                content = {
                  ref = "#/spec/panels/667428ef-9b9a-4e91-bd1e-938e0dc1ff32"
                }
                height = 7
                width  = 6
                x      = 6
                y      = 7
              },
              {
                content = {
                  ref = "#/spec/panels/6b700035-e3c2-4c48-99fa-ebfd6202eed3"
                }
                height = 7
                width  = 6
                x      = 0
                y      = 14
              },
              {
                content = {
                  ref = "#/spec/panels/e9341e70-ccb3-47fc-af95-56ba8942c4f2"
                }
                height = 7
                width  = 6
                x      = 6
                y      = 14
              },
              {
                content = {
                  ref = "#/spec/panels/8638a199-20a0-4255-b0a2-3b1ba06c485b"
                }
                height = 7
                width  = 6
                x      = 0
                y      = 21
              },
              {
                content = {
                  ref = "#/spec/panels/7b74bb10-54eb-4f6c-97ce-16b28b629b41"
                }
                height = 7
                width  = 6
                x      = 6
                y      = 21
              },
              {
                content = {
                  ref = "#/spec/panels/d7838815-4f5b-4454-86fd-f658b201f3a9"
                }
                height = 7
                width  = 6
                x      = 0
                y      = 28
              },
              {
                content = {
                  ref = "#/spec/panels/f9a6f683-7455-4643-acc8-467cc5ea52cf"
                }
                height = 7
                width  = 6
                x      = 6
                y      = 28
              },
              {
                content = {
                  ref = "#/spec/panels/9552123d-6265-48a7-8624-3f4a3fc3c9c0"
                }
                height = 7
                width  = 12
                x      = 0
                y      = 35
              },
              {
                content = {
                  ref = "#/spec/panels/bada7864-1d23-4d49-a868-c6b8a93c738f"
                }
                height = 7
                width  = 12
                x      = 0
                y      = 42
              },
            ]
          }
        }
      },
    ]
    links = [
    ]
    panels = {
      "114fcf80-e1de-4716-b1aa-0e0738dba10e" = {
        kind = "Panel"
        spec = {
          display = {
            description = "The average number of db delete operations."
            name        = "Deleted"
          }
          links = [
          ]
          plugin = {
            time_series_panel = {
              kind = "signoz/TimeSeriesPanel"
              spec = {
                axes = {
                  is_log_scale = false
                  soft_max     = 0
                  soft_min     = 0
                }
                chart_appearance = {
                  fill_mode          = "none"
                  line_interpolation = "spline"
                  line_style         = "solid"
                  show_points        = false
                  span_gaps = {
                    fill_only_below = false
                  }
                }
                formatting = {
                  decimal_precision = "2"
                  unit              = "none"
                }
                legend = {
                  mode     = "list"
                  position = "bottom"
                }
                visualization = {
                  fill_spans      = false
                  time_preference = "global_time"
                }
              }
            }
          }
          queries = [
            {
              kind = "time_series"
              spec = {
                name = "A"
                plugin = {
                  builder_query = {
                    kind = "signoz/BuilderQuery"
                    spec = {
                      metrics = {
                        aggregations = [
                          {
                            metric_name       = "postgresql.operations"
                            reduce_to         = "sum"
                            space_aggregation = "avg"
                            time_aggregation  = "avg"
                          },
                        ]
                        disabled = false
                        filter = {
                          expression = "k8s.cluster.name in $k8s.cluster.name AND postgresql.database.name IN $postgresql.database.name AND operation = 'del'"
                        }
                        functions = [
                        ]
                        group_by = [
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "postgresql.database.name"
                          },
                        ]
                        having = {
                        }
                        legend = "{{postgresql.database.name}}"
                        name   = "A"
                        order = [
                        ]
                        signal        = "metrics"
                      }
                    }
                  }
                }
              }
            },
          ]
        }
      }
      "191d09a6-40b0-4de8-a5b0-aa4254454b99" = {
        kind = "Panel"
        spec = {
          display = {
            description = "The average number of db insert operations."
            name        = "Inserts"
          }
          links = [
          ]
          plugin = {
            time_series_panel = {
              kind = "signoz/TimeSeriesPanel"
              spec = {
                axes = {
                  is_log_scale = false
                  soft_max     = 0
                  soft_min     = 0
                }
                chart_appearance = {
                  fill_mode          = "none"
                  line_interpolation = "spline"
                  line_style         = "solid"
                  show_points        = false
                  span_gaps = {
                    fill_only_below = false
                  }
                }
                formatting = {
                  decimal_precision = "2"
                  unit              = "none"
                }
                legend = {
                  mode     = "list"
                  position = "bottom"
                }
                visualization = {
                  fill_spans      = false
                  time_preference = "global_time"
                }
              }
            }
          }
          queries = [
            {
              kind = "time_series"
              spec = {
                name = "A"
                plugin = {
                  builder_query = {
                    kind = "signoz/BuilderQuery"
                    spec = {
                      metrics = {
                        aggregations = [
                          {
                            metric_name       = "postgresql.operations"
                            reduce_to         = "sum"
                            space_aggregation = "avg"
                            time_aggregation  = "avg"
                          },
                        ]
                        disabled = false
                        filter = {
                          expression = "k8s.cluster.name in $k8s.cluster.name AND postgresql.database.name IN $postgresql.database.name AND operation = 'ins'"
                        }
                        functions = [
                        ]
                        group_by = [
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "postgresql.database.name"
                          },
                        ]
                        having = {
                        }
                        legend = "{{postgresql.database.name}}"
                        name   = "A"
                        order = [
                        ]
                        signal        = "metrics"
                      }
                    }
                  }
                }
              }
            },
          ]
        }
      }
      "667428ef-9b9a-4e91-bd1e-938e0dc1ff32" = {
        kind = "Panel"
        spec = {
          display = {
            description = "The average number of db heap-only update operations."
            name        = "Heap updates"
          }
          links = [
          ]
          plugin = {
            time_series_panel = {
              kind = "signoz/TimeSeriesPanel"
              spec = {
                axes = {
                  is_log_scale = false
                  soft_max     = 0
                  soft_min     = 0
                }
                chart_appearance = {
                  fill_mode          = "none"
                  line_interpolation = "spline"
                  line_style         = "solid"
                  show_points        = false
                  span_gaps = {
                    fill_only_below = false
                  }
                }
                formatting = {
                  decimal_precision = "2"
                  unit              = "none"
                }
                legend = {
                  mode     = "list"
                  position = "bottom"
                }
                visualization = {
                  fill_spans      = false
                  time_preference = "global_time"
                }
              }
            }
          }
          queries = [
            {
              kind = "time_series"
              spec = {
                name = "A"
                plugin = {
                  builder_query = {
                    kind = "signoz/BuilderQuery"
                    spec = {
                      metrics = {
                        aggregations = [
                          {
                            metric_name       = "postgresql.operations"
                            reduce_to         = "sum"
                            space_aggregation = "avg"
                            time_aggregation  = "avg"
                          },
                        ]
                        disabled = false
                        filter = {
                          expression = "k8s.cluster.name in $k8s.cluster.name AND postgresql.database.name IN $postgresql.database.name AND operation = 'hot_upd'"
                        }
                        functions = [
                        ]
                        group_by = [
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "postgresql.database.name"
                          },
                        ]
                        having = {
                        }
                        legend = "{{postgresql.database.name}}"
                        name   = "A"
                        order = [
                        ]
                        signal        = "metrics"
                      }
                    }
                  }
                }
              }
            },
          ]
        }
      }
      "6b700035-e3c2-4c48-99fa-ebfd6202eed3" = {
        kind = "Panel"
        spec = {
          display = {
            description = "The number of database locks."
            name        = "Locks by lock mode"
          }
          links = [
          ]
          plugin = {
            time_series_panel = {
              kind = "signoz/TimeSeriesPanel"
              spec = {
                axes = {
                  is_log_scale = false
                  soft_max     = 0
                  soft_min     = 0
                }
                chart_appearance = {
                  fill_mode          = "none"
                  line_interpolation = "spline"
                  line_style         = "solid"
                  show_points        = false
                  span_gaps = {
                    fill_only_below = false
                  }
                }
                formatting = {
                  decimal_precision = "2"
                  unit              = "none"
                }
                legend = {
                  mode     = "list"
                  position = "bottom"
                }
                visualization = {
                  fill_spans      = false
                  time_preference = "global_time"
                }
              }
            }
          }
          queries = [
            {
              kind = "time_series"
              spec = {
                name = "A"
                plugin = {
                  builder_query = {
                    kind = "signoz/BuilderQuery"
                    spec = {
                      metrics = {
                        aggregations = [
                          {
                            metric_name       = "postgresql.database.locks"
                            reduce_to         = "sum"
                            space_aggregation = "sum"
                            time_aggregation  = "sum"
                          },
                        ]
                        disabled = false
                        filter = {
                          expression = "k8s.cluster.name in $k8s.cluster.name"
                        }
                        functions = [
                        ]
                        group_by = [
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "mode"
                          },
                        ]
                        having = {
                        }
                        legend = "{{mode}}"
                        name   = "A"
                        order = [
                        ]
                        signal        = "metrics"
                      }
                    }
                  }
                }
              }
            },
          ]
        }
      }
      "7b74bb10-54eb-4f6c-97ce-16b28b629b41" = {
        kind = "Panel"
        spec = {
          display = {
            name = "Connections Total"
          }
          links = [
          ]
          plugin = {
            time_series_panel = {
              kind = "signoz/TimeSeriesPanel"
              spec = {
                axes = {
                  is_log_scale = false
                  soft_max     = 0
                  soft_min     = 0
                }
                chart_appearance = {
                  fill_mode          = "none"
                  line_interpolation = "spline"
                  line_style         = "solid"
                  show_points        = false
                  span_gaps = {
                    fill_only_below = false
                  }
                }
                formatting = {
                  decimal_precision = "2"
                  unit              = "none"
                }
                legend = {
                  mode     = "list"
                  position = "bottom"
                }
                visualization = {
                  fill_spans      = false
                  time_preference = "global_time"
                }
              }
            }
          }
          queries = [
            {
              kind = "time_series"
              spec = {
                plugin = {
                  composite_query = {
                    kind = "signoz/CompositeQuery"
                    spec = {
                      queries = [
                        {
                          builder_query = {
                            spec = {
                              metrics = {
                                aggregations = [
                                  {
                                    metric_name       = "postgresql.backends"
                                    reduce_to         = "sum"
                                    space_aggregation = "sum"
                                    time_aggregation  = "max"
                                  },
                                ]
                                disabled = false
                                filter = {
                                  expression = "k8s.cluster.name in $k8s.cluster.name AND postgresql.database.name IN $postgresql.database.name"
                                }
                                functions = [
                                ]
                                group_by = [
                                ]
                                having = {
                                }
                                legend = "current"
                                name   = "A"
                                order = [
                                ]
                                signal        = "metrics"
                              }
                            }
                            type = "builder_query"
                          }
                        },
                        {
                          builder_query = {
                            spec = {
                              metrics = {
                                aggregations = [
                                  {
                                    metric_name       = "postgresql.connection.max"
                                    reduce_to         = "sum"
                                    space_aggregation = "sum"
                                    time_aggregation  = "latest"
                                  },
                                ]
                                disabled = false
                                filter = {
                                  expression = "k8s.cluster.name in $k8s.cluster.name AND postgresql.database.name IN $postgresql.database.name"
                                }
                                functions = [
                                ]
                                group_by = [
                                ]
                                having = {
                                }
                                legend = "current"
                                name   = "B"
                                order = [
                                ]
                                signal        = "metrics"
                              }
                            }
                            type = "builder_query"
                          }
                        },
                      ]
                    }
                  }
                }
              }
            },
          ]
        }
      }
      "8638a199-20a0-4255-b0a2-3b1ba06c485b" = {
        kind = "Panel"
        spec = {
          display = {
            name = "Connections per db"
          }
          links = [
          ]
          plugin = {
            time_series_panel = {
              kind = "signoz/TimeSeriesPanel"
              spec = {
                axes = {
                  is_log_scale = false
                  soft_max     = 0
                  soft_min     = 0
                }
                chart_appearance = {
                  fill_mode          = "none"
                  line_interpolation = "spline"
                  line_style         = "solid"
                  show_points        = false
                  span_gaps = {
                    fill_only_below = false
                  }
                }
                formatting = {
                  decimal_precision = "2"
                  unit              = "none"
                }
                legend = {
                  mode     = "list"
                  position = "bottom"
                }
                visualization = {
                  fill_spans      = false
                  time_preference = "global_time"
                }
              }
            }
          }
          queries = [
            {
              kind = "time_series"
              spec = {
                name = "A"
                plugin = {
                  builder_query = {
                    kind = "signoz/BuilderQuery"
                    spec = {
                      metrics = {
                        aggregations = [
                          {
                            metric_name       = "postgresql.backends"
                            reduce_to         = "sum"
                            space_aggregation = "avg"
                            time_aggregation  = "max"
                          },
                        ]
                        disabled = false
                        filter = {
                          expression = "k8s.cluster.name in $k8s.cluster.name AND postgresql.database.name IN $postgresql.database.name"
                        }
                        functions = [
                        ]
                        group_by = [
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "postgresql.database.name"
                          },
                        ]
                        having = {
                        }
                        legend = "{{postgresql.database.name}}"
                        name   = "A"
                        order = [
                        ]
                        signal        = "metrics"
                      }
                    }
                  }
                }
              }
            },
          ]
        }
      }
      "9552123d-6265-48a7-8624-3f4a3fc3c9c0" = {
        kind = "Panel"
        spec = {
          display = {
            name = "Table stats"
          }
          links = [
          ]
          plugin = {
            table_panel = {
              kind = "signoz/TablePanel"
              spec = {
                formatting = {
                  column_units = {
                    A = ""
                    B = ""
                    C = ""
                    D = ""
                  }
                  decimal_precision = "2"
                }
                visualization = {
                  time_preference = "global_time"
                }
              }
            }
          }
          queries = [
            {
              kind = "scalar"
              spec = {
                plugin = {
                  composite_query = {
                    kind = "signoz/CompositeQuery"
                    spec = {
                      queries = [
                        {
                          builder_query = {
                            spec = {
                              metrics = {
                                aggregations = [
                                  {
                                    metric_name       = "postgresql.rows"
                                    reduce_to         = "avg"
                                    space_aggregation = "avg"
                                    time_aggregation  = "avg"
                                  },
                                ]
                                disabled = false
                                filter = {
                                  expression = "k8s.cluster.name in $k8s.cluster.name AND postgresql.database.name IN $postgresql.database.name AND postgresql.table.name IN $postgresql.table.name AND state = 'dead'"
                                }
                                functions = [
                                ]
                                group_by = [
                                  {
                                    field_context   = "attribute"
                                    field_data_type = "string"
                                    name            = "postgresql.database.name"
                                  },
                                  {
                                    field_context   = "attribute"
                                    field_data_type = "string"
                                    name            = "postgresql.table.name"
                                  },
                                ]
                                having = {
                                }
                                legend = "Dead rows"
                                name   = "A"
                                order = [
                                ]
                                signal        = "metrics"
                              }
                            }
                            type = "builder_query"
                          }
                        },
                        {
                          builder_query = {
                            spec = {
                              metrics = {
                                aggregations = [
                                  {
                                    metric_name       = "postgresql.rows"
                                    reduce_to         = "avg"
                                    space_aggregation = "avg"
                                    time_aggregation  = "avg"
                                  },
                                ]
                                disabled = false
                                filter = {
                                  expression = "k8s.cluster.name in $k8s.cluster.name AND postgresql.database.name IN $postgresql.database.name AND postgresql.table.name IN $postgresql.table.name AND state = 'live'"
                                }
                                functions = [
                                ]
                                group_by = [
                                  {
                                    field_context   = "attribute"
                                    field_data_type = "string"
                                    name            = "postgresql.database.name"
                                  },
                                  {
                                    field_context   = "attribute"
                                    field_data_type = "string"
                                    name            = "postgresql.table.name"
                                  },
                                ]
                                having = {
                                }
                                legend = "Live rows"
                                name   = "B"
                                order = [
                                ]
                                signal        = "metrics"
                              }
                            }
                            type = "builder_query"
                          }
                        },
                        {
                          builder_query = {
                            spec = {
                              metrics = {
                                aggregations = [
                                  {
                                    metric_name       = "postgresql.index.scans"
                                    reduce_to         = "sum"
                                    space_aggregation = "sum"
                                    time_aggregation  = "rate"
                                  },
                                ]
                                disabled = false
                                filter = {
                                  expression = "k8s.cluster.name in $k8s.cluster.name AND postgresql.database.name IN $postgresql.database.name AND postgresql.table.name IN $postgresql.table.name"
                                }
                                functions = [
                                ]
                                group_by = [
                                  {
                                    field_context   = "attribute"
                                    field_data_type = "string"
                                    name            = "postgresql.database.name"
                                  },
                                  {
                                    field_context   = "attribute"
                                    field_data_type = "string"
                                    name            = "postgresql.table.name"
                                  },
                                ]
                                having = {
                                }
                                legend = "Index scans"
                                name   = "C"
                                order = [
                                ]
                                signal        = "metrics"
                              }
                            }
                            type = "builder_query"
                          }
                        },
                        {
                          builder_query = {
                            spec = {
                              metrics = {
                                aggregations = [
                                  {
                                    metric_name       = "postgresql.table.size"
                                    reduce_to         = "avg"
                                    space_aggregation = "avg"
                                    time_aggregation  = "avg"
                                  },
                                ]
                                disabled = false
                                filter = {
                                  expression = "k8s.cluster.name in $k8s.cluster.name AND postgresql.database.name IN $postgresql.database.name AND postgresql.table.name IN $postgresql.table.name"
                                }
                                functions = [
                                ]
                                group_by = [
                                  {
                                    field_context   = "attribute"
                                    field_data_type = "string"
                                    name            = "postgresql.database.name"
                                  },
                                  {
                                    field_context   = "attribute"
                                    field_data_type = "string"
                                    name            = "postgresql.table.name"
                                  },
                                ]
                                having = {
                                }
                                legend = "Table size"
                                name   = "D"
                                order = [
                                ]
                                signal        = "metrics"
                              }
                            }
                            type = "builder_query"
                          }
                        },
                      ]
                    }
                  }
                }
              }
            },
          ]
        }
      }
      bada7864-1d23-4d49-a868-c6b8a93c738f = {
        kind = "Panel"
        spec = {
          display = {
            name = "Operation by database"
          }
          links = [
          ]
          plugin = {
            table_panel = {
              kind = "signoz/TablePanel"
              spec = {
                formatting = {
                  column_units = {
                    A = ""
                    B = ""
                    C = ""
                  }
                  decimal_precision = "2"
                }
                visualization = {
                  time_preference = "global_time"
                }
              }
            }
          }
          queries = [
            {
              kind = "scalar"
              spec = {
                plugin = {
                  composite_query = {
                    kind = "signoz/CompositeQuery"
                    spec = {
                      queries = [
                        {
                          builder_query = {
                            spec = {
                              metrics = {
                                aggregations = [
                                  {
                                    metric_name       = "postgresql.operations"
                                    reduce_to         = "avg"
                                    space_aggregation = "avg"
                                    time_aggregation  = "avg"
                                  },
                                ]
                                disabled = false
                                filter = {
                                  expression = "k8s.cluster.name in $k8s.cluster.name AND postgresql.database.name IN $postgresql.database.name AND operation = 'ins'"
                                }
                                functions = [
                                ]
                                group_by = [
                                  {
                                    field_context   = "attribute"
                                    field_data_type = "string"
                                    name            = "postgresql.database.name"
                                  },
                                  {
                                    field_context   = "attribute"
                                    field_data_type = "string"
                                    name            = "postgresql.table.name"
                                  },
                                ]
                                having = {
                                }
                                legend = "Inserted"
                                name   = "A"
                                order = [
                                ]
                                signal        = "metrics"
                              }
                            }
                            type = "builder_query"
                          }
                        },
                        {
                          builder_query = {
                            spec = {
                              metrics = {
                                aggregations = [
                                  {
                                    metric_name       = "postgresql.operations"
                                    reduce_to         = "avg"
                                    space_aggregation = "avg"
                                    time_aggregation  = "avg"
                                  },
                                ]
                                disabled = false
                                filter = {
                                  expression = "k8s.cluster.name in $k8s.cluster.name AND postgresql.database.name IN $postgresql.database.name AND operation = 'upd'"
                                }
                                functions = [
                                ]
                                group_by = [
                                  {
                                    field_context   = "attribute"
                                    field_data_type = "string"
                                    name            = "postgresql.database.name"
                                  },
                                  {
                                    field_context   = "attribute"
                                    field_data_type = "string"
                                    name            = "postgresql.table.name"
                                  },
                                ]
                                having = {
                                }
                                legend = "Updated"
                                name   = "B"
                                order = [
                                ]
                                signal        = "metrics"
                              }
                            }
                            type = "builder_query"
                          }
                        },
                        {
                          builder_query = {
                            spec = {
                              metrics = {
                                aggregations = [
                                  {
                                    metric_name       = "postgresql.operations"
                                    reduce_to         = "avg"
                                    space_aggregation = "avg"
                                    time_aggregation  = "avg"
                                  },
                                ]
                                disabled = false
                                filter = {
                                  expression = "k8s.cluster.name in $k8s.cluster.name AND postgresql.database.name IN $postgresql.database.name AND operation = 'del'"
                                }
                                functions = [
                                ]
                                group_by = [
                                  {
                                    field_context   = "attribute"
                                    field_data_type = "string"
                                    name            = "postgresql.database.name"
                                  },
                                  {
                                    field_context   = "attribute"
                                    field_data_type = "string"
                                    name            = "postgresql.table.name"
                                  },
                                ]
                                having = {
                                }
                                legend = "Deleted"
                                name   = "C"
                                order = [
                                ]
                                signal        = "metrics"
                              }
                            }
                            type = "builder_query"
                          }
                        },
                      ]
                    }
                  }
                }
              }
            },
          ]
        }
      }
      d7838815-4f5b-4454-86fd-f658b201f3a9 = {
        kind = "Panel"
        spec = {
          display = {
            name = "Index scans by index"
          }
          links = [
          ]
          plugin = {
            time_series_panel = {
              kind = "signoz/TimeSeriesPanel"
              spec = {
                axes = {
                  is_log_scale = false
                  soft_max     = 0
                  soft_min     = 0
                }
                chart_appearance = {
                  fill_mode          = "none"
                  line_interpolation = "spline"
                  line_style         = "solid"
                  show_points        = false
                  span_gaps = {
                    fill_only_below = false
                  }
                }
                formatting = {
                  decimal_precision = "2"
                  unit              = "none"
                }
                legend = {
                  mode     = "list"
                  position = "bottom"
                }
                visualization = {
                  fill_spans      = false
                  time_preference = "global_time"
                }
              }
            }
          }
          queries = [
            {
              kind = "time_series"
              spec = {
                name = "A"
                plugin = {
                  builder_query = {
                    kind = "signoz/BuilderQuery"
                    spec = {
                      metrics = {
                        aggregations = [
                          {
                            metric_name       = "postgresql.index.scans"
                            reduce_to         = "sum"
                            space_aggregation = "sum"
                            time_aggregation  = "rate"
                          },
                        ]
                        disabled = false
                        filter = {
                          expression = "k8s.cluster.name in $k8s.cluster.name AND postgresql.database.name IN $postgresql.database.name AND postgresql.table.name IN $postgresql.table.name"
                        }
                        functions = [
                        ]
                        group_by = [
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "postgresql.index.name"
                          },
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "postgresql.database.name"
                          },
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "postgresql.table.name"
                          },
                        ]
                        having = {
                        }
                        legend = "{{postgresql.database.name}}-{{postgresql.table.name}}-{{postgresql.index.name}}"
                        name   = "A"
                        order = [
                        ]
                        signal        = "metrics"
                      }
                    }
                  }
                }
              }
            },
          ]
        }
      }
      e9341e70-ccb3-47fc-af95-56ba8942c4f2 = {
        kind = "Panel"
        spec = {
          display = {
            name = "Deadlocks count"
          }
          links = [
          ]
          plugin = {
            time_series_panel = {
              kind = "signoz/TimeSeriesPanel"
              spec = {
                axes = {
                  is_log_scale = false
                  soft_max     = 0
                  soft_min     = 0
                }
                chart_appearance = {
                  fill_mode          = "none"
                  line_interpolation = "spline"
                  line_style         = "solid"
                  show_points        = false
                  span_gaps = {
                    fill_only_below = false
                  }
                }
                formatting = {
                  decimal_precision = "2"
                  unit              = "none"
                }
                legend = {
                  mode     = "list"
                  position = "bottom"
                }
                visualization = {
                  fill_spans      = false
                  time_preference = "global_time"
                }
              }
            }
          }
          queries = [
            {
              kind = "time_series"
              spec = {
                name = "A"
                plugin = {
                  builder_query = {
                    kind = "signoz/BuilderQuery"
                    spec = {
                      metrics = {
                        aggregations = [
                          {
                            metric_name       = "postgresql.deadlocks"
                            reduce_to         = "sum"
                            space_aggregation = "sum"
                            time_aggregation  = "rate"
                          },
                        ]
                        disabled = false
                        filter = {
                          expression = "k8s.cluster.name IN $k8s.cluster.name AND postgresql.database.name IN $postgresql.database.name"
                        }
                        functions = [
                        ]
                        group_by = [
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "postgresql.database.name"
                          },
                        ]
                        having = {
                        }
                        legend = "{{postgresql.database.name}}"
                        name   = "A"
                        order = [
                        ]
                        signal        = "metrics"
                      }
                    }
                  }
                }
              }
            },
          ]
        }
      }
      f9a6f683-7455-4643-acc8-467cc5ea52cf = {
        kind = "Panel"
        spec = {
          display = {
            name = "Dead rows"
          }
          links = [
          ]
          plugin = {
            time_series_panel = {
              kind = "signoz/TimeSeriesPanel"
              spec = {
                axes = {
                  is_log_scale = false
                  soft_max     = 0
                  soft_min     = 0
                }
                chart_appearance = {
                  fill_mode          = "none"
                  line_interpolation = "spline"
                  line_style         = "solid"
                  show_points        = false
                  span_gaps = {
                    fill_only_below = false
                  }
                }
                formatting = {
                  decimal_precision = "2"
                  unit              = "none"
                }
                legend = {
                  mode     = "list"
                  position = "bottom"
                }
                visualization = {
                  fill_spans      = false
                  time_preference = "global_time"
                }
              }
            }
          }
          queries = [
            {
              kind = "time_series"
              spec = {
                name = "A"
                plugin = {
                  builder_query = {
                    kind = "signoz/BuilderQuery"
                    spec = {
                      metrics = {
                        aggregations = [
                          {
                            metric_name       = "postgresql.rows"
                            reduce_to         = "sum"
                            space_aggregation = "sum"
                            time_aggregation  = "sum"
                          },
                        ]
                        disabled = false
                        filter = {
                          expression = "k8s.cluster.name in $k8s.cluster.name AND postgresql.database.name IN $postgresql.database.name AND postgresql.table.name IN $postgresql.table.name AND state = 'dead'"
                        }
                        functions = [
                        ]
                        group_by = [
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "postgresql.database.name"
                          },
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "postgresql.table.name"
                          },
                        ]
                        having = {
                        }
                        legend = "{{postgresql.database.name}}-{{postgresql.table.name}}"
                        name   = "A"
                        order = [
                        ]
                        signal        = "metrics"
                      }
                    }
                  }
                }
              }
            },
          ]
        }
      }
      fa941c00-ce19-49cc-baf2-c38598767dee = {
        kind = "Panel"
        spec = {
          display = {
            description = "The average number of db update operations."
            name        = "Updates"
          }
          links = [
          ]
          plugin = {
            time_series_panel = {
              kind = "signoz/TimeSeriesPanel"
              spec = {
                axes = {
                  is_log_scale = false
                  soft_max     = 0
                  soft_min     = 0
                }
                chart_appearance = {
                  fill_mode          = "none"
                  line_interpolation = "spline"
                  line_style         = "solid"
                  show_points        = false
                  span_gaps = {
                    fill_only_below = false
                  }
                }
                formatting = {
                  decimal_precision = "2"
                  unit              = "none"
                }
                legend = {
                  mode     = "list"
                  position = "bottom"
                }
                visualization = {
                  fill_spans      = false
                  time_preference = "global_time"
                }
              }
            }
          }
          queries = [
            {
              kind = "time_series"
              spec = {
                name = "A"
                plugin = {
                  builder_query = {
                    kind = "signoz/BuilderQuery"
                    spec = {
                      metrics = {
                        aggregations = [
                          {
                            metric_name       = "postgresql.operations"
                            reduce_to         = "sum"
                            space_aggregation = "avg"
                            time_aggregation  = "avg"
                          },
                        ]
                        disabled = false
                        filter = {
                          expression = "k8s.cluster.name in $k8s.cluster.name AND postgresql.database.name IN $postgresql.database.name AND operation = 'upd'"
                        }
                        functions = [
                        ]
                        group_by = [
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "postgresql.database.name"
                          },
                        ]
                        having = {
                        }
                        legend = "{{postgresql.database.name}}"
                        name   = "A"
                        order = [
                        ]
                        signal        = "metrics"
                      }
                    }
                  }
                }
              }
            },
          ]
        }
      }
    }
    variables = [
      {
        list_variable = {
          kind = "ListVariable"
          spec = {
            allow_all_value = false
            allow_multiple  = false
            default_value   = "\"k8s.bud.studio\""
            display = {
              description = "The k8s.cluster.name"
              name        = "k8s.cluster.name"
            }
            name = "k8s.cluster.name"
            plugin = {
              dynamic_variable = {
                kind = "signoz/DynamicVariable"
                spec = {
                  name   = "k8s.cluster.name"
                  signal = "all"
                }
              }
            }
            sort = "none"
          }
        }
      },
      {
        list_variable = {
          kind = "ListVariable"
          spec = {
            allow_all_value = true
            allow_multiple  = true
            display = {
              description = "List of databases"
              name        = "postgresql.database.name"
            }
            name = "postgresql.database.name"
            plugin = {
              dynamic_variable = {
                kind = "signoz/DynamicVariable"
                spec = {
                  name   = "postgresql.database.name"
                  signal = "all"
                }
              }
            }
            sort = "none"
          }
        }
      },
      {
        list_variable = {
          kind = "ListVariable"
          spec = {
            allow_all_value = true
            allow_multiple  = true
            display = {
              description = "List of tables"
              name        = "postgresql.table.name"
            }
            name = "postgresql.table.name"
            plugin = {
              dynamic_variable = {
                kind = "signoz/DynamicVariable"
                spec = {
                  name   = "postgresql.table.name"
                  signal = "all"
                }
              }
            }
            sort = "alphabetical-asc"
          }
        }
      },
    ]
  }
  tags = [
    {
      key   = "tag"
      value = "postgres"
    },
    {
      key   = "tag"
      value = "database"
    },
  ]
}

resource "signoz_dashboard" "k8s_node_metrics_detailed" {
  name           = "kubernetes-node-metrics-detailed-mlerpvvd"
  schema_version = "v6"
  spec = {
    display = {
      name = "Kubernetes Node Metrics - Detailed"
    }
    layouts = [
      {
        grid = {
          kind = "Grid"
          spec = {
            items = [
              {
                content = {
                  ref = "#/spec/panels/c5f29b09-8a63-44ba-825f-db91a3c79a54"
                }
                height = 8
                width  = 6
                x      = 0
                y      = 0
              },
              {
                content = {
                  ref = "#/spec/panels/f5174a53-c201-4e17-aff7-33b1402b0d7b"
                }
                height = 8
                width  = 6
                x      = 6
                y      = 0
              },
              {
                content = {
                  ref = "#/spec/panels/4b9a4513-d7c8-4217-8d76-0714d96432e7"
                }
                height = 7
                width  = 12
                x      = 0
                y      = 8
              },
              {
                content = {
                  ref = "#/spec/panels/9d0f96dc-d744-4baa-9910-ac1aef63cc34"
                }
                height = 7
                width  = 6
                x      = 0
                y      = 15
              },
              {
                content = {
                  ref = "#/spec/panels/960ff49f-d73b-49c2-ab4a-69df1e1abc51"
                }
                height = 7
                width  = 6
                x      = 6
                y      = 15
              },
              {
                content = {
                  ref = "#/spec/panels/1c841c0b-be32-43ec-8bcb-bfd8a87edeef"
                }
                height = 7
                width  = 6
                x      = 0
                y      = 22
              },
              {
                content = {
                  ref = "#/spec/panels/75fdac11-19dd-472f-a155-63e4682b88df"
                }
                height = 7
                width  = 6
                x      = 6
                y      = 22
              },
              {
                content = {
                  ref = "#/spec/panels/2e864710-b418-4133-b248-2fa047e37fe3"
                }
                height = 7
                width  = 6
                x      = 0
                y      = 29
              },
              {
                content = {
                  ref = "#/spec/panels/1f8965fb-5ad1-4679-9d28-9bd31d4e4cac"
                }
                height = 7
                width  = 6
                x      = 6
                y      = 29
              },
              {
                content = {
                  ref = "#/spec/panels/8722151e-7690-4152-98c3-f2cc0f741d50"
                }
                height = 7
                width  = 6
                x      = 0
                y      = 36
              },
              {
                content = {
                  ref = "#/spec/panels/230f3562-5ac1-4fec-946d-0dd21057f4b3"
                }
                height = 7
                width  = 6
                x      = 6
                y      = 36
              },
              {
                content = {
                  ref = "#/spec/panels/7403ba8f-36bf-4c31-8b91-a447a36eeca0"
                }
                height = 7
                width  = 12
                x      = 0
                y      = 43
              },
            ]
          }
        }
      },
    ]
    links = [
    ]
    panels = {
      "1c841c0b-be32-43ec-8bcb-bfd8a87edeef" = {
        kind = "Panel"
        spec = {
          display = {
            name = "Node memory available"
          }
          links = [
          ]
          plugin = {
            time_series_panel = {
              kind = "signoz/TimeSeriesPanel"
              spec = {
                axes = {
                  is_log_scale = false
                  soft_max     = 0
                  soft_min     = 0
                }
                chart_appearance = {
                  fill_mode          = "none"
                  line_interpolation = "spline"
                  line_style         = "solid"
                  show_points        = false
                  span_gaps = {
                    fill_only_below = false
                  }
                }
                formatting = {
                  decimal_precision = "2"
                  unit              = "bytes"
                }
                legend = {
                  mode     = "list"
                  position = "bottom"
                }
                visualization = {
                  fill_spans      = false
                  time_preference = "global_time"
                }
              }
            }
          }
          queries = [
            {
              kind = "time_series"
              spec = {
                name = "A"
                plugin = {
                  builder_query = {
                    kind = "signoz/BuilderQuery"
                    spec = {
                      metrics = {
                        aggregations = [
                          {
                            metric_name       = "k8s.node.memory.available"
                            reduce_to         = "sum"
                            space_aggregation = "sum"
                            time_aggregation  = "avg"
                          },
                        ]
                        disabled = false
                        filter = {
                          expression = "k8s.cluster.name in $k8s.cluster.name k8s.node.name in $k8s.node.name"
                        }
                        functions = [
                        ]
                        group_by = [
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "k8s.node.name"
                          },
                        ]
                        having = {
                        }
                        legend = "{{k8s.node.name}}"
                        name   = "A"
                        order = [
                        ]
                        signal        = "metrics"
                      }
                    }
                  }
                }
              }
            },
          ]
        }
      }
      "1f8965fb-5ad1-4679-9d28-9bd31d4e4cac" = {
        kind = "Panel"
        spec = {
          display = {
            name = "Node network errors"
          }
          links = [
          ]
          plugin = {
            time_series_panel = {
              kind = "signoz/TimeSeriesPanel"
              spec = {
                axes = {
                  is_log_scale = false
                  soft_max     = 0
                  soft_min     = 0
                }
                chart_appearance = {
                  fill_mode          = "none"
                  line_interpolation = "spline"
                  line_style         = "solid"
                  show_points        = false
                  span_gaps = {
                    fill_only_below = false
                  }
                }
                formatting = {
                  decimal_precision = "2"
                  unit              = "none"
                }
                legend = {
                  mode     = "list"
                  position = "bottom"
                }
                visualization = {
                  fill_spans      = false
                  time_preference = "global_time"
                }
              }
            }
          }
          queries = [
            {
              kind = "time_series"
              spec = {
                name = "A"
                plugin = {
                  builder_query = {
                    kind = "signoz/BuilderQuery"
                    spec = {
                      metrics = {
                        aggregations = [
                          {
                            metric_name       = "k8s.node.network.errors"
                            reduce_to         = "sum"
                            space_aggregation = "sum"
                            time_aggregation  = "rate"
                          },
                        ]
                        disabled = false
                        filter = {
                          expression = "k8s.cluster.name in $k8s.cluster.name AND k8s.node.name in $k8s.node.name"
                        }
                        functions = [
                        ]
                        group_by = [
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "k8s.node.name"
                          },
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "interface"
                          },
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "direction"
                          },
                        ]
                        having = {
                        }
                        legend = "{{k8s.node.name}}-{{interface}}-{{direction}}"
                        name   = "A"
                        order = [
                        ]
                        signal        = "metrics"
                      }
                    }
                  }
                }
              }
            },
          ]
        }
      }
      "230f3562-5ac1-4fec-946d-0dd21057f4b3" = {
        kind = "Panel"
        spec = {
          display = {
            name = "Node filesystem available"
          }
          links = [
          ]
          plugin = {
            time_series_panel = {
              kind = "signoz/TimeSeriesPanel"
              spec = {
                axes = {
                  is_log_scale = false
                  soft_max     = 0
                  soft_min     = 0
                }
                chart_appearance = {
                  fill_mode          = "none"
                  line_interpolation = "spline"
                  line_style         = "solid"
                  show_points        = false
                  span_gaps = {
                    fill_only_below = false
                  }
                }
                formatting = {
                  decimal_precision = "2"
                  unit              = "bytes"
                }
                legend = {
                  mode     = "list"
                  position = "bottom"
                }
                visualization = {
                  fill_spans      = false
                  time_preference = "global_time"
                }
              }
            }
          }
          queries = [
            {
              kind = "time_series"
              spec = {
                name = "A"
                plugin = {
                  builder_query = {
                    kind = "signoz/BuilderQuery"
                    spec = {
                      metrics = {
                        aggregations = [
                          {
                            metric_name       = "k8s.node.filesystem.available"
                            reduce_to         = "sum"
                            space_aggregation = "sum"
                            time_aggregation  = "avg"
                          },
                        ]
                        disabled = false
                        filter = {
                          expression = "(k8s.cluster.name = $k8s.cluster.name AND k8s.node.name IN $k8s.node.name )"
                        }
                        functions = [
                        ]
                        group_by = [
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "k8s.node.name"
                          },
                        ]
                        having = {
                        }
                        legend = "{{k8s.node.name}}"
                        name   = "A"
                        order = [
                        ]
                        signal        = "metrics"
                      }
                    }
                  }
                }
              }
            },
          ]
        }
      }
      "2e864710-b418-4133-b248-2fa047e37fe3" = {
        kind = "Panel"
        spec = {
          display = {
            name = "Node network io"
          }
          links = [
          ]
          plugin = {
            time_series_panel = {
              kind = "signoz/TimeSeriesPanel"
              spec = {
                axes = {
                  is_log_scale = false
                  soft_max     = 0
                  soft_min     = 0
                }
                chart_appearance = {
                  fill_mode          = "none"
                  line_interpolation = "spline"
                  line_style         = "solid"
                  show_points        = false
                  span_gaps = {
                    fill_only_below = false
                  }
                }
                formatting = {
                  decimal_precision = "2"
                  unit              = "bytes"
                }
                legend = {
                  mode     = "list"
                  position = "bottom"
                }
                visualization = {
                  fill_spans      = false
                  time_preference = "global_time"
                }
              }
            }
          }
          queries = [
            {
              kind = "time_series"
              spec = {
                name = "A"
                plugin = {
                  builder_query = {
                    kind = "signoz/BuilderQuery"
                    spec = {
                      metrics = {
                        aggregations = [
                          {
                            metric_name       = "k8s.node.network.io"
                            reduce_to         = "sum"
                            space_aggregation = "sum"
                            time_aggregation  = "rate"
                          },
                        ]
                        disabled = false
                        filter = {
                          expression = "k8s.cluster.name in $k8s.cluster.name AND k8s.node.name in $k8s.node.name"
                        }
                        functions = [
                        ]
                        group_by = [
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "direction"
                          },
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "interface"
                          },
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "k8s.node.name"
                          },
                        ]
                        having = {
                        }
                        legend = "{{k8s.node.name}}-{{interface}}-{{direction}}"
                        name   = "A"
                        order = [
                        ]
                        signal        = "metrics"
                      }
                    }
                  }
                }
              }
            },
          ]
        }
      }
      "4b9a4513-d7c8-4217-8d76-0714d96432e7" = {
        kind = "Panel"
        spec = {
          display = {
            name = "Memory usage"
          }
          links = [
          ]
          plugin = {
            table_panel = {
              kind = "signoz/TablePanel"
              spec = {
                formatting = {
                  column_units = {
                    A = "bytes"
                    B = "bytes"
                    C = "bytes"
                    D = "bytes"
                    E = "bytes"
                  }
                  decimal_precision = "2"
                }
                visualization = {
                  time_preference = "global_time"
                }
              }
            }
          }
          queries = [
            {
              kind = "scalar"
              spec = {
                plugin = {
                  composite_query = {
                    kind = "signoz/CompositeQuery"
                    spec = {
                      queries = [
                        {
                          builder_query = {
                            spec = {
                              metrics = {
                                aggregations = [
                                  {
                                    metric_name       = "k8s.node.memory.usage"
                                    reduce_to         = "avg"
                                    space_aggregation = "sum"
                                    time_aggregation  = "avg"
                                  },
                                ]
                                disabled = false
                                filter = {
                                  expression = "k8s.cluster.name in $k8s.cluster.name k8s.node.name in $k8s.node.name"
                                }
                                functions = [
                                ]
                                group_by = [
                                  {
                                    field_context   = "attribute"
                                    field_data_type = "string"
                                    name            = "k8s.node.name"
                                  },
                                ]
                                having = {
                                }
                                legend = "used"
                                name   = "A"
                                order = [
                                ]
                                signal        = "metrics"
                              }
                            }
                            type = "builder_query"
                          }
                        },
                        {
                          builder_query = {
                            spec = {
                              metrics = {
                                aggregations = [
                                  {
                                    metric_name       = "k8s.node.allocatable_memory"
                                    reduce_to         = "avg"
                                    space_aggregation = "sum"
                                    time_aggregation  = "avg"
                                  },
                                ]
                                disabled = false
                                filter = {
                                  expression = "k8s.cluster.name in $k8s.cluster.name k8s.node.name in $k8s.node.name"
                                }
                                functions = [
                                ]
                                group_by = [
                                  {
                                    field_context   = "attribute"
                                    field_data_type = "string"
                                    name            = "k8s.node.name"
                                  },
                                ]
                                having = {
                                }
                                legend = "allocatable"
                                name   = "B"
                                order = [
                                ]
                                signal        = "metrics"
                              }
                            }
                            type = "builder_query"
                          }
                        },
                        {
                          builder_query = {
                            spec = {
                              metrics = {
                                aggregations = [
                                  {
                                    metric_name       = "k8s.node.memory.working_set"
                                    reduce_to         = "avg"
                                    space_aggregation = "sum"
                                    time_aggregation  = "avg"
                                  },
                                ]
                                disabled = false
                                filter = {
                                  expression = "k8s.cluster.name in $k8s.cluster.name k8s.node.name in $k8s.node.name"
                                }
                                functions = [
                                ]
                                group_by = [
                                  {
                                    field_context   = "attribute"
                                    field_data_type = "string"
                                    name            = "k8s.node.name"
                                  },
                                ]
                                having = {
                                }
                                legend = "working set"
                                name   = "C"
                                order = [
                                ]
                                signal        = "metrics"
                              }
                            }
                            type = "builder_query"
                          }
                        },
                        {
                          builder_query = {
                            spec = {
                              metrics = {
                                aggregations = [
                                  {
                                    metric_name       = "k8s.node.memory.rss"
                                    reduce_to         = "avg"
                                    space_aggregation = "sum"
                                    time_aggregation  = "avg"
                                  },
                                ]
                                disabled = false
                                filter = {
                                  expression = "k8s.cluster.name in $k8s.cluster.name k8s.node.name in $k8s.node.name"
                                }
                                functions = [
                                ]
                                group_by = [
                                  {
                                    field_context   = "attribute"
                                    field_data_type = "string"
                                    name            = "k8s.node.name"
                                  },
                                ]
                                having = {
                                }
                                legend = "rss"
                                name   = "D"
                                order = [
                                ]
                                signal        = "metrics"
                              }
                            }
                            type = "builder_query"
                          }
                        },
                        {
                          builder_query = {
                            spec = {
                              metrics = {
                                aggregations = [
                                  {
                                    metric_name       = "k8s.node.memory.available"
                                    reduce_to         = "avg"
                                    space_aggregation = "sum"
                                    time_aggregation  = "avg"
                                  },
                                ]
                                disabled = false
                                filter = {
                                  expression = "k8s.cluster.name in $k8s.cluster.name k8s.node.name in $k8s.node.name"
                                }
                                functions = [
                                ]
                                group_by = [
                                  {
                                    field_context   = "attribute"
                                    field_data_type = "string"
                                    name            = "k8s.node.name"
                                  },
                                ]
                                having = {
                                }
                                legend = "available"
                                name   = "E"
                                order = [
                                ]
                                signal        = "metrics"
                              }
                            }
                            type = "builder_query"
                          }
                        },
                      ]
                    }
                  }
                }
              }
            },
          ]
        }
      }
      "7403ba8f-36bf-4c31-8b91-a447a36eeca0" = {
        kind = "Panel"
        spec = {
          display = {
            name = "Node filesystem capacity"
          }
          links = [
          ]
          plugin = {
            table_panel = {
              kind = "signoz/TablePanel"
              spec = {
                formatting = {
                  column_units = {
                    A = "bytes"
                    B = "bytes"
                    C = "bytes"
                  }
                  decimal_precision = "2"
                }
                visualization = {
                  time_preference = "global_time"
                }
              }
            }
          }
          queries = [
            {
              kind = "scalar"
              spec = {
                plugin = {
                  composite_query = {
                    kind = "signoz/CompositeQuery"
                    spec = {
                      queries = [
                        {
                          builder_query = {
                            spec = {
                              metrics = {
                                aggregations = [
                                  {
                                    metric_name       = "k8s.node.filesystem.usage"
                                    reduce_to         = "avg"
                                    space_aggregation = "sum"
                                    time_aggregation  = "avg"
                                  },
                                ]
                                disabled = false
                                filter = {
                                  expression = "k8s.cluster.name = $k8s.cluster.name AND k8s.node.name in $k8s.node.name"
                                }
                                functions = [
                                ]
                                group_by = [
                                  {
                                    field_context   = "attribute"
                                    field_data_type = "string"
                                    name            = "k8s.node.name"
                                  },
                                ]
                                having = {
                                }
                                legend = "usage"
                                name   = "A"
                                order = [
                                ]
                                signal        = "metrics"
                              }
                            }
                            type = "builder_query"
                          }
                        },
                        {
                          builder_query = {
                            spec = {
                              metrics = {
                                aggregations = [
                                  {
                                    metric_name       = "k8s.node.filesystem.available"
                                    reduce_to         = "avg"
                                    space_aggregation = "sum"
                                    time_aggregation  = "avg"
                                  },
                                ]
                                disabled = false
                                filter = {
                                  expression = "k8s.cluster.name = $k8s.cluster.name AND k8s.node.name in $k8s.node.name"
                                }
                                functions = [
                                ]
                                group_by = [
                                  {
                                    field_context   = "attribute"
                                    field_data_type = "string"
                                    name            = "k8s.node.name"
                                  },
                                ]
                                having = {
                                }
                                legend = "available"
                                name   = "B"
                                order = [
                                ]
                                signal        = "metrics"
                              }
                            }
                            type = "builder_query"
                          }
                        },
                        {
                          builder_query = {
                            spec = {
                              metrics = {
                                aggregations = [
                                  {
                                    metric_name       = "k8s.node.filesystem.capacity"
                                    reduce_to         = "avg"
                                    space_aggregation = "sum"
                                    time_aggregation  = "avg"
                                  },
                                ]
                                disabled = false
                                filter = {
                                  expression = "k8s.cluster.name = $k8s.cluster.name AND k8s.node.name in $k8s.node.name"
                                }
                                functions = [
                                ]
                                group_by = [
                                  {
                                    field_context   = "attribute"
                                    field_data_type = "string"
                                    name            = "k8s.node.name"
                                  },
                                ]
                                having = {
                                }
                                legend = "capacity"
                                name   = "C"
                                order = [
                                ]
                                signal        = "metrics"
                              }
                            }
                            type = "builder_query"
                          }
                        },
                      ]
                    }
                  }
                }
              }
            },
          ]
        }
      }
      "75fdac11-19dd-472f-a155-63e4682b88df" = {
        kind = "Panel"
        spec = {
          display = {
            name = "Node memory usage"
          }
          links = [
          ]
          plugin = {
            time_series_panel = {
              kind = "signoz/TimeSeriesPanel"
              spec = {
                axes = {
                  is_log_scale = false
                  soft_max     = 0
                  soft_min     = 0
                }
                chart_appearance = {
                  fill_mode          = "none"
                  line_interpolation = "spline"
                  line_style         = "solid"
                  show_points        = false
                  span_gaps = {
                    fill_only_below = false
                  }
                }
                formatting = {
                  decimal_precision = "2"
                  unit              = "bytes"
                }
                legend = {
                  mode     = "list"
                  position = "bottom"
                }
                visualization = {
                  fill_spans      = false
                  time_preference = "global_time"
                }
              }
            }
          }
          queries = [
            {
              kind = "time_series"
              spec = {
                name = "A"
                plugin = {
                  builder_query = {
                    kind = "signoz/BuilderQuery"
                    spec = {
                      metrics = {
                        aggregations = [
                          {
                            metric_name       = "k8s.node.memory.usage"
                            reduce_to         = "sum"
                            space_aggregation = "sum"
                            time_aggregation  = "avg"
                          },
                        ]
                        disabled = false
                        filter = {
                          expression = "k8s.cluster.name in $k8s.cluster.name k8s.node.name in $k8s.node.name"
                        }
                        functions = [
                        ]
                        group_by = [
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "k8s.node.name"
                          },
                        ]
                        having = {
                        }
                        legend = "{{k8s.node.name}}"
                        name   = "A"
                        order = [
                        ]
                        signal        = "metrics"
                      }
                    }
                  }
                }
              }
            },
          ]
        }
      }
      "8722151e-7690-4152-98c3-f2cc0f741d50" = {
        kind = "Panel"
        spec = {
          display = {
            name = "Node filesystem usage"
          }
          links = [
          ]
          plugin = {
            time_series_panel = {
              kind = "signoz/TimeSeriesPanel"
              spec = {
                axes = {
                  is_log_scale = false
                  soft_max     = 0
                  soft_min     = 0
                }
                chart_appearance = {
                  fill_mode          = "none"
                  line_interpolation = "spline"
                  line_style         = "solid"
                  show_points        = false
                  span_gaps = {
                    fill_only_below = false
                  }
                }
                formatting = {
                  decimal_precision = "2"
                  unit              = "bytes"
                }
                legend = {
                  mode     = "list"
                  position = "bottom"
                }
                visualization = {
                  fill_spans      = false
                  time_preference = "global_time"
                }
              }
            }
          }
          queries = [
            {
              kind = "time_series"
              spec = {
                name = "A"
                plugin = {
                  builder_query = {
                    kind = "signoz/BuilderQuery"
                    spec = {
                      metrics = {
                        aggregations = [
                          {
                            metric_name       = "k8s.node.filesystem.usage"
                            reduce_to         = "sum"
                            space_aggregation = "sum"
                            time_aggregation  = "avg"
                          },
                        ]
                        disabled = false
                        filter = {
                          expression = "k8s.cluster.name = $k8s.cluster.name AND k8s.node.name IN k8s.node.name"
                        }
                        functions = [
                        ]
                        group_by = [
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "k8s.node.name"
                          },
                        ]
                        having = {
                        }
                        legend = "{{k8s.node.name}}"
                        name   = "A"
                        order = [
                        ]
                        signal        = "metrics"
                      }
                    }
                  }
                }
              }
            },
          ]
        }
      }
      "960ff49f-d73b-49c2-ab4a-69df1e1abc51" = {
        kind = "Panel"
        spec = {
          display = {
            name = "Node memory working set"
          }
          links = [
          ]
          plugin = {
            time_series_panel = {
              kind = "signoz/TimeSeriesPanel"
              spec = {
                axes = {
                  is_log_scale = false
                  soft_max     = 0
                  soft_min     = 0
                }
                chart_appearance = {
                  fill_mode          = "none"
                  line_interpolation = "spline"
                  line_style         = "solid"
                  show_points        = false
                  span_gaps = {
                    fill_only_below = false
                  }
                }
                formatting = {
                  decimal_precision = "2"
                  unit              = "bytes"
                }
                legend = {
                  mode     = "list"
                  position = "bottom"
                }
                visualization = {
                  fill_spans      = false
                  time_preference = "global_time"
                }
              }
            }
          }
          queries = [
            {
              kind = "time_series"
              spec = {
                name = "A"
                plugin = {
                  builder_query = {
                    kind = "signoz/BuilderQuery"
                    spec = {
                      metrics = {
                        aggregations = [
                          {
                            metric_name       = "k8s.node.memory.working_set"
                            reduce_to         = "sum"
                            space_aggregation = "sum"
                            time_aggregation  = "avg"
                          },
                        ]
                        disabled = false
                        filter = {
                          expression = "k8s.cluster.name in $k8s.cluster.name k8s.node.name in $k8s.node.name"
                        }
                        functions = [
                        ]
                        group_by = [
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "k8s.node.name"
                          },
                        ]
                        having = {
                        }
                        legend = "{{k8s.node.name}}"
                        name   = "A"
                        order = [
                        ]
                        signal        = "metrics"
                      }
                    }
                  }
                }
              }
            },
          ]
        }
      }
      "9d0f96dc-d744-4baa-9910-ac1aef63cc34" = {
        kind = "Panel"
        spec = {
          display = {
            name = "Node memory rss"
          }
          links = [
          ]
          plugin = {
            time_series_panel = {
              kind = "signoz/TimeSeriesPanel"
              spec = {
                axes = {
                  is_log_scale = false
                  soft_max     = 0
                  soft_min     = 0
                }
                chart_appearance = {
                  fill_mode          = "none"
                  line_interpolation = "spline"
                  line_style         = "solid"
                  show_points        = false
                  span_gaps = {
                    fill_only_below = false
                  }
                }
                formatting = {
                  decimal_precision = "2"
                  unit              = "bytes"
                }
                legend = {
                  mode     = "list"
                  position = "bottom"
                }
                visualization = {
                  fill_spans      = false
                  time_preference = "global_time"
                }
              }
            }
          }
          queries = [
            {
              kind = "time_series"
              spec = {
                name = "A"
                plugin = {
                  builder_query = {
                    kind = "signoz/BuilderQuery"
                    spec = {
                      metrics = {
                        aggregations = [
                          {
                            metric_name       = "k8s.node.memory.rss"
                            reduce_to         = "sum"
                            space_aggregation = "avg"
                            time_aggregation  = "sum"
                          },
                        ]
                        disabled = false
                        filter = {
                          expression = "k8s.cluster.name in $k8s.cluster.name k8s.node.name in $k8s.node.name"
                        }
                        functions = [
                        ]
                        group_by = [
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "k8s.node.name"
                          },
                        ]
                        having = {
                        }
                        legend = "{{k8s.node.name}}"
                        name   = "A"
                        order = [
                        ]
                        signal        = "metrics"
                      }
                    }
                  }
                }
              }
            },
          ]
        }
      }
      c5f29b09-8a63-44ba-825f-db91a3c79a54 = {
        kind = "Panel"
        spec = {
          display = {
            name = "Node CPU usage"
          }
          links = [
          ]
          plugin = {
            time_series_panel = {
              kind = "signoz/TimeSeriesPanel"
              spec = {
                axes = {
                  is_log_scale = false
                  soft_max     = 0
                  soft_min     = 0
                }
                chart_appearance = {
                  fill_mode          = "none"
                  line_interpolation = "spline"
                  line_style         = "solid"
                  show_points        = false
                  span_gaps = {
                    fill_only_below = false
                  }
                }
                formatting = {
                  decimal_precision = "2"
                  unit              = "none"
                }
                legend = {
                  mode     = "list"
                  position = "bottom"
                }
                visualization = {
                  fill_spans      = false
                  time_preference = "global_time"
                }
              }
            }
          }
          queries = [
            {
              kind = "time_series"
              spec = {
                name = "A"
                plugin = {
                  builder_query = {
                    kind = "signoz/BuilderQuery"
                    spec = {
                      metrics = {
                        aggregations = [
                          {
                            metric_name       = "k8s.node.cpu.usage"
                            reduce_to         = "avg"
                            space_aggregation = "avg"
                            time_aggregation  = "avg"
                          },
                        ]
                        disabled = false
                        filter = {
                          expression = "k8s.cluster.name in $k8s.cluster.name k8s.node.name in $k8s.node.name"
                        }
                        functions = [
                        ]
                        group_by = [
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "k8s.node.name"
                          },
                        ]
                        having = {
                        }
                        legend = "{{k8s.node.name}}"
                        name   = "A"
                        order = [
                        ]
                        signal        = "metrics"
                      }
                    }
                  }
                }
              }
            },
          ]
        }
      }
      f5174a53-c201-4e17-aff7-33b1402b0d7b = {
        kind = "Panel"
        spec = {
          display = {
            name = "Node CPU"
          }
          links = [
          ]
          plugin = {
            table_panel = {
              kind = "signoz/TablePanel"
              spec = {
                formatting = {
                  column_units = {
                    A = ""
                    B = ""
                  }
                  decimal_precision = "2"
                }
                visualization = {
                  time_preference = "global_time"
                }
              }
            }
          }
          queries = [
            {
              kind = "scalar"
              spec = {
                plugin = {
                  composite_query = {
                    kind = "signoz/CompositeQuery"
                    spec = {
                      queries = [
                        {
                          builder_query = {
                            spec = {
                              metrics = {
                                aggregations = [
                                  {
                                    metric_name       = "k8s.node.cpu.usage"
                                    reduce_to         = "avg"
                                    space_aggregation = "avg"
                                    time_aggregation  = "avg"
                                  },
                                ]
                                disabled = false
                                filter = {
                                  expression = "k8s.cluster.name in $k8s.cluster.name k8s.node.name in $k8s.node.name"
                                }
                                functions = [
                                ]
                                group_by = [
                                  {
                                    field_context   = "attribute"
                                    field_data_type = "string"
                                    name            = "k8s.node.name"
                                  },
                                ]
                                having = {
                                }
                                legend = "average cpu usage"
                                name   = "A"
                                order = [
                                ]
                                signal        = "metrics"
                              }
                            }
                            type = "builder_query"
                          }
                        },
                        {
                          builder_query = {
                            spec = {
                              metrics = {
                                aggregations = [
                                  {
                                    metric_name       = "k8s.node.allocatable_cpu"
                                    reduce_to         = "avg"
                                    space_aggregation = "sum"
                                    time_aggregation  = "avg"
                                  },
                                ]
                                disabled = false
                                filter = {
                                  expression = "k8s.cluster.name in $k8s.cluster.name k8s.node.name in $k8s.node.name"
                                }
                                functions = [
                                ]
                                group_by = [
                                  {
                                    field_context   = "attribute"
                                    field_data_type = "string"
                                    name            = "k8s.node.name"
                                  },
                                ]
                                having = {
                                }
                                legend = "allocatable"
                                name   = "B"
                                order = [
                                ]
                                signal        = "metrics"
                              }
                            }
                            type = "builder_query"
                          }
                        },
                      ]
                    }
                  }
                }
              }
            },
          ]
        }
      }
    }
    variables = [
      {
        list_variable = {
          kind = "ListVariable"
          spec = {
            allow_all_value = false
            allow_multiple  = false
            display = {
              description = "The k8s.cluster.name"
              name        = "k8s.cluster.name"
            }
            name = "k8s.cluster.name"
            plugin = {
              dynamic_variable = {
                kind = "signoz/DynamicVariable"
                spec = {
                  name   = "k8s.cluster.name"
                  signal = "all"
                }
              }
            }
            sort = "none"
          }
        }
      },
      {
        list_variable = {
          kind = "ListVariable"
          spec = {
            allow_all_value = true
            allow_multiple  = true
            display = {
              description = "The k8s node name"
              name        = "k8s.node.name"
            }
            name = "k8s.node.name"
            plugin = {
              dynamic_variable = {
                kind = "signoz/DynamicVariable"
                spec = {
                  name   = "k8s.node.name"
                  signal = "all"
                }
              }
            }
            sort = "alphabetical-asc"
          }
        }
      },
    ]
  }
  tags = [
    {
      key   = "tag"
      value = "node"
    },
    {
      key   = "tag"
      value = "k8s"
    },
    {
      key   = "tag"
      value = "kubelet"
    },
  ]
}

resource "signoz_dashboard" "clickhouse_overview" {
  name           = "clickhouse-overview-mvshubux"
  schema_version = "v6"
  spec = {
    display = {
      description = "This dashboard provides a high-level overview of Clickhouse Server."
      name        = "Clickhouse Overview"
    }
    layouts = [
      {
        grid = {
          kind = "Grid"
          spec = {
            items = [
              {
                content = {
                  ref = "#/spec/panels/a62fdaa8-9193-46c1-a951-8e3d5a6b1cf9"
                }
                height = 7
                width  = 6
                x      = 0
                y      = 0
              },
              {
                content = {
                  ref = "#/spec/panels/653248f0-9658-4be3-ba03-017d804e90c8"
                }
                height = 7
                width  = 6
                x      = 6
                y      = 0
              },
              {
                content = {
                  ref = "#/spec/panels/97a2c7bb-f135-412b-a006-167dcc1882c6"
                }
                height = 7
                width  = 6
                x      = 0
                y      = 7
              },
              {
                content = {
                  ref = "#/spec/panels/947053c4-b809-4241-9cb2-90e09868c2a9"
                }
                height = 7
                width  = 6
                x      = 6
                y      = 7
              },
              {
                content = {
                  ref = "#/spec/panels/1a1a3a6a-83d2-49db-aa4d-d6f166cc65f0"
                }
                height = 7
                width  = 6
                x      = 0
                y      = 14
              },
              {
                content = {
                  ref = "#/spec/panels/7f36d404-8915-4bfb-ac93-b69a9ea1428a"
                }
                height = 7
                width  = 6
                x      = 6
                y      = 14
              },
              {
                content = {
                  ref = "#/spec/panels/3b96004b-f356-4fc9-a7de-36af5eabad5d"
                }
                height = 7
                width  = 6
                x      = 0
                y      = 21
              },
              {
                content = {
                  ref = "#/spec/panels/581eb12e-8c92-4a8d-9800-0f72f350cfd1"
                }
                height = 7
                width  = 6
                x      = 6
                y      = 21
              },
              {
                content = {
                  ref = "#/spec/panels/8eb1e295-d5e8-4007-acb1-a9ec385d6f4d"
                }
                height = 7
                width  = 6
                x      = 0
                y      = 28
              },
              {
                content = {
                  ref = "#/spec/panels/be48f124-96d1-4327-ae10-6f2c1b81fe50"
                }
                height = 7
                width  = 6
                x      = 6
                y      = 28
              },
              {
                content = {
                  ref = "#/spec/panels/fcb693b5-6786-49e0-8007-4bc6009c70e2"
                }
                height = 7
                width  = 6
                x      = 0
                y      = 35
              },
              {
                content = {
                  ref = "#/spec/panels/486edfb2-02ce-45a3-ab89-06fce614edcf"
                }
                height = 7
                width  = 6
                x      = 6
                y      = 35
              },
            ]
          }
        }
      },
    ]
    links = [
    ]
    panels = {
      "1a1a3a6a-83d2-49db-aa4d-d6f166cc65f0" = {
        kind = "Panel"
        spec = {
          display = {
            name = "Failed Queries"
          }
          links = [
          ]
          plugin = {
            time_series_panel = {
              kind = "signoz/TimeSeriesPanel"
              spec = {
                axes = {
                  is_log_scale = false
                  soft_max     = 0
                  soft_min     = 0
                }
                chart_appearance = {
                  fill_mode          = "none"
                  line_interpolation = "spline"
                  line_style         = "solid"
                  show_points        = false
                  span_gaps = {
                    fill_only_below = false
                  }
                }
                formatting = {
                  decimal_precision = "2"
                  unit              = "cps"
                }
                legend = {
                  mode     = "list"
                  position = "bottom"
                }
                visualization = {
                  fill_spans      = false
                  time_preference = "global_time"
                }
              }
            }
          }
          queries = [
            {
              kind = "time_series"
              spec = {
                plugin = {
                  composite_query = {
                    kind = "signoz/CompositeQuery"
                    spec = {
                      queries = [
                        {
                          builder_query = {
                            spec = {
                              metrics = {
                                aggregations = [
                                  {
                                    metric_name       = "ClickHouseProfileEvents_FailedQuery"
                                    reduce_to         = "avg"
                                    space_aggregation = "sum"
                                    time_aggregation  = "rate"
                                  },
                                ]
                                disabled = false
                                filter = {
                                  expression = "host.name = $host.name k8s.cluster.name in $k8s.cluster.name"
                                }
                                functions = [
                                ]
                                group_by = [
                                ]
                                having = {
                                }
                                legend = "Queries"
                                name   = "A"
                                order = [
                                ]
                                signal        = "metrics"
                              }
                            }
                            type = "builder_query"
                          }
                        },
                        {
                          builder_query = {
                            spec = {
                              metrics = {
                                aggregations = [
                                  {
                                    metric_name       = "ClickHouseProfileEvents_FailedSelectQuery"
                                    reduce_to         = "avg"
                                    space_aggregation = "sum"
                                    time_aggregation  = "rate"
                                  },
                                ]
                                disabled = false
                                filter = {
                                  expression = "host.name = $host.name k8s.cluster.name in $k8s.cluster.name"
                                }
                                functions = [
                                ]
                                group_by = [
                                ]
                                having = {
                                }
                                legend = "Select Queries"
                                name   = "B"
                                order = [
                                ]
                                signal        = "metrics"
                              }
                            }
                            type = "builder_query"
                          }
                        },
                        {
                          builder_query = {
                            spec = {
                              metrics = {
                                aggregations = [
                                  {
                                    metric_name       = "ClickHouseProfileEvents_FailedInsertQuery"
                                    reduce_to         = "avg"
                                    space_aggregation = "sum"
                                    time_aggregation  = "rate"
                                  },
                                ]
                                disabled = false
                                filter = {
                                  expression = "host.name = $host.name k8s.cluster.name in $k8s.cluster.name"
                                }
                                functions = [
                                ]
                                group_by = [
                                ]
                                having = {
                                }
                                legend = "Insert Queries"
                                name   = "C"
                                order = [
                                ]
                                signal        = "metrics"
                              }
                            }
                            type = "builder_query"
                          }
                        },
                        {
                          builder_query = {
                            spec = {
                              metrics = {
                                aggregations = [
                                  {
                                    metric_name       = "ClickHouseProfileEvents_FailedAsyncInsertQuery"
                                    reduce_to         = "avg"
                                    space_aggregation = "sum"
                                    time_aggregation  = "rate"
                                  },
                                ]
                                disabled = false
                                filter = {
                                  expression = "host.name = $host.name k8s.cluster.name in $k8s.cluster.name"
                                }
                                functions = [
                                ]
                                group_by = [
                                ]
                                having = {
                                }
                                legend = "Async Insert Queries"
                                name   = "D"
                                order = [
                                ]
                                signal        = "metrics"
                              }
                            }
                            type = "builder_query"
                          }
                        },
                      ]
                    }
                  }
                }
              }
            },
          ]
        }
      }
      "3b96004b-f356-4fc9-a7de-36af5eabad5d" = {
        kind = "Panel"
        spec = {
          display = {
            name = "Background Merges Launched"
          }
          links = [
          ]
          plugin = {
            time_series_panel = {
              kind = "signoz/TimeSeriesPanel"
              spec = {
                axes = {
                  is_log_scale = false
                  soft_max     = 0
                  soft_min     = 0
                }
                chart_appearance = {
                  fill_mode          = "none"
                  line_interpolation = "spline"
                  line_style         = "solid"
                  show_points        = false
                  span_gaps = {
                    fill_only_below = false
                  }
                }
                formatting = {
                  decimal_precision = "2"
                  unit              = "cps"
                }
                legend = {
                  mode     = "list"
                  position = "bottom"
                }
                visualization = {
                  fill_spans      = false
                  time_preference = "global_time"
                }
              }
            }
          }
          queries = [
            {
              kind = "time_series"
              spec = {
                name = "A"
                plugin = {
                  builder_query = {
                    kind = "signoz/BuilderQuery"
                    spec = {
                      metrics = {
                        aggregations = [
                          {
                            metric_name       = "chi_clickhouse_event_Merge"
                            reduce_to         = "sum"
                            space_aggregation = "sum"
                            time_aggregation  = "rate"
                          },
                        ]
                        disabled = false
                        filter = {
                          expression = "k8s.cluster.name in $k8s.cluster.name"
                        }
                        functions = [
                        ]
                        group_by = [
                        ]
                        having = {
                        }
                        legend = "Number of merges launched"
                        name   = "A"
                        order = [
                        ]
                        signal        = "metrics"
                      }
                    }
                  }
                }
              }
            },
          ]
        }
      }
      "486edfb2-02ce-45a3-ab89-06fce614edcf" = {
        kind = "Panel"
        spec = {
          display = {
            name = "Network Traffic"
          }
          links = [
          ]
          plugin = {
            time_series_panel = {
              kind = "signoz/TimeSeriesPanel"
              spec = {
                axes = {
                  is_log_scale = false
                  soft_max     = 0
                  soft_min     = 0
                }
                chart_appearance = {
                  fill_mode          = "none"
                  line_interpolation = "spline"
                  line_style         = "solid"
                  show_points        = false
                  span_gaps = {
                    fill_only_below = false
                  }
                }
                formatting = {
                  decimal_precision = "2"
                  unit              = "binBps"
                }
                legend = {
                  mode     = "list"
                  position = "bottom"
                }
                visualization = {
                  fill_spans      = false
                  time_preference = "global_time"
                }
              }
            }
          }
          queries = [
            {
              kind = "time_series"
              spec = {
                plugin = {
                  composite_query = {
                    kind = "signoz/CompositeQuery"
                    spec = {
                      queries = [
                        {
                          builder_query = {
                            spec = {
                              metrics = {
                                aggregations = [
                                  {
                                    metric_name       = "chi_clickhouse_event_NetworkReceiveBytes"
                                    reduce_to         = "sum"
                                    space_aggregation = "sum"
                                    time_aggregation  = "rate"
                                  },
                                ]
                                disabled = false
                                filter = {
                                  expression = "k8s.cluster.name in $k8s.cluster.name"
                                }
                                functions = [
                                ]
                                group_by = [
                                ]
                                having = {
                                }
                                legend = "Received"
                                name   = "A"
                                order = [
                                ]
                                signal        = "metrics"
                              }
                            }
                            type = "builder_query"
                          }
                        },
                        {
                          builder_query = {
                            spec = {
                              metrics = {
                                aggregations = [
                                  {
                                    metric_name       = "chi_clickhouse_event_NetworkSendBytes"
                                    reduce_to         = "sum"
                                    space_aggregation = "sum"
                                    time_aggregation  = "rate"
                                  },
                                ]
                                disabled = false
                                filter = {
                                  expression = "k8s.cluster.name in $k8s.cluster.name"
                                }
                                functions = [
                                ]
                                group_by = [
                                ]
                                having = {
                                }
                                legend = "Sent"
                                name   = "B"
                                order = [
                                ]
                                signal        = "metrics"
                              }
                            }
                            type = "builder_query"
                          }
                        },
                      ]
                    }
                  }
                }
              }
            },
          ]
        }
      }
      "581eb12e-8c92-4a8d-9800-0f72f350cfd1" = {
        kind = "Panel"
        spec = {
          display = {
            name = "Total Time spent for Background Merges"
          }
          links = [
          ]
          plugin = {
            time_series_panel = {
              kind = "signoz/TimeSeriesPanel"
              spec = {
                axes = {
                  is_log_scale = false
                  soft_max     = 0
                  soft_min     = 0
                }
                chart_appearance = {
                  fill_mode          = "none"
                  line_interpolation = "spline"
                  line_style         = "solid"
                  show_points        = false
                  span_gaps = {
                    fill_only_below = false
                  }
                }
                formatting = {
                  decimal_precision = "2"
                  unit              = "ms"
                }
                legend = {
                  mode     = "list"
                  position = "bottom"
                }
                visualization = {
                  fill_spans      = false
                  time_preference = "global_time"
                }
              }
            }
          }
          queries = [
            {
              kind = "time_series"
              spec = {
                name = "A"
                plugin = {
                  builder_query = {
                    kind = "signoz/BuilderQuery"
                    spec = {
                      metrics = {
                        aggregations = [
                          {
                            metric_name       = "chi_clickhouse_event_MergeExecuteMilliseconds"
                            reduce_to         = "sum"
                            space_aggregation = "sum"
                            time_aggregation  = "rate"
                          },
                        ]
                        disabled = false
                        filter = {
                          expression = "k8s.cluster.name in $k8s.cluster.name"
                        }
                        functions = [
                        ]
                        group_by = [
                        ]
                        having = {
                        }
                        legend = "Total Time Spent on Merges"
                        name   = "A"
                        order = [
                        ]
                        signal        = "metrics"
                      }
                    }
                  }
                }
              }
            },
          ]
        }
      }
      "653248f0-9658-4be3-ba03-017d804e90c8" = {
        kind = "Panel"
        spec = {
          display = {
            name = "Inserted Rows"
          }
          links = [
          ]
          plugin = {
            time_series_panel = {
              kind = "signoz/TimeSeriesPanel"
              spec = {
                axes = {
                  is_log_scale = false
                  soft_max     = 0
                  soft_min     = 0
                }
                chart_appearance = {
                  fill_mode          = "none"
                  line_interpolation = "spline"
                  line_style         = "solid"
                  show_points        = false
                  span_gaps = {
                    fill_only_below = false
                  }
                }
                formatting = {
                  decimal_precision = "2"
                  unit              = "cps"
                }
                legend = {
                  mode     = "list"
                  position = "bottom"
                }
                visualization = {
                  fill_spans      = false
                  time_preference = "global_time"
                }
              }
            }
          }
          queries = [
            {
              kind = "time_series"
              spec = {
                name = "A"
                plugin = {
                  builder_query = {
                    kind = "signoz/BuilderQuery"
                    spec = {
                      metrics = {
                        aggregations = [
                          {
                            metric_name       = "ClickHouseProfileEvents_InsertedRows"
                            reduce_to         = "avg"
                            space_aggregation = "sum"
                            time_aggregation  = "rate"
                          },
                        ]
                        disabled = false
                        filter = {
                          expression = "host.name = $host.name k8s.cluster.name in $k8s.cluster.name"
                        }
                        functions = [
                        ]
                        group_by = [
                        ]
                        having = {
                        }
                        legend = "Inserted Rows"
                        name   = "A"
                        order = [
                        ]
                        signal        = "metrics"
                      }
                    }
                  }
                }
              }
            },
          ]
        }
      }
      "7f36d404-8915-4bfb-ac93-b69a9ea1428a" = {
        kind = "Panel"
        spec = {
          display = {
            description = "Writes rejected with \"Too many parts\" for inserts or \"Too many mutations\" for mutations"
            name        = "Rejected Writes"
          }
          links = [
          ]
          plugin = {
            time_series_panel = {
              kind = "signoz/TimeSeriesPanel"
              spec = {
                axes = {
                  is_log_scale = false
                  soft_max     = 0
                  soft_min     = 0
                }
                chart_appearance = {
                  fill_mode          = "none"
                  line_interpolation = "spline"
                  line_style         = "solid"
                  show_points        = false
                  span_gaps = {
                    fill_only_below = false
                  }
                }
                formatting = {
                  decimal_precision = "2"
                  unit              = "none"
                }
                legend = {
                  mode     = "list"
                  position = "bottom"
                }
                visualization = {
                  fill_spans      = false
                  time_preference = "global_time"
                }
              }
            }
          }
          queries = [
            {
              kind = "time_series"
              spec = {
                plugin = {
                  composite_query = {
                    kind = "signoz/CompositeQuery"
                    spec = {
                      queries = [
                        {
                          builder_query = {
                            spec = {
                              metrics = {
                                aggregations = [
                                  {
                                    metric_name       = "ClickHouseProfileEvents_RejectedInserts"
                                    reduce_to         = "avg"
                                    space_aggregation = "sum"
                                    time_aggregation  = "rate"
                                  },
                                ]
                                disabled = false
                                filter = {
                                  expression = "host.name = $host.name k8s.cluster.name in $k8s.cluster.name"
                                }
                                functions = [
                                ]
                                group_by = [
                                ]
                                having = {
                                }
                                legend = "Rejected Inserts"
                                name   = "A"
                                order = [
                                ]
                                signal        = "metrics"
                              }
                            }
                            type = "builder_query"
                          }
                        },
                        {
                          builder_query = {
                            spec = {
                              metrics = {
                                aggregations = [
                                  {
                                    metric_name       = "ClickHouseProfileEvents_RejectedMutations"
                                    reduce_to         = "avg"
                                    space_aggregation = "sum"
                                    time_aggregation  = "rate"
                                  },
                                ]
                                disabled = false
                                filter = {
                                  expression = "host.name = $host.name k8s.cluster.name in $k8s.cluster.name"
                                }
                                functions = [
                                ]
                                group_by = [
                                ]
                                having = {
                                }
                                legend = "Rejected Mutations"
                                name   = "B"
                                order = [
                                ]
                                signal        = "metrics"
                              }
                            }
                            type = "builder_query"
                          }
                        },
                      ]
                    }
                  }
                }
              }
            },
          ]
        }
      }
      "8eb1e295-d5e8-4007-acb1-a9ec385d6f4d" = {
        kind = "Panel"
        spec = {
          display = {
            name = "Memory Usage"
          }
          links = [
          ]
          plugin = {
            time_series_panel = {
              kind = "signoz/TimeSeriesPanel"
              spec = {
                axes = {
                  is_log_scale = false
                  soft_max     = 0
                  soft_min     = 0
                }
                chart_appearance = {
                  fill_mode          = "none"
                  line_interpolation = "spline"
                  line_style         = "solid"
                  show_points        = false
                  span_gaps = {
                    fill_only_below = false
                  }
                }
                formatting = {
                  decimal_precision = "2"
                  unit              = "bytes"
                }
                legend = {
                  mode     = "list"
                  position = "bottom"
                }
                visualization = {
                  fill_spans      = false
                  time_preference = "global_time"
                }
              }
            }
          }
          queries = [
            {
              kind = "time_series"
              spec = {
                name = "A"
                plugin = {
                  builder_query = {
                    kind = "signoz/BuilderQuery"
                    spec = {
                      metrics = {
                        aggregations = [
                          {
                            metric_name       = "chi_clickhouse_metric_MemoryTracking"
                            reduce_to         = "avg"
                            space_aggregation = "avg"
                            time_aggregation  = "avg"
                          },
                        ]
                        disabled = false
                        filter = {
                          expression = "k8s.cluster.name in $k8s.cluster.name"
                        }
                        functions = [
                        ]
                        group_by = [
                        ]
                        having = {
                        }
                        legend = "Memory Used"
                        name   = "A"
                        order = [
                        ]
                        signal        = "metrics"
                      }
                    }
                  }
                }
              }
            },
          ]
        }
      }
      "947053c4-b809-4241-9cb2-90e09868c2a9" = {
        kind = "Panel"
        spec = {
          display = {
            name = "Inserted Data"
          }
          links = [
          ]
          plugin = {
            time_series_panel = {
              kind = "signoz/TimeSeriesPanel"
              spec = {
                axes = {
                  is_log_scale = false
                  soft_max     = 0
                  soft_min     = 0
                }
                chart_appearance = {
                  fill_mode          = "none"
                  line_interpolation = "spline"
                  line_style         = "solid"
                  show_points        = false
                  span_gaps = {
                    fill_only_below = false
                  }
                }
                formatting = {
                  decimal_precision = "2"
                  unit              = "binBps"
                }
                legend = {
                  mode     = "list"
                  position = "bottom"
                }
                visualization = {
                  fill_spans      = false
                  time_preference = "global_time"
                }
              }
            }
          }
          queries = [
            {
              kind = "time_series"
              spec = {
                name = "A"
                plugin = {
                  builder_query = {
                    kind = "signoz/BuilderQuery"
                    spec = {
                      metrics = {
                        aggregations = [
                          {
                            metric_name       = "chi_clickhouse_event_InsertedBytes"
                            reduce_to         = "sum"
                            space_aggregation = "sum"
                            time_aggregation  = "rate"
                          },
                        ]
                        disabled = false
                        filter = {
                          expression = "k8s.cluster.name in $k8s.cluster.name"
                        }
                        functions = [
                        ]
                        group_by = [
                        ]
                        having = {
                        }
                        legend = "Inserted Data"
                        name   = "A"
                        order = [
                        ]
                        signal        = "metrics"
                      }
                    }
                  }
                }
              }
            },
          ]
        }
      }
      "97a2c7bb-f135-412b-a006-167dcc1882c6" = {
        kind = "Panel"
        spec = {
          display = {
            name = "Total Query Time"
          }
          links = [
          ]
          plugin = {
            time_series_panel = {
              kind = "signoz/TimeSeriesPanel"
              spec = {
                axes = {
                  is_log_scale = false
                  soft_max     = 0
                  soft_min     = 0
                }
                chart_appearance = {
                  fill_mode          = "none"
                  line_interpolation = "spline"
                  line_style         = "solid"
                  show_points        = false
                  span_gaps = {
                    fill_only_below = false
                  }
                }
                formatting = {
                  decimal_precision = "2"
                  unit              = "µs"
                }
                legend = {
                  mode     = "list"
                  position = "bottom"
                }
                visualization = {
                  fill_spans      = false
                  time_preference = "global_time"
                }
              }
            }
          }
          queries = [
            {
              kind = "time_series"
              spec = {
                plugin = {
                  composite_query = {
                    kind = "signoz/CompositeQuery"
                    spec = {
                      queries = [
                        {
                          builder_query = {
                            spec = {
                              metrics = {
                                aggregations = [
                                  {
                                    metric_name       = "ClickHouseProfileEvents_QueryTimeMicroseconds"
                                    reduce_to         = "avg"
                                    space_aggregation = "sum"
                                    time_aggregation  = "rate"
                                  },
                                ]
                                disabled = false
                                filter = {
                                  expression = "host.name = $host.name k8s.cluster.name in $k8s.cluster.name"
                                }
                                functions = [
                                ]
                                group_by = [
                                ]
                                having = {
                                }
                                legend = "All Queries"
                                name   = "A"
                                order = [
                                ]
                                signal        = "metrics"
                              }
                            }
                            type = "builder_query"
                          }
                        },
                        {
                          builder_query = {
                            spec = {
                              metrics = {
                                aggregations = [
                                  {
                                    metric_name       = "ClickHouseProfileEvents_SelectQueryTimeMicroseconds"
                                    reduce_to         = "avg"
                                    space_aggregation = "sum"
                                    time_aggregation  = "rate"
                                  },
                                ]
                                disabled = false
                                filter = {
                                  expression = "host.name = $host.name k8s.cluster.name in $k8s.cluster.name"
                                }
                                functions = [
                                ]
                                group_by = [
                                ]
                                having = {
                                }
                                legend = "Select Queries"
                                name   = "B"
                                order = [
                                ]
                                signal        = "metrics"
                              }
                            }
                            type = "builder_query"
                          }
                        },
                        {
                          builder_query = {
                            spec = {
                              metrics = {
                                aggregations = [
                                  {
                                    metric_name       = "ClickHouseProfileEvents_InsertQueryTimeMicroseconds"
                                    reduce_to         = "avg"
                                    space_aggregation = "sum"
                                    time_aggregation  = "rate"
                                  },
                                ]
                                disabled = false
                                filter = {
                                  expression = "host.name = $host.name k8s.cluster.name in $k8s.cluster.name"
                                }
                                functions = [
                                ]
                                group_by = [
                                ]
                                having = {
                                }
                                legend = "Insert Queries"
                                name   = "C"
                                order = [
                                ]
                                signal        = "metrics"
                              }
                            }
                            type = "builder_query"
                          }
                        },
                        {
                          builder_query = {
                            spec = {
                              metrics = {
                                aggregations = [
                                  {
                                    metric_name       = "ClickHouseProfileEvents_OtherQueryTimeMicroseconds"
                                    reduce_to         = "avg"
                                    space_aggregation = "sum"
                                    time_aggregation  = "rate"
                                  },
                                ]
                                disabled = false
                                filter = {
                                  expression = "host.name = $host.name k8s.cluster.name in $k8s.cluster.name"
                                }
                                functions = [
                                ]
                                group_by = [
                                ]
                                having = {
                                }
                                legend = "Other Queries (not select or insert)"
                                name   = "D"
                                order = [
                                ]
                                signal        = "metrics"
                              }
                            }
                            type = "builder_query"
                          }
                        },
                      ]
                    }
                  }
                }
              }
            },
          ]
        }
      }
      a62fdaa8-9193-46c1-a951-8e3d5a6b1cf9 = {
        kind = "Panel"
        spec = {
          display = {
            name = "Rate of Queries"
          }
          links = [
          ]
          plugin = {
            time_series_panel = {
              kind = "signoz/TimeSeriesPanel"
              spec = {
                axes = {
                  is_log_scale = false
                  soft_max     = 0
                  soft_min     = 0
                }
                chart_appearance = {
                  fill_mode          = "none"
                  line_interpolation = "spline"
                  line_style         = "solid"
                  show_points        = false
                  span_gaps = {
                    fill_only_below = false
                  }
                }
                formatting = {
                  decimal_precision = "2"
                  unit              = "cps"
                }
                legend = {
                  mode     = "list"
                  position = "bottom"
                }
                visualization = {
                  fill_spans      = false
                  time_preference = "global_time"
                }
              }
            }
          }
          queries = [
            {
              kind = "time_series"
              spec = {
                plugin = {
                  composite_query = {
                    kind = "signoz/CompositeQuery"
                    spec = {
                      queries = [
                        {
                          builder_query = {
                            spec = {
                              metrics = {
                                aggregations = [
                                  {
                                    metric_name       = "ClickHouseProfileEvents_Query"
                                    reduce_to         = "avg"
                                    space_aggregation = "sum"
                                    time_aggregation  = "rate"
                                  },
                                ]
                                disabled = false
                                filter = {
                                  expression = "host.name = $host.name k8s.cluster.name in $k8s.cluster.name"
                                }
                                functions = [
                                ]
                                group_by = [
                                  {
                                    field_context   = "attribute"
                                    field_data_type = "string"
                                    name            = "host.name"
                                  },
                                ]
                                having = {
                                }
                                legend = "Queries"
                                name   = "A"
                                order = [
                                ]
                                signal        = "metrics"
                              }
                            }
                            type = "builder_query"
                          }
                        },
                        {
                          builder_query = {
                            spec = {
                              metrics = {
                                aggregations = [
                                  {
                                    metric_name       = "ClickHouseProfileEvents_SelectQuery"
                                    reduce_to         = "avg"
                                    space_aggregation = "sum"
                                    time_aggregation  = "rate"
                                  },
                                ]
                                disabled = false
                                filter = {
                                  expression = "host.name = $host.name k8s.cluster.name in $k8s.cluster.name"
                                }
                                functions = [
                                ]
                                group_by = [
                                  {
                                    field_context   = "attribute"
                                    field_data_type = "string"
                                    name            = "host.name"
                                  },
                                ]
                                having = {
                                }
                                legend = "Select Queries"
                                name   = "B"
                                order = [
                                ]
                                signal        = "metrics"
                              }
                            }
                            type = "builder_query"
                          }
                        },
                        {
                          builder_query = {
                            spec = {
                              metrics = {
                                aggregations = [
                                  {
                                    metric_name       = "ClickHouseProfileEvents_InsertQuery"
                                    reduce_to         = "avg"
                                    space_aggregation = "sum"
                                    time_aggregation  = "rate"
                                  },
                                ]
                                disabled = false
                                filter = {
                                  expression = "host.name = $host.name k8s.cluster.name in $k8s.cluster.name"
                                }
                                functions = [
                                ]
                                group_by = [
                                  {
                                    field_context   = "attribute"
                                    field_data_type = "string"
                                    name            = "host.name"
                                  },
                                ]
                                having = {
                                }
                                legend = "Insert Queries"
                                name   = "C"
                                order = [
                                ]
                                signal        = "metrics"
                              }
                            }
                            type = "builder_query"
                          }
                        },
                        {
                          builder_query = {
                            spec = {
                              metrics = {
                                aggregations = [
                                  {
                                    metric_name       = "ClickHouseProfileEvents_AsyncInsertQuery"
                                    reduce_to         = "avg"
                                    space_aggregation = "sum"
                                    time_aggregation  = "rate"
                                  },
                                ]
                                disabled = false
                                filter = {
                                  expression = "host.name = $host.name k8s.cluster.name in $k8s.cluster.name"
                                }
                                functions = [
                                ]
                                group_by = [
                                  {
                                    field_context   = "attribute"
                                    field_data_type = "string"
                                    name            = "host.name"
                                  },
                                ]
                                having = {
                                }
                                legend = "Async Insert Queries"
                                name   = "D"
                                order = [
                                ]
                                signal        = "metrics"
                              }
                            }
                            type = "builder_query"
                          }
                        },
                      ]
                    }
                  }
                }
              }
            },
          ]
        }
      }
      be48f124-96d1-4327-ae10-6f2c1b81fe50 = {
        kind = "Panel"
        spec = {
          display = {
            name = "Disk"
          }
          links = [
          ]
          plugin = {
            time_series_panel = {
              kind = "signoz/TimeSeriesPanel"
              spec = {
                axes = {
                  is_log_scale = false
                  soft_max     = 0
                  soft_min     = 0
                }
                chart_appearance = {
                  fill_mode          = "none"
                  line_interpolation = "spline"
                  line_style         = "solid"
                  show_points        = false
                  span_gaps = {
                    fill_only_below = false
                  }
                }
                formatting = {
                  decimal_precision = "2"
                  unit              = "binBps"
                }
                legend = {
                  mode     = "list"
                  position = "bottom"
                }
                visualization = {
                  fill_spans      = false
                  time_preference = "global_time"
                }
              }
            }
          }
          queries = [
            {
              kind = "time_series"
              spec = {
                plugin = {
                  composite_query = {
                    kind = "signoz/CompositeQuery"
                    spec = {
                      queries = [
                        {
                          builder_query = {
                            spec = {
                              metrics = {
                                aggregations = [
                                  {
                                    metric_name       = "chi_clickhouse_event_OSReadBytes"
                                    reduce_to         = "sum"
                                    space_aggregation = "sum"
                                    time_aggregation  = "rate"
                                  },
                                ]
                                disabled = false
                                filter = {
                                  expression = "k8s.cluster.name in $k8s.cluster.name"
                                }
                                functions = [
                                ]
                                group_by = [
                                ]
                                having = {
                                }
                                legend = "Read"
                                name   = "A"
                                order = [
                                ]
                                signal        = "metrics"
                              }
                            }
                            type = "builder_query"
                          }
                        },
                        {
                          builder_query = {
                            spec = {
                              metrics = {
                                aggregations = [
                                  {
                                    metric_name       = "chi_clickhouse_event_OSWriteBytes"
                                    reduce_to         = "sum"
                                    space_aggregation = "sum"
                                    time_aggregation  = "rate"
                                  },
                                ]
                                disabled = false
                                filter = {
                                  expression = "k8s.cluster.name in $k8s.cluster.name"
                                }
                                functions = [
                                ]
                                group_by = [
                                ]
                                having = {
                                }
                                legend = "Write"
                                name   = "B"
                                order = [
                                ]
                                signal        = "metrics"
                              }
                            }
                            type = "builder_query"
                          }
                        },
                      ]
                    }
                  }
                }
              }
            },
          ]
        }
      }
      fcb693b5-6786-49e0-8007-4bc6009c70e2 = {
        kind = "Panel"
        spec = {
          display = {
            name = "CPU"
          }
          links = [
          ]
          plugin = {
            time_series_panel = {
              kind = "signoz/TimeSeriesPanel"
              spec = {
                axes = {
                  is_log_scale = false
                  soft_max     = 0
                  soft_min     = 0
                }
                chart_appearance = {
                  fill_mode          = "none"
                  line_interpolation = "spline"
                  line_style         = "solid"
                  show_points        = false
                  span_gaps = {
                    fill_only_below = false
                  }
                }
                formatting = {
                  decimal_precision = "2"
                  unit              = "µs"
                }
                legend = {
                  mode     = "list"
                  position = "bottom"
                }
                visualization = {
                  fill_spans      = false
                  time_preference = "global_time"
                }
              }
            }
          }
          queries = [
            {
              kind = "time_series"
              spec = {
                plugin = {
                  composite_query = {
                    kind = "signoz/CompositeQuery"
                    spec = {
                      queries = [
                        {
                          builder_query = {
                            spec = {
                              metrics = {
                                aggregations = [
                                  {
                                    metric_name       = "chi_clickhouse_event_OSCPUVirtualTimeMicroseconds"
                                    reduce_to         = "sum"
                                    space_aggregation = "sum"
                                    time_aggregation  = "rate"
                                  },
                                ]
                                disabled = false
                                filter = {
                                  expression = "k8s.cluster.name in $k8s.cluster.name"
                                }
                                functions = [
                                ]
                                group_by = [
                                ]
                                having = {
                                }
                                legend = "OSCPUVirtualTimeMicroseconds"
                                name   = "A"
                                order = [
                                ]
                                signal        = "metrics"
                              }
                            }
                            type = "builder_query"
                          }
                        },
                        {
                          builder_query = {
                            spec = {
                              metrics = {
                                aggregations = [
                                  {
                                    metric_name       = "chi_clickhouse_event_OSCPUWaitMicroseconds"
                                    reduce_to         = "sum"
                                    space_aggregation = "sum"
                                    time_aggregation  = "rate"
                                  },
                                ]
                                disabled = false
                                filter = {
                                  expression = "k8s.cluster.name in $k8s.cluster.name"
                                }
                                functions = [
                                ]
                                group_by = [
                                ]
                                having = {
                                }
                                legend = "OSCPUWaitMicroseconds"
                                name   = "B"
                                order = [
                                ]
                                signal        = "metrics"
                              }
                            }
                            type = "builder_query"
                          }
                        },
                      ]
                    }
                  }
                }
              }
            },
          ]
        }
      }
    }
    variables = [
      {
        list_variable = {
          kind = "ListVariable"
          spec = {
            allow_all_value = false
            allow_multiple  = false
            display = {
              description = "The k8s.cluster.name"
              name        = "k8s.cluster.name"
            }
            name = "k8s.cluster.name"
            plugin = {
              dynamic_variable = {
                kind = "signoz/DynamicVariable"
                spec = {
                  name   = "k8s.cluster.name"
                  signal = "all"
                }
              }
            }
            sort = "none"
          }
        }
      },
    ]
  }
  tags = [
    {
      key   = "tag"
      value = "clickhouse"
    },
    {
      key   = "tag"
      value = "database"
    },
  ]
}

resource "signoz_dashboard" "mongodb_overview" {
  name           = "mongo-overview-mbhicjvq"
  schema_version = "v6"
  spec = {
    display = {
      description = "This dashboard provides a high-level overview of MongoDB"
      name        = "Mongo overview"
    }
    layouts = [
      {
        grid = {
          kind = "Grid"
          spec = {
            items = [
              {
                content = {
                  ref = "#/spec/panels/db33b09a-4273-4b14-a63f-926bf32de2b5"
                }
                height = 5
                width  = 12
                x      = 0
                y      = 0
              },
              {
                content = {
                  ref = "#/spec/panels/4c07a7d2-893a-46c2-bcdb-a19b6efeac3a"
                }
                height = 5
                width  = 6
                x      = 0
                y      = 5
              },
              {
                content = {
                  ref = "#/spec/panels/f2b46fdc-29d2-4c82-b79e-371eebcaa14c"
                }
                height = 5
                width  = 6
                x      = 6
                y      = 5
              },
              {
                content = {
                  ref = "#/spec/panels/dcfb3829-c3f2-44bb-907d-8dc8a6dc4aab"
                }
                height = 5
                width  = 6
                x      = 0
                y      = 10
              },
              {
                content = {
                  ref = "#/spec/panels/bfc9e80b-02bf-4122-b3da-3dd943d35012"
                }
                height = 5
                width  = 6
                x      = 6
                y      = 10
              },
              {
                content = {
                  ref = "#/spec/panels/14504a3c-4a05-4d22-bab3-e22e94f51380"
                }
                height = 5
                width  = 6
                x      = 0
                y      = 15
              },
              {
                content = {
                  ref = "#/spec/panels/a5a64eec-1034-4aa6-8cb1-05673c4426c6"
                }
                height = 5
                width  = 6
                x      = 6
                y      = 15
              },
              {
                content = {
                  ref = "#/spec/panels/503af589-ef4d-4fe3-8934-c8f7eb480d9a"
                }
                height = 5
                width  = 6
                x      = 0
                y      = 20
              },
              {
                content = {
                  ref = "#/spec/panels/0c3d2b15-89be-4d62-a821-b26d93332ed3"
                }
                height = 5
                width  = 6
                x      = 6
                y      = 20
              },
              {
                content = {
                  ref = "#/spec/panels/2db9bbd2-081f-4d84-a72e-a3c58b7e27a6"
                }
                height = 5
                width  = 6
                x      = 0
                y      = 25
              },
            ]
          }
        }
      },
    ]
    links = [
    ]
    panels = {
      "0c3d2b15-89be-4d62-a821-b26d93332ed3" = {
        kind = "Panel"
        spec = {
          display = {
            name = "Network IO"
          }
          links = [
          ]
          plugin = {
            time_series_panel = {
              kind = "signoz/TimeSeriesPanel"
              spec = {
                axes = {
                  is_log_scale = false
                  soft_max     = 0
                  soft_min     = 0
                }
                chart_appearance = {
                  fill_mode          = "none"
                  line_interpolation = "spline"
                  line_style         = "solid"
                  show_points        = false
                  span_gaps = {
                    fill_only_below = false
                  }
                }
                formatting = {
                  decimal_precision = "2"
                  unit              = "bytes"
                }
                legend = {
                  mode     = "list"
                  position = "bottom"
                }
                visualization = {
                  fill_spans      = false
                  time_preference = "global_time"
                }
              }
            }
          }
          queries = [
            {
              kind = "time_series"
              spec = {
                plugin = {
                  composite_query = {
                    kind = "signoz/CompositeQuery"
                    spec = {
                      queries = [
                        {
                          builder_query = {
                            spec = {
                              metrics = {
                                aggregations = [
                                  {
                                    metric_name       = "mongodb.network.io.receive"
                                    reduce_to         = "sum"
                                    space_aggregation = "sum"
                                    time_aggregation  = "avg"
                                  },
                                ]
                                disabled = false
                                filter = {
                                  expression = "k8s.cluster.name in $k8s.cluster.name"
                                }
                                functions = [
                                ]
                                group_by = [
                                  {
                                    field_context   = "attribute"
                                    field_data_type = "string"
                                    name            = "host.name"
                                  },
                                ]
                                having = {
                                }
                                legend = "Bytes received"
                                name   = "A"
                                order = [
                                ]
                                signal        = "metrics"
                              }
                            }
                            type = "builder_query"
                          }
                        },
                        {
                          builder_query = {
                            spec = {
                              metrics = {
                                aggregations = [
                                  {
                                    metric_name       = "mongodb.network.io.transmit"
                                    reduce_to         = "sum"
                                    space_aggregation = "sum"
                                    time_aggregation  = "avg"
                                  },
                                ]
                                disabled = false
                                filter = {
                                  expression = "k8s.cluster.name in $k8s.cluster.name"
                                }
                                functions = [
                                ]
                                group_by = [
                                  {
                                    field_context   = "attribute"
                                    field_data_type = "string"
                                    name            = "host.name"
                                  },
                                ]
                                having = {
                                }
                                legend = "Bytes transmitted"
                                name   = "B"
                                order = [
                                ]
                                signal        = "metrics"
                              }
                            }
                            type = "builder_query"
                          }
                        },
                      ]
                    }
                  }
                }
              }
            },
          ]
        }
      }
      "14504a3c-4a05-4d22-bab3-e22e94f51380" = {
        kind = "Panel"
        spec = {
          display = {
            name = "Read latency"
          }
          links = [
          ]
          plugin = {
            time_series_panel = {
              kind = "signoz/TimeSeriesPanel"
              spec = {
                axes = {
                  is_log_scale = false
                  soft_max     = 0
                  soft_min     = 0
                }
                chart_appearance = {
                  fill_mode          = "none"
                  line_interpolation = "spline"
                  line_style         = "solid"
                  show_points        = false
                  span_gaps = {
                    fill_only_below = false
                  }
                }
                formatting = {
                  decimal_precision = "2"
                  unit              = "µs"
                }
                legend = {
                  mode     = "list"
                  position = "bottom"
                }
                visualization = {
                  fill_spans      = false
                  time_preference = "global_time"
                }
              }
            }
          }
          queries = [
            {
              kind = "time_series"
              spec = {
                name = "A"
                plugin = {
                  builder_query = {
                    kind = "signoz/BuilderQuery"
                    spec = {
                      metrics = {
                        aggregations = [
                          {
                            metric_name       = "mongodb.operation.latency.time"
                            reduce_to         = "sum"
                            space_aggregation = "max"
                            time_aggregation  = "max"
                          },
                        ]
                        disabled = false
                        filter = {
                          expression = "(operation = 'read' AND k8s.cluster.name in $k8s.cluster.name)"
                        }
                        functions = [
                        ]
                        group_by = [
                        ]
                        having = {
                        }
                        legend = "Latency"
                        name   = "A"
                        order = [
                        ]
                        signal        = "metrics"
                      }
                    }
                  }
                }
              }
            },
          ]
        }
      }
      "2db9bbd2-081f-4d84-a72e-a3c58b7e27a6" = {
        kind = "Panel"
        spec = {
          display = {
            description = "Total number of operations"
            name        = "Global lock time"
          }
          links = [
          ]
          plugin = {
            time_series_panel = {
              kind = "signoz/TimeSeriesPanel"
              spec = {
                axes = {
                  is_log_scale = false
                  soft_max     = 0
                  soft_min     = 0
                }
                chart_appearance = {
                  fill_mode          = "none"
                  line_interpolation = "spline"
                  line_style         = "solid"
                  show_points        = false
                  span_gaps = {
                    fill_only_below = false
                  }
                }
                formatting = {
                  decimal_precision = "2"
                  unit              = "ms"
                }
                legend = {
                  mode     = "list"
                  position = "bottom"
                }
                visualization = {
                  fill_spans      = false
                  time_preference = "global_time"
                }
              }
            }
          }
          queries = [
            {
              kind = "time_series"
              spec = {
                name = "A"
                plugin = {
                  builder_query = {
                    kind = "signoz/BuilderQuery"
                    spec = {
                      metrics = {
                        aggregations = [
                          {
                            metric_name       = "mongodb.global_lock.time"
                            reduce_to         = "sum"
                            space_aggregation = "sum"
                            time_aggregation  = "rate"
                          },
                        ]
                        disabled = false
                        filter = {
                          expression = "k8s.cluster.name in $k8s.cluster.name"
                        }
                        functions = [
                        ]
                        group_by = [
                        ]
                        having = {
                        }
                        legend = "lock time"
                        name   = "A"
                        order = [
                        ]
                        signal        = "metrics"
                      }
                    }
                  }
                }
              }
            },
          ]
        }
      }
      "4c07a7d2-893a-46c2-bcdb-a19b6efeac3a" = {
        kind = "Panel"
        spec = {
          display = {
            description = "Total number of operations"
            name        = "Operations count"
          }
          links = [
          ]
          plugin = {
            time_series_panel = {
              kind = "signoz/TimeSeriesPanel"
              spec = {
                axes = {
                  is_log_scale = false
                  soft_max     = 0
                  soft_min     = 0
                }
                chart_appearance = {
                  fill_mode          = "none"
                  line_interpolation = "spline"
                  line_style         = "solid"
                  show_points        = false
                  span_gaps = {
                    fill_only_below = false
                  }
                }
                formatting = {
                  decimal_precision = "2"
                  unit              = "none"
                }
                legend = {
                  mode     = "list"
                  position = "bottom"
                }
                visualization = {
                  fill_spans      = false
                  time_preference = "global_time"
                }
              }
            }
          }
          queries = [
            {
              kind = "time_series"
              spec = {
                name = "A"
                plugin = {
                  builder_query = {
                    kind = "signoz/BuilderQuery"
                    spec = {
                      metrics = {
                        aggregations = [
                          {
                            metric_name       = "mongodb.operation.count"
                            reduce_to         = "sum"
                            space_aggregation = "sum"
                            time_aggregation  = "rate"
                          },
                        ]
                        disabled = false
                        filter = {
                          expression = "k8s.cluster.name in $k8s.cluster.name"
                        }
                        functions = [
                        ]
                        group_by = [
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "operation"
                          },
                        ]
                        having = {
                        }
                        legend = "{{operation}}"
                        name   = "A"
                        order = [
                        ]
                        signal        = "metrics"
                      }
                    }
                  }
                }
              }
            },
          ]
        }
      }
      "503af589-ef4d-4fe3-8934-c8f7eb480d9a" = {
        kind = "Panel"
        spec = {
          display = {
            name = "Command latency"
          }
          links = [
          ]
          plugin = {
            time_series_panel = {
              kind = "signoz/TimeSeriesPanel"
              spec = {
                axes = {
                  is_log_scale = false
                  soft_max     = 0
                  soft_min     = 0
                }
                chart_appearance = {
                  fill_mode          = "none"
                  line_interpolation = "spline"
                  line_style         = "solid"
                  show_points        = false
                  span_gaps = {
                    fill_only_below = false
                  }
                }
                formatting = {
                  decimal_precision = "2"
                  unit              = "µs"
                }
                legend = {
                  mode     = "list"
                  position = "bottom"
                }
                visualization = {
                  fill_spans      = false
                  time_preference = "global_time"
                }
              }
            }
          }
          queries = [
            {
              kind = "time_series"
              spec = {
                name = "A"
                plugin = {
                  builder_query = {
                    kind = "signoz/BuilderQuery"
                    spec = {
                      metrics = {
                        aggregations = [
                          {
                            metric_name       = "mongodb.operation.latency.time"
                            reduce_to         = "sum"
                            space_aggregation = "max"
                            time_aggregation  = "max"
                          },
                        ]
                        disabled = false
                        filter = {
                          expression = "(k8s.cluster.name in $k8s.cluster.name AND operation = 'command')"
                        }
                        functions = [
                        ]
                        group_by = [
                        ]
                        having = {
                        }
                        legend = "Latency"
                        name   = "A"
                        order = [
                        ]
                        signal        = "metrics"
                      }
                    }
                  }
                }
              }
            },
          ]
        }
      }
      a5a64eec-1034-4aa6-8cb1-05673c4426c6 = {
        kind = "Panel"
        spec = {
          display = {
            name = "Write latency"
          }
          links = [
          ]
          plugin = {
            time_series_panel = {
              kind = "signoz/TimeSeriesPanel"
              spec = {
                axes = {
                  is_log_scale = false
                  soft_max     = 0
                  soft_min     = 0
                }
                chart_appearance = {
                  fill_mode          = "none"
                  line_interpolation = "spline"
                  line_style         = "solid"
                  show_points        = false
                  span_gaps = {
                    fill_only_below = false
                  }
                }
                formatting = {
                  decimal_precision = "2"
                  unit              = "µs"
                }
                legend = {
                  mode     = "list"
                  position = "bottom"
                }
                visualization = {
                  fill_spans      = false
                  time_preference = "global_time"
                }
              }
            }
          }
          queries = [
            {
              kind = "time_series"
              spec = {
                name = "A"
                plugin = {
                  builder_query = {
                    kind = "signoz/BuilderQuery"
                    spec = {
                      metrics = {
                        aggregations = [
                          {
                            metric_name       = "mongodb.operation.latency.time"
                            reduce_to         = "sum"
                            space_aggregation = "max"
                            time_aggregation  = "max"
                          },
                        ]
                        disabled = false
                        filter = {
                          expression = "(operation = 'write' AND k8s.cluster.name in $k8s.cluster.name)"
                        }
                        functions = [
                        ]
                        group_by = [
                        ]
                        having = {
                        }
                        legend = "Latency"
                        name   = "A"
                        order = [
                        ]
                        signal        = "metrics"
                      }
                    }
                  }
                }
              }
            },
          ]
        }
      }
      bfc9e80b-02bf-4122-b3da-3dd943d35012 = {
        kind = "Panel"
        spec = {
          display = {
            description = "The total time spent performing operations."
            name        = "Total operations time"
          }
          links = [
          ]
          plugin = {
            time_series_panel = {
              kind = "signoz/TimeSeriesPanel"
              spec = {
                axes = {
                  is_log_scale = false
                  soft_max     = 0
                  soft_min     = 0
                }
                chart_appearance = {
                  fill_mode          = "none"
                  line_interpolation = "spline"
                  line_style         = "solid"
                  show_points        = false
                  span_gaps = {
                    fill_only_below = false
                  }
                }
                formatting = {
                  decimal_precision = "2"
                  unit              = "ms"
                }
                legend = {
                  mode     = "list"
                  position = "bottom"
                }
                visualization = {
                  fill_spans      = false
                  time_preference = "global_time"
                }
              }
            }
          }
          queries = [
            {
              kind = "time_series"
              spec = {
                name = "A"
                plugin = {
                  builder_query = {
                    kind = "signoz/BuilderQuery"
                    spec = {
                      metrics = {
                        aggregations = [
                          {
                            metric_name       = "mongodb.operation.time"
                            reduce_to         = "sum"
                            space_aggregation = "sum"
                            time_aggregation  = "rate"
                          },
                        ]
                        disabled = false
                        filter = {
                          expression = "k8s.cluster.name in $k8s.cluster.name"
                        }
                        functions = [
                        ]
                        group_by = [
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "operation"
                          },
                        ]
                        having = {
                        }
                        legend = "{{operation}}"
                        name   = "A"
                        order = [
                        ]
                        signal        = "metrics"
                      }
                    }
                  }
                }
              }
            },
          ]
        }
      }
      db33b09a-4273-4b14-a63f-926bf32de2b5 = {
        kind = "Panel"
        spec = {
          display = {
            description = "Total number of collections for each database"
            name        = "DB Overview"
          }
          links = [
          ]
          plugin = {
            table_panel = {
              kind = "signoz/TablePanel"
              spec = {
                formatting = {
                  column_units = {
                    A = "short"
                    B = "short"
                    C = "short"
                    D = "bytes"
                    E = "short"
                    F = "short"
                    G = "bytes"
                    H = "bytes"
                  }
                  decimal_precision = "2"
                }
                visualization = {
                  time_preference = "global_time"
                }
              }
            }
          }
          queries = [
            {
              kind = "scalar"
              spec = {
                plugin = {
                  composite_query = {
                    kind = "signoz/CompositeQuery"
                    spec = {
                      queries = [
                        {
                          builder_query = {
                            spec = {
                              metrics = {
                                aggregations = [
                                  {
                                    metric_name       = "mongodb.collection.count"
                                    reduce_to         = "last"
                                    space_aggregation = "sum"
                                    time_aggregation  = "max"
                                  },
                                ]
                                disabled = false
                                filter = {
                                  expression = "k8s.cluster.name in $k8s.cluster.name"
                                }
                                functions = [
                                ]
                                group_by = [
                                  {
                                    field_context   = "attribute"
                                    field_data_type = "string"
                                    name            = "db.namespace"
                                  },
                                ]
                                having = {
                                }
                                legend = "collections"
                                name   = "A"
                                order = [
                                ]
                                signal        = "metrics"
                              }
                            }
                            type = "builder_query"
                          }
                        },
                        {
                          builder_query = {
                            spec = {
                              metrics = {
                                aggregations = [
                                  {
                                    metric_name       = "mongodb.connection.count"
                                    reduce_to         = "last"
                                    space_aggregation = "sum"
                                    time_aggregation  = "latest"
                                  },
                                ]
                                disabled = false
                                filter = {
                                  expression = "(k8s.cluster.name in $k8s.cluster.name AND type = 'active')"
                                }
                                functions = [
                                ]
                                group_by = [
                                  {
                                    field_context   = "attribute"
                                    field_data_type = "string"
                                    name            = "db.namespace"
                                  },
                                ]
                                having = {
                                }
                                legend = "active conns"
                                name   = "B"
                                order = [
                                ]
                                signal        = "metrics"
                              }
                            }
                            type = "builder_query"
                          }
                        },
                        {
                          builder_query = {
                            spec = {
                              metrics = {
                                aggregations = [
                                  {
                                    metric_name       = "mongodb.connection.count"
                                    reduce_to         = "last"
                                    space_aggregation = "sum"
                                    time_aggregation  = "latest"
                                  },
                                ]
                                disabled = false
                                filter = {
                                  expression = "(k8s.cluster.name in $k8s.cluster.name AND type = 'current')"
                                }
                                functions = [
                                ]
                                group_by = [
                                  {
                                    name = "db.namespace"
                                  },
                                ]
                                having = {
                                }
                                legend = "current conns"
                                name   = "C"
                                order = [
                                ]
                                signal        = "metrics"
                              }
                            }
                            type = "builder_query"
                          }
                        },
                        {
                          builder_query = {
                            spec = {
                              metrics = {
                                aggregations = [
                                  {
                                    metric_name       = "mongodb.index.size"
                                    reduce_to         = "last"
                                    space_aggregation = "sum"
                                    time_aggregation  = "avg"
                                  },
                                ]
                                disabled = false
                                filter = {
                                  expression = "k8s.cluster.name in $k8s.cluster.name"
                                }
                                functions = [
                                ]
                                group_by = [
                                  {
                                    name = "db.namespace"
                                  },
                                ]
                                having = {
                                }
                                legend = "index size"
                                name   = "D"
                                order = [
                                ]
                                signal        = "metrics"
                              }
                            }
                            type = "builder_query"
                          }
                        },
                        {
                          builder_query = {
                            spec = {
                              metrics = {
                                aggregations = [
                                  {
                                    metric_name       = "mongodb.index.count"
                                    reduce_to         = "last"
                                    space_aggregation = "sum"
                                    time_aggregation  = "avg"
                                  },
                                ]
                                disabled = false
                                filter = {
                                  expression = "k8s.cluster.name in $k8s.cluster.name"
                                }
                                functions = [
                                ]
                                group_by = [
                                  {
                                    field_context   = "attribute"
                                    field_data_type = "string"
                                    name            = "db.namespace"
                                  },
                                ]
                                having = {
                                }
                                legend = "index count"
                                name   = "E"
                                order = [
                                ]
                                signal        = "metrics"
                              }
                            }
                            type = "builder_query"
                          }
                        },
                        {
                          builder_query = {
                            spec = {
                              metrics = {
                                aggregations = [
                                  {
                                    metric_name       = "mongodb.object.count"
                                    reduce_to         = "last"
                                    space_aggregation = "sum"
                                    time_aggregation  = "avg"
                                  },
                                ]
                                disabled = false
                                filter = {
                                  expression = "k8s.cluster.name in $k8s.cluster.name"
                                }
                                functions = [
                                ]
                                group_by = [
                                  {
                                    name = "db.namespace"
                                  },
                                ]
                                having = {
                                }
                                legend = "objects count"
                                name   = "F"
                                order = [
                                ]
                                signal        = "metrics"
                              }
                            }
                            type = "builder_query"
                          }
                        },
                        {
                          builder_query = {
                            spec = {
                              metrics = {
                                aggregations = [
                                  {
                                    metric_name       = "mongodb.memory.usage"
                                    reduce_to         = "avg"
                                    space_aggregation = "sum"
                                    time_aggregation  = "avg"
                                  },
                                ]
                                disabled = false
                                filter = {
                                  expression = "(k8s.cluster.name in $k8s.cluster.name AND type = 'resident')"
                                }
                                functions = [
                                ]
                                group_by = [
                                  {
                                    field_context   = "attribute"
                                    field_data_type = "string"
                                    name            = "db.namespace"
                                  },
                                ]
                                having = {
                                }
                                legend = "memory"
                                name   = "G"
                                order = [
                                ]
                                signal        = "metrics"
                              }
                            }
                            type = "builder_query"
                          }
                        },
                        {
                          builder_query = {
                            spec = {
                              metrics = {
                                aggregations = [
                                  {
                                    metric_name       = "mongodb.data.size"
                                    reduce_to         = "avg"
                                    space_aggregation = "sum"
                                    time_aggregation  = "avg"
                                  },
                                ]
                                disabled = false
                                filter = {
                                  expression = "k8s.cluster.name in $k8s.cluster.name"
                                }
                                functions = [
                                ]
                                group_by = [
                                  {
                                    field_context   = "attribute"
                                    field_data_type = "string"
                                    name            = "db.namespace"
                                  },
                                ]
                                having = {
                                }
                                legend = "data size"
                                name   = "H"
                                order = [
                                ]
                                signal        = "metrics"
                              }
                            }
                            type = "builder_query"
                          }
                        },
                      ]
                    }
                  }
                }
              }
            },
          ]
        }
      }
      dcfb3829-c3f2-44bb-907d-8dc8a6dc4aab = {
        kind = "Panel"
        spec = {
          display = {
            description = "The number of cache operations"
            name        = "Cache operations"
          }
          links = [
          ]
          plugin = {
            time_series_panel = {
              kind = "signoz/TimeSeriesPanel"
              spec = {
                axes = {
                  is_log_scale = false
                  soft_max     = 0
                  soft_min     = 0
                }
                chart_appearance = {
                  fill_mode          = "none"
                  line_interpolation = "spline"
                  line_style         = "solid"
                  show_points        = false
                  span_gaps = {
                    fill_only_below = false
                  }
                }
                formatting = {
                  decimal_precision = "2"
                  unit              = "none"
                }
                legend = {
                  mode     = "list"
                  position = "bottom"
                }
                visualization = {
                  fill_spans      = false
                  time_preference = "global_time"
                }
              }
            }
          }
          queries = [
            {
              kind = "time_series"
              spec = {
                name = "A"
                plugin = {
                  builder_query = {
                    kind = "signoz/BuilderQuery"
                    spec = {
                      metrics = {
                        aggregations = [
                          {
                            metric_name       = "mongodb.cache.operations"
                            reduce_to         = "avg"
                            space_aggregation = "sum"
                            time_aggregation  = "increase"
                          },
                        ]
                        disabled = false
                        filter = {
                          expression = "k8s.cluster.name in $k8s.cluster.name"
                        }
                        functions = [
                        ]
                        group_by = [
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "type"
                          },
                        ]
                        having = {
                        }
                        legend = "{{type}}"
                        name   = "A"
                        order = [
                        ]
                        signal        = "metrics"
                      }
                    }
                  }
                }
              }
            },
          ]
        }
      }
      f2b46fdc-29d2-4c82-b79e-371eebcaa14c = {
        kind = "Panel"
        spec = {
          display = {
            description = "The number of open cursors maintained for clients.\n"
            name        = "Cursor count"
          }
          links = [
          ]
          plugin = {
            time_series_panel = {
              kind = "signoz/TimeSeriesPanel"
              spec = {
                axes = {
                  is_log_scale = false
                  soft_max     = 0
                  soft_min     = 0
                }
                chart_appearance = {
                  fill_mode          = "none"
                  line_interpolation = "spline"
                  line_style         = "solid"
                  show_points        = false
                  span_gaps = {
                    fill_only_below = false
                  }
                }
                formatting = {
                  decimal_precision = "2"
                  unit              = "none"
                }
                legend = {
                  mode     = "list"
                  position = "bottom"
                }
                visualization = {
                  fill_spans      = false
                  time_preference = "global_time"
                }
              }
            }
          }
          queries = [
            {
              kind = "time_series"
              spec = {
                name = "A"
                plugin = {
                  builder_query = {
                    kind = "signoz/BuilderQuery"
                    spec = {
                      metrics = {
                        aggregations = [
                          {
                            metric_name       = "mongodb.cursor.count"
                            reduce_to         = "sum"
                            space_aggregation = "sum"
                            time_aggregation  = "avg"
                          },
                        ]
                        disabled = false
                        filter = {
                          expression = "k8s.cluster.name in $k8s.cluster.name"
                        }
                        functions = [
                        ]
                        group_by = [
                        ]
                        having = {
                        }
                        legend = "Cursor"
                        name   = "A"
                        order = [
                        ]
                        signal        = "metrics"
                      }
                    }
                  }
                }
              }
            },
          ]
        }
      }
    }
    variables = [
      {
        list_variable = {
          kind = "ListVariable"
          spec = {
            allow_all_value = true
            allow_multiple  = true
            display = {
              description = "The k8s.cluster.name"
              name        = "k8s.cluster.name"
            }
            name = "k8s.cluster.name"
            plugin = {
              dynamic_variable = {
                kind = "signoz/DynamicVariable"
                spec = {
                  name   = "k8s.cluster.name"
                  signal = "all"
                }
              }
            }
            sort = "alphabetical-asc"
          }
        }
      },
    ]
  }
  tags = [
    {
      key   = "tag"
      value = "mongo"
    },
    {
      key   = "tag"
      value = "database"
    },
  ]
}

resource "signoz_dashboard" "k8s_cluster_events" {
  name           = "kubernetes-cluster-events-0bg5f7ws"
  schema_version = "v6"
  spec = {
    display = {
      description = "This dashboard displays specific event and object kind counts, as well as their respective time-series charts, allowing the viewer to understand what's happening inside a cluster at a glance."
      name        = "Kubernetes Cluster Events"
    }
    layouts = [
      {
        grid = {
          kind = "Grid"
          spec = {
            items = [
              {
                content = {
                  ref = "#/spec/panels/ed16bdcc-b48a-4fff-91a3-25adda6cb2cd"
                }
                height = 4
                width  = 3
                x      = 0
                y      = 0
              },
              {
                content = {
                  ref = "#/spec/panels/afbcdd3b-809c-4a9c-8a3b-705a9347ca2c"
                }
                height = 4
                width  = 3
                x      = 3
                y      = 0
              },
              {
                content = {
                  ref = "#/spec/panels/a1d807e0-9afc-4214-a5f1-5820038af207"
                }
                height = 4
                width  = 3
                x      = 6
                y      = 0
              },
              {
                content = {
                  ref = "#/spec/panels/32c9d0bc-eec1-426e-be52-c12f14ca5e4a"
                }
                height = 4
                width  = 3
                x      = 9
                y      = 0
              },
              {
                content = {
                  ref = "#/spec/panels/65eb8379-0b43-4ecf-9345-58470f3ded4c"
                }
                height = 4
                width  = 3
                x      = 0
                y      = 4
              },
              {
                content = {
                  ref = "#/spec/panels/deb0862e-718d-4bf5-a1d2-6c5f776e169f"
                }
                height = 4
                width  = 3
                x      = 3
                y      = 4
              },
              {
                content = {
                  ref = "#/spec/panels/e767bb6a-97a8-4d5e-a55b-a37eed2b5613"
                }
                height = 4
                width  = 3
                x      = 6
                y      = 4
              },
              {
                content = {
                  ref = "#/spec/panels/1a9e91ae-e961-4c89-8f27-43bc113dfcb3"
                }
                height = 4
                width  = 3
                x      = 9
                y      = 4
              },
              {
                content = {
                  ref = "#/spec/panels/f94d28e7-34ba-4830-978d-09c09b5c1486"
                }
                height = 6
                width  = 6
                x      = 0
                y      = 8
              },
              {
                content = {
                  ref = "#/spec/panels/673f385a-58d9-4d3b-8a45-22e3766bf512"
                }
                height = 6
                width  = 6
                x      = 6
                y      = 8
              },
              {
                content = {
                  ref = "#/spec/panels/167650aa-2d2d-43e0-8773-b6c9fbe79878"
                }
                height = 6
                width  = 6
                x      = 0
                y      = 14
              },
              {
                content = {
                  ref = "#/spec/panels/773a7388-75c0-456f-ba63-d72b4c7cebd5"
                }
                height = 6
                width  = 6
                x      = 6
                y      = 14
              },
              {
                content = {
                  ref = "#/spec/panels/aa2462c3-24f0-4275-812c-549b896b7b61"
                }
                height = 6
                width  = 6
                x      = 0
                y      = 20
              },
              {
                content = {
                  ref = "#/spec/panels/1ef215d0-d0f9-46b2-a1e7-81846a7552b5"
                }
                height = 6
                width  = 6
                x      = 6
                y      = 20
              },
            ]
          }
        }
      },
    ]
    links = [
    ]
    panels = {
      "167650aa-2d2d-43e0-8773-b6c9fbe79878" = {
        kind = "Panel"
        spec = {
          display = {
            name = "Pulled Images over Time"
          }
          links = [
          ]
          plugin = {
            time_series_panel = {
              kind = "signoz/TimeSeriesPanel"
              spec = {
                axes = {
                  is_log_scale = false
                  soft_max     = 0
                  soft_min     = 0
                }
                chart_appearance = {
                  fill_mode          = "none"
                  line_interpolation = "spline"
                  line_style         = "solid"
                  show_points        = false
                  span_gaps = {
                    fill_only_below = false
                  }
                }
                formatting = {
                  decimal_precision = "2"
                  unit              = "none"
                }
                legend = {
                  mode     = "list"
                  position = "bottom"
                }
                visualization = {
                  fill_spans      = false
                  time_preference = "global_time"
                }
              }
            }
          }
          queries = [
            {
              kind = "time_series"
              spec = {
                name = "A"
                plugin = {
                  builder_query = {
                    kind = "signoz/BuilderQuery"
                    spec = {
                      logs = {
                        aggregations = [
                          {
                            expression = "count()"
                          },
                        ]
                        disabled = false
                        filter = {
                          expression = "k8s.event.reason = 'Pulled' AND resource.k8s.namespace.name in $k8s.namespace.name AND resource.k8s.cluster.name in $k8s.cluster.name"
                        }
                        functions = [
                        ]
                        group_by = [
                        ]
                        having = {
                        }
                        legend = "Pulled Images"
                        name   = "A"
                        order = [
                        ]
                        signal        = "logs"
                      }
                    }
                  }
                }
              }
            },
          ]
        }
      }
      "1a9e91ae-e961-4c89-8f27-43bc113dfcb3" = {
        kind = "Panel"
        spec = {
          display = {
            name = "Scaling Replica's Count"
          }
          links = [
          ]
          plugin = {
            number_panel = {
              kind = "signoz/NumberPanel"
              spec = {
                formatting = {
                  decimal_precision = "2"
                  unit              = "none"
                }
                visualization = {
                  time_preference = "global_time"
                }
              }
            }
          }
          queries = [
            {
              kind = "scalar"
              spec = {
                name = "A"
                plugin = {
                  builder_query = {
                    kind = "signoz/BuilderQuery"
                    spec = {
                      logs = {
                        aggregations = [
                          {
                            expression = "count()"
                          },
                        ]
                        disabled = false
                        filter = {
                          expression = "k8s.event.reason = 'ScalingReplicaSet' AND resource.k8s.namespace.name in $k8s.namespace.name AND resource.k8s.cluster.name in $k8s.cluster.name"
                        }
                        functions = [
                        ]
                        group_by = [
                        ]
                        having = {
                        }
                        name = "A"
                        order = [
                        ]
                        signal        = "logs"
                      }
                    }
                  }
                }
              }
            },
          ]
        }
      }
      "1ef215d0-d0f9-46b2-a1e7-81846a7552b5" = {
        kind = "Panel"
        spec = {
          display = {
            name = "Deployments vs Pods"
          }
          links = [
          ]
          plugin = {
            time_series_panel = {
              kind = "signoz/TimeSeriesPanel"
              spec = {
                axes = {
                  is_log_scale = false
                  soft_max     = 0
                  soft_min     = 0
                }
                chart_appearance = {
                  fill_mode          = "none"
                  line_interpolation = "spline"
                  line_style         = "solid"
                  show_points        = false
                  span_gaps = {
                    fill_only_below = false
                  }
                }
                formatting = {
                  decimal_precision = "2"
                  unit              = "none"
                }
                legend = {
                  mode     = "list"
                  position = "bottom"
                }
                visualization = {
                  fill_spans      = false
                  time_preference = "global_time"
                }
              }
            }
          }
          queries = [
            {
              kind = "time_series"
              spec = {
                plugin = {
                  composite_query = {
                    kind = "signoz/CompositeQuery"
                    spec = {
                      queries = [
                        {
                          builder_query = {
                            spec = {
                              logs = {
                                aggregations = [
                                  {
                                    expression = "count()"
                                  },
                                ]
                                disabled = false
                                filter = {
                                  expression = "k8s.object.kind = 'Deployment' AND resource.k8s.namespace.name in $k8s.namespace.name AND resource.k8s.cluster.name in $k8s.cluster.name"
                                }
                                functions = [
                                ]
                                group_by = [
                                ]
                                having = {
                                }
                                legend = "Deployments"
                                name   = "A"
                                order = [
                                ]
                                signal        = "logs"
                              }
                            }
                            type = "builder_query"
                          }
                        },
                        {
                          builder_query = {
                            spec = {
                              logs = {
                                aggregations = [
                                  {
                                    expression = "count()"
                                  },
                                ]
                                disabled = false
                                filter = {
                                  expression = "k8s.object.kind = 'Pod' AND resource.k8s.namespace.name in $k8s.namespace.name AND resource.k8s.cluster.name in $k8s.cluster.name"
                                }
                                functions = [
                                ]
                                group_by = [
                                ]
                                having = {
                                }
                                legend = "Pods"
                                name   = "B"
                                order = [
                                ]
                                signal        = "logs"
                              }
                            }
                            type = "builder_query"
                          }
                        },
                      ]
                    }
                  }
                }
              }
            },
          ]
        }
      }
      "32c9d0bc-eec1-426e-be52-c12f14ca5e4a" = {
        kind = "Panel"
        spec = {
          display = {
            name = "Killing Events"
          }
          links = [
          ]
          plugin = {
            number_panel = {
              kind = "signoz/NumberPanel"
              spec = {
                formatting = {
                  decimal_precision = "2"
                  unit              = "none"
                }
                visualization = {
                  time_preference = "global_time"
                }
              }
            }
          }
          queries = [
            {
              kind = "scalar"
              spec = {
                name = "A"
                plugin = {
                  builder_query = {
                    kind = "signoz/BuilderQuery"
                    spec = {
                      logs = {
                        aggregations = [
                          {
                            expression = "count()"
                          },
                        ]
                        disabled = false
                        filter = {
                          expression = "k8s.event.reason = 'Killing' AND resource.k8s.namespace.name in $k8s.namespace.name AND resource.k8s.cluster.name in $k8s.cluster.name"
                        }
                        functions = [
                        ]
                        group_by = [
                        ]
                        having = {
                        }
                        name = "A"
                        order = [
                        ]
                        signal        = "logs"
                      }
                    }
                  }
                }
              }
            },
          ]
        }
      }
      "65eb8379-0b43-4ecf-9345-58470f3ded4c" = {
        kind = "Panel"
        spec = {
          display = {
            name = "Scheduled Events Count"
          }
          links = [
          ]
          plugin = {
            number_panel = {
              kind = "signoz/NumberPanel"
              spec = {
                formatting = {
                  decimal_precision = "2"
                  unit              = "none"
                }
                visualization = {
                  time_preference = "global_time"
                }
              }
            }
          }
          queries = [
            {
              kind = "scalar"
              spec = {
                name = "A"
                plugin = {
                  builder_query = {
                    kind = "signoz/BuilderQuery"
                    spec = {
                      logs = {
                        aggregations = [
                          {
                            expression = "count()"
                          },
                        ]
                        disabled = false
                        filter = {
                          expression = "k8s.event.reason = 'Scheduled' AND resource.k8s.namespace.name in $k8s.namespace.name AND resource.k8s.cluster.name in $k8s.cluster.name"
                        }
                        functions = [
                        ]
                        group_by = [
                        ]
                        having = {
                        }
                        name = "A"
                        order = [
                        ]
                        signal        = "logs"
                      }
                    }
                  }
                }
              }
            },
          ]
        }
      }
      "673f385a-58d9-4d3b-8a45-22e3766bf512" = {
        kind = "Panel"
        spec = {
          display = {
            name = "Event Count over Time"
          }
          links = [
          ]
          plugin = {
            time_series_panel = {
              kind = "signoz/TimeSeriesPanel"
              spec = {
                axes = {
                  is_log_scale = false
                  soft_max     = 0
                  soft_min     = 0
                }
                chart_appearance = {
                  fill_mode          = "none"
                  line_interpolation = "spline"
                  line_style         = "solid"
                  show_points        = false
                  span_gaps = {
                    fill_only_below = false
                  }
                }
                formatting = {
                  decimal_precision = "2"
                  unit              = "none"
                }
                legend = {
                  mode     = "list"
                  position = "bottom"
                }
                visualization = {
                  fill_spans      = false
                  time_preference = "global_time"
                }
              }
            }
          }
          queries = [
            {
              kind = "time_series"
              spec = {
                name = "A"
                plugin = {
                  builder_query = {
                    kind = "signoz/BuilderQuery"
                    spec = {
                      logs = {
                        aggregations = [
                          {
                            expression = "count()"
                          },
                        ]
                        disabled = false
                        filter = {
                          expression = "resource.k8s.namespace.name in $k8s.namespace.name AND resource.k8s.cluster.name in $k8s.cluster.name"
                        }
                        functions = [
                        ]
                        group_by = [
                        ]
                        having = {
                        }
                        legend = "Events"
                        name   = "A"
                        order = [
                        ]
                        signal        = "logs"
                      }
                    }
                  }
                }
              }
            },
          ]
        }
      }
      "773a7388-75c0-456f-ba63-d72b4c7cebd5" = {
        kind = "Panel"
        spec = {
          display = {
            name = "Scaling Replica Sets over Time"
          }
          links = [
          ]
          plugin = {
            time_series_panel = {
              kind = "signoz/TimeSeriesPanel"
              spec = {
                axes = {
                  is_log_scale = false
                  soft_max     = 0
                  soft_min     = 0
                }
                chart_appearance = {
                  fill_mode          = "none"
                  line_interpolation = "spline"
                  line_style         = "solid"
                  show_points        = false
                  span_gaps = {
                    fill_only_below = false
                  }
                }
                formatting = {
                  decimal_precision = "2"
                  unit              = "none"
                }
                legend = {
                  mode     = "list"
                  position = "bottom"
                }
                visualization = {
                  fill_spans      = false
                  time_preference = "global_time"
                }
              }
            }
          }
          queries = [
            {
              kind = "time_series"
              spec = {
                name = "A"
                plugin = {
                  builder_query = {
                    kind = "signoz/BuilderQuery"
                    spec = {
                      logs = {
                        aggregations = [
                          {
                            expression = "count()"
                          },
                        ]
                        disabled = false
                        filter = {
                          expression = "k8s.event.reason = 'ScalingReplicaSet' AND resource.k8s.namespace.name in $k8s.namespace.name AND resource.k8s.cluster.name in $k8s.cluster.name"
                        }
                        functions = [
                        ]
                        group_by = [
                        ]
                        having = {
                        }
                        legend = "Scaling Replica Sets"
                        name   = "A"
                        order = [
                        ]
                        signal        = "logs"
                      }
                    }
                  }
                }
              }
            },
          ]
        }
      }
      a1d807e0-9afc-4214-a5f1-5820038af207 = {
        kind = "Panel"
        spec = {
          display = {
            name = "Deployments Count"
          }
          links = [
          ]
          plugin = {
            number_panel = {
              kind = "signoz/NumberPanel"
              spec = {
                formatting = {
                  decimal_precision = "2"
                  unit              = "none"
                }
                visualization = {
                  time_preference = "global_time"
                }
              }
            }
          }
          queries = [
            {
              kind = "scalar"
              spec = {
                name = "A"
                plugin = {
                  builder_query = {
                    kind = "signoz/BuilderQuery"
                    spec = {
                      logs = {
                        aggregations = [
                          {
                            expression = "count()"
                          },
                        ]
                        disabled = false
                        filter = {
                          expression = "k8s.object.kind = 'Deployment' AND resource.k8s.namespace.name in $k8s.namespace.name AND resource.k8s.cluster.name in $k8s.cluster.name"
                        }
                        functions = [
                        ]
                        group_by = [
                        ]
                        having = {
                        }
                        name = "A"
                        order = [
                        ]
                        signal        = "logs"
                      }
                    }
                  }
                }
              }
            },
          ]
        }
      }
      aa2462c3-24f0-4275-812c-549b896b7b61 = {
        kind = "Panel"
        spec = {
          display = {
            name = "Deployments Count over Time"
          }
          links = [
          ]
          plugin = {
            time_series_panel = {
              kind = "signoz/TimeSeriesPanel"
              spec = {
                axes = {
                  is_log_scale = false
                  soft_max     = 0
                  soft_min     = 0
                }
                chart_appearance = {
                  fill_mode          = "none"
                  line_interpolation = "spline"
                  line_style         = "solid"
                  show_points        = false
                  span_gaps = {
                    fill_only_below = false
                  }
                }
                formatting = {
                  decimal_precision = "2"
                  unit              = "none"
                }
                legend = {
                  mode     = "list"
                  position = "bottom"
                }
                visualization = {
                  fill_spans      = false
                  time_preference = "global_time"
                }
              }
            }
          }
          queries = [
            {
              kind = "time_series"
              spec = {
                name = "A"
                plugin = {
                  builder_query = {
                    kind = "signoz/BuilderQuery"
                    spec = {
                      logs = {
                        aggregations = [
                          {
                            expression = "count()"
                          },
                        ]
                        disabled = false
                        filter = {
                          expression = "k8s.object.kind = 'Deployment' AND resource.k8s.namespace.name in $k8s.namespace.name AND resource.k8s.cluster.name in $k8s.cluster.name"
                        }
                        functions = [
                        ]
                        group_by = [
                        ]
                        having = {
                        }
                        legend = "Deployments"
                        name   = "A"
                        order = [
                        ]
                        signal        = "logs"
                      }
                    }
                  }
                }
              }
            },
          ]
        }
      }
      afbcdd3b-809c-4a9c-8a3b-705a9347ca2c = {
        kind = "Panel"
        spec = {
          display = {
            name = "Pulled Images Count"
          }
          links = [
          ]
          plugin = {
            number_panel = {
              kind = "signoz/NumberPanel"
              spec = {
                formatting = {
                  decimal_precision = "2"
                  unit              = "none"
                }
                visualization = {
                  time_preference = "global_time"
                }
              }
            }
          }
          queries = [
            {
              kind = "scalar"
              spec = {
                name = "A"
                plugin = {
                  builder_query = {
                    kind = "signoz/BuilderQuery"
                    spec = {
                      logs = {
                        aggregations = [
                          {
                            expression = "count()"
                          },
                        ]
                        disabled = false
                        filter = {
                          expression = "k8s.event.reason = 'Pulled' AND resource.k8s.namespace.name in $k8s.namespace.name AND resource.k8s.cluster.name in $k8s.cluster.name"
                        }
                        functions = [
                        ]
                        group_by = [
                        ]
                        having = {
                        }
                        name = "A"
                        order = [
                        ]
                        signal        = "logs"
                      }
                    }
                  }
                }
              }
            },
          ]
        }
      }
      deb0862e-718d-4bf5-a1d2-6c5f776e169f = {
        kind = "Panel"
        spec = {
          display = {
            name = "Successful Create Events"
          }
          links = [
          ]
          plugin = {
            number_panel = {
              kind = "signoz/NumberPanel"
              spec = {
                formatting = {
                  decimal_precision = "2"
                  unit              = "none"
                }
                visualization = {
                  time_preference = "global_time"
                }
              }
            }
          }
          queries = [
            {
              kind = "scalar"
              spec = {
                name = "A"
                plugin = {
                  builder_query = {
                    kind = "signoz/BuilderQuery"
                    spec = {
                      logs = {
                        aggregations = [
                          {
                            expression = "count()"
                          },
                        ]
                        disabled = false
                        filter = {
                          expression = "k8s.event.reason = 'SuccessfulDelete' AND resource.k8s.namespace.name in $k8s.namespace.name AND resource.k8s.cluster.name in $k8s.cluster.name"
                        }
                        functions = [
                        ]
                        group_by = [
                        ]
                        having = {
                        }
                        name = "A"
                        order = [
                        ]
                        signal        = "logs"
                      }
                    }
                  }
                }
              }
            },
          ]
        }
      }
      e767bb6a-97a8-4d5e-a55b-a37eed2b5613 = {
        kind = "Panel"
        spec = {
          display = {
            name = "Successful Delete Events"
          }
          links = [
          ]
          plugin = {
            number_panel = {
              kind = "signoz/NumberPanel"
              spec = {
                formatting = {
                  decimal_precision = "2"
                  unit              = "none"
                }
                visualization = {
                  time_preference = "global_time"
                }
              }
            }
          }
          queries = [
            {
              kind = "scalar"
              spec = {
                name = "A"
                plugin = {
                  builder_query = {
                    kind = "signoz/BuilderQuery"
                    spec = {
                      logs = {
                        aggregations = [
                          {
                            expression = "count()"
                          },
                        ]
                        disabled = false
                        filter = {
                          expression = "k8s.event.reason = 'SuccessfulDelete' AND resource.k8s.namespace.name in $k8s.namespace.name AND resource.k8s.cluster.name in $k8s.cluster.name"
                        }
                        functions = [
                        ]
                        group_by = [
                        ]
                        having = {
                        }
                        name = "A"
                        order = [
                        ]
                        signal        = "logs"
                      }
                    }
                  }
                }
              }
            },
          ]
        }
      }
      ed16bdcc-b48a-4fff-91a3-25adda6cb2cd = {
        kind = "Panel"
        spec = {
          display = {
            name = "Event Count"
          }
          links = [
          ]
          plugin = {
            number_panel = {
              kind = "signoz/NumberPanel"
              spec = {
                formatting = {
                  decimal_precision = "2"
                  unit              = "none"
                }
                visualization = {
                  time_preference = "global_time"
                }
              }
            }
          }
          queries = [
            {
              kind = "scalar"
              spec = {
                name = "A"
                plugin = {
                  builder_query = {
                    kind = "signoz/BuilderQuery"
                    spec = {
                      logs = {
                        aggregations = [
                          {
                            expression = "count()"
                          },
                        ]
                        disabled = false
                        filter = {
                          expression = "resource.k8s.namespace.name in $k8s.namespace.name AND resource.k8s.cluster.name in $k8s.cluster.name"
                        }
                        functions = [
                        ]
                        group_by = [
                        ]
                        having = {
                        }
                        name = "A"
                        order = [
                        ]
                        signal        = "logs"
                      }
                    }
                  }
                }
              }
            },
          ]
        }
      }
      f94d28e7-34ba-4830-978d-09c09b5c1486 = {
        kind = "Panel"
        spec = {
          display = {
            name = "Pulled Images vs Successfully Created Containers"
          }
          links = [
          ]
          plugin = {
            time_series_panel = {
              kind = "signoz/TimeSeriesPanel"
              spec = {
                axes = {
                  is_log_scale = false
                  soft_max     = 0
                  soft_min     = 0
                }
                chart_appearance = {
                  fill_mode          = "none"
                  line_interpolation = "spline"
                  line_style         = "solid"
                  show_points        = false
                  span_gaps = {
                    fill_only_below = false
                  }
                }
                formatting = {
                  decimal_precision = "2"
                  unit              = "none"
                }
                legend = {
                  mode     = "list"
                  position = "bottom"
                }
                visualization = {
                  fill_spans      = false
                  time_preference = "global_time"
                }
              }
            }
          }
          queries = [
            {
              kind = "time_series"
              spec = {
                plugin = {
                  composite_query = {
                    kind = "signoz/CompositeQuery"
                    spec = {
                      queries = [
                        {
                          builder_query = {
                            spec = {
                              logs = {
                                aggregations = [
                                  {
                                    expression = "count()"
                                  },
                                ]
                                disabled = false
                                filter = {
                                  expression = "k8s.event.reason = 'Pulled' AND resource.k8s.namespace.name in $k8s.namespace.name AND resource.k8s.cluster.name in $k8s.cluster.name"
                                }
                                functions = [
                                ]
                                group_by = [
                                ]
                                having = {
                                }
                                legend = "Pulled Images"
                                name   = "A"
                                order = [
                                ]
                                signal        = "logs"
                              }
                            }
                            type = "builder_query"
                          }
                        },
                        {
                          builder_query = {
                            spec = {
                              logs = {
                                aggregations = [
                                  {
                                    expression = "count()"
                                  },
                                ]
                                disabled = false
                                filter = {
                                  expression = "k8s.event.reason = 'SuccessfulCreate' AND resource.k8s.namespace.name in $k8s.namespace.name AND resource.k8s.cluster.name in $k8s.cluster.name"
                                }
                                functions = [
                                ]
                                group_by = [
                                ]
                                having = {
                                }
                                legend = "Created Pods"
                                name   = "B"
                                order = [
                                ]
                                signal        = "logs"
                              }
                            }
                            type = "builder_query"
                          }
                        },
                      ]
                    }
                  }
                }
              }
            },
          ]
        }
      }
    }
    variables = [
      {
        list_variable = {
          kind = "ListVariable"
          spec = {
            allow_all_value = false
            allow_multiple  = false
            display = {
              description = "The k8s cluster id"
              name        = "k8s.cluster.name"
            }
            name = "k8s.cluster.name"
            plugin = {
              dynamic_variable = {
                kind = "signoz/DynamicVariable"
                spec = {
                  name   = "k8s.cluster.name"
                  signal = "all"
                }
              }
            }
            sort = "none"
          }
        }
      },
      {
        list_variable = {
          kind = "ListVariable"
          spec = {
            allow_all_value = false
            allow_multiple  = false
            display = {
              description = "The k8s namespace"
              name        = "k8s.namespace.name"
            }
            name = "k8s.namespace.name"
            plugin = {
              dynamic_variable = {
                kind = "signoz/DynamicVariable"
                spec = {
                  name   = "k8s.namespace.name"
                  signal = "all"
                }
              }
            }
            sort = "none"
          }
        }
      },
    ]
  }
  tags = [
    {
      key   = "tag"
      value = "k8s"
    },
    {
      key   = "tag"
      value = "cloud"
    },
    {
      key   = "tag"
      value = "events"
    },
  ]
}

resource "signoz_dashboard" "k8s_host_metrics" {
  name           = "host-metrics-k8s-7mswa7rd"
  schema_version = "v6"
  spec = {
    display = {
      description = "This dashboard uses the system metrics collected from the `hostmetrics` receiver to show CPU, Memory, Disk, Network and Filesystem usage"
      name        = "Host Metrics (k8s)"
    }
    layouts = [
      {
        grid = {
          kind = "Grid"
          spec = {
            display = {
              collapse = {
                open = true
              }
              title = "Overview"
            }
            items = [
              {
                content = {
                  ref = "#/spec/panels/b33f0bad-e623-4c2b-b854-12270f211690"
                }
                height = 3
                width  = 3
                x      = 0
                y      = 0
              },
              {
                content = {
                  ref = "#/spec/panels/5d89be47-9c43-4b0f-96c0-1dc72dbfa356"
                }
                height = 3
                width  = 3
                x      = 3
                y      = 0
              },
              {
                content = {
                  ref = "#/spec/panels/0ce16128-ff8d-479d-8db2-10ac8fb47bc2"
                }
                height = 3
                width  = 3
                x      = 6
                y      = 0
              },
              {
                content = {
                  ref = "#/spec/panels/f9df830b-cb02-4e70-b72a-f89a2e4f8196"
                }
                height = 3
                width  = 3
                x      = 9
                y      = 0
              },
            ]
          }
        }
      },
      {
        grid = {
          kind = "Grid"
          spec = {
            display = {
              collapse = {
                open = true
              }
              title = "Resources"
            }
            items = [
              {
                content = {
                  ref = "#/spec/panels/5f43aa0f-cc5f-4a29-9cd7-dd0505db35a9"
                }
                height = 6
                width  = 6
                x      = 0
                y      = 0
              },
              {
                content = {
                  ref = "#/spec/panels/ea1d1541-7787-4e09-8e5b-69be7f6af1ce"
                }
                height = 6
                width  = 6
                x      = 6
                y      = 0
              },
              {
                content = {
                  ref = "#/spec/panels/f4d0972c-6d7b-44b0-b813-8063f0bb7410"
                }
                height = 6
                width  = 6
                x      = 0
                y      = 6
              },
              {
                content = {
                  ref = "#/spec/panels/fbc102af-88fb-488f-9c7a-c89551593c9e"
                }
                height = 6
                width  = 6
                x      = 6
                y      = 6
              },
              {
                content = {
                  ref = "#/spec/panels/d497c2d7-372e-4670-9917-9bcbc25d0487"
                }
                height = 6
                width  = 6
                x      = 0
                y      = 12
              },
              {
                content = {
                  ref = "#/spec/panels/45a54f00-081e-42b2-8134-c3848f4ac19e"
                }
                height = 6
                width  = 6
                x      = 6
                y      = 12
              },
            ]
          }
        }
      },
      {
        grid = {
          kind = "Grid"
          spec = {
            display = {
              collapse = {
                open = true
              }
              title = "System"
            }
            items = [
              {
                content = {
                  ref = "#/spec/panels/24e4d4c3-4ada-4e9d-bc3b-e19d314daa27"
                }
                height = 6
                width  = 6
                x      = 0
                y      = 0
              },
            ]
          }
        }
      },
      {
        grid = {
          kind = "Grid"
          spec = {
            display = {
              collapse = {
                open = true
              }
              title = "Network"
            }
            items = [
              {
                content = {
                  ref = "#/spec/panels/3d74094e-241b-4560-9128-abb1af79ae3c"
                }
                height = 6
                width  = 6
                x      = 0
                y      = 0
              },
              {
                content = {
                  ref = "#/spec/panels/9a8ac524-afe4-457a-b17a-45f11c4f0fcf"
                }
                height = 6
                width  = 6
                x      = 6
                y      = 0
              },
              {
                content = {
                  ref = "#/spec/panels/f42a3a42-8099-4be9-a6b5-1528d1f1bdfa"
                }
                height = 6
                width  = 6
                x      = 0
                y      = 6
              },
              {
                content = {
                  ref = "#/spec/panels/e796af4a-abe8-4ff4-9bba-0b7eb81c022a"
                }
                height = 6
                width  = 6
                x      = 6
                y      = 6
              },
              {
                content = {
                  ref = "#/spec/panels/9abc2374-d1ef-4ad6-958b-2355addcb245"
                }
                height = 6
                width  = 12
                x      = 0
                y      = 12
              },
            ]
          }
        }
      },
      {
        grid = {
          kind = "Grid"
          spec = {
            display = {
              collapse = {
                open = true
              }
              title = "Disk"
            }
            items = [
              {
                content = {
                  ref = "#/spec/panels/a9013487-0479-4a09-a613-b3fc20e4d666"
                }
                height = 6
                width  = 6
                x      = 0
                y      = 0
              },
              {
                content = {
                  ref = "#/spec/panels/3f186d43-6b86-4b71-962b-4ccddd8d7481"
                }
                height = 6
                width  = 6
                x      = 6
                y      = 0
              },
              {
                content = {
                  ref = "#/spec/panels/e2683847-faa3-42f6-bb3c-4367a3e76294"
                }
                height = 6
                width  = 6
                x      = 0
                y      = 6
              },
              {
                content = {
                  ref = "#/spec/panels/64f1ea50-0c34-4e43-9912-0d9547e2e436"
                }
                height = 6
                width  = 6
                x      = 6
                y      = 6
              },
            ]
          }
        }
      },
      {
        grid = {
          kind = "Grid"
          spec = {
            display = {
              collapse = {
                open = true
              }
              title = "File system"
            }
            items = [
              {
                content = {
                  ref = "#/spec/panels/92dd7aae-95eb-48ae-9d3a-6e062d468dab"
                }
                height = 8
                width  = 12
                x      = 0
                y      = 0
              },
              {
                content = {
                  ref = "#/spec/panels/f984a994-50b8-4c1e-83b4-9a10ca128657"
                }
                height = 7
                width  = 12
                x      = 0
                y      = 8
              },
            ]
          }
        }
      },
    ]
    links = [
    ]
    panels = {
      "0ce16128-ff8d-479d-8db2-10ac8fb47bc2" = {
        kind = "Panel"
        spec = {
          display = {
            name = "Memory Used"
          }
          links = [
          ]
          plugin = {
            number_panel = {
              kind = "signoz/NumberPanel"
              spec = {
                formatting = {
                  decimal_precision = "2"
                  unit              = "bytes"
                }
                visualization = {
                  time_preference = "global_time"
                }
              }
            }
          }
          queries = [
            {
              kind = "scalar"
              spec = {
                name = "A"
                plugin = {
                  builder_query = {
                    kind = "signoz/BuilderQuery"
                    spec = {
                      metrics = {
                        aggregations = [
                          {
                            metric_name       = "k8s.node.memory.usage"
                            reduce_to         = "avg"
                            space_aggregation = "sum"
                            time_aggregation  = "avg"
                          },
                        ]
                        disabled = false
                        filter = {
                          expression = "k8s.node.name IN $k8s.node.name k8s.cluster.name in $k8s.cluster.name"
                        }
                        functions = [
                        ]
                        group_by = [
                        ]
                        having = {
                        }
                        name = "A"
                        order = [
                        ]
                        signal        = "metrics"
                      }
                    }
                  }
                }
              }
            },
          ]
        }
      }
      "24e4d4c3-4ada-4e9d-bc3b-e19d314daa27" = {
        kind = "Panel"
        spec = {
          display = {
            name = "System Load Average"
          }
          links = [
          ]
          plugin = {
            time_series_panel = {
              kind = "signoz/TimeSeriesPanel"
              spec = {
                axes = {
                  is_log_scale = false
                  soft_max     = 0
                  soft_min     = 0
                }
                chart_appearance = {
                  fill_mode          = "none"
                  line_interpolation = "spline"
                  line_style         = "solid"
                  show_points        = false
                  span_gaps = {
                    fill_only_below = false
                  }
                }
                formatting = {
                  decimal_precision = "2"
                  unit              = "none"
                }
                legend = {
                  mode     = "list"
                  position = "bottom"
                }
                visualization = {
                  fill_spans      = false
                  time_preference = "global_time"
                }
              }
            }
          }
          queries = [
            {
              kind = "time_series"
              spec = {
                plugin = {
                  composite_query = {
                    kind = "signoz/CompositeQuery"
                    spec = {
                      queries = [
                        {
                          builder_query = {
                            spec = {
                              metrics = {
                                aggregations = [
                                  {
                                    metric_name       = "system.cpu.load_average.1m"
                                    reduce_to         = "avg"
                                    space_aggregation = "sum"
                                    time_aggregation  = "avg"
                                  },
                                ]
                                disabled = false
                                filter = {
                                  expression = "k8s.node.name IN $k8s.node.name k8s.cluster.name in $k8s.cluster.name"
                                }
                                functions = [
                                ]
                                group_by = [
                                ]
                                having = {
                                }
                                legend = "1m"
                                limit  = 30
                                name   = "A"
                                order = [
                                ]
                                signal        = "metrics"
                              }
                            }
                            type = "builder_query"
                          }
                        },
                        {
                          builder_query = {
                            spec = {
                              metrics = {
                                aggregations = [
                                  {
                                    metric_name       = "system.cpu.load_average.5m"
                                    reduce_to         = "avg"
                                    space_aggregation = "sum"
                                    time_aggregation  = "avg"
                                  },
                                ]
                                disabled = false
                                filter = {
                                  expression = "k8s.node.name IN $k8s.node.name k8s.cluster.name in $k8s.cluster.name"
                                }
                                functions = [
                                ]
                                group_by = [
                                ]
                                having = {
                                }
                                legend = "5m"
                                limit  = 30
                                name   = "B"
                                order = [
                                ]
                                signal        = "metrics"
                              }
                            }
                            type = "builder_query"
                          }
                        },
                        {
                          builder_query = {
                            spec = {
                              metrics = {
                                aggregations = [
                                  {
                                    metric_name       = "system.cpu.load_average.15m"
                                    reduce_to         = "avg"
                                    space_aggregation = "sum"
                                    time_aggregation  = "avg"
                                  },
                                ]
                                disabled = false
                                filter = {
                                  expression = "k8s.node.name IN $k8s.node.name k8s.cluster.name in $k8s.cluster.name"
                                }
                                functions = [
                                ]
                                group_by = [
                                ]
                                having = {
                                }
                                legend = "15m"
                                limit  = 30
                                name   = "C"
                                order = [
                                ]
                                signal        = "metrics"
                              }
                            }
                            type = "builder_query"
                          }
                        },
                      ]
                    }
                  }
                }
              }
            },
          ]
        }
      }
      "3d74094e-241b-4560-9128-abb1af79ae3c" = {
        kind = "Panel"
        spec = {
          display = {
            name = "Network usage (bytes)"
          }
          links = [
          ]
          plugin = {
            time_series_panel = {
              kind = "signoz/TimeSeriesPanel"
              spec = {
                axes = {
                  is_log_scale = false
                  soft_max     = 0
                  soft_min     = 0
                }
                chart_appearance = {
                  fill_mode          = "none"
                  line_interpolation = "spline"
                  line_style         = "solid"
                  show_points        = false
                  span_gaps = {
                    fill_only_below = false
                  }
                }
                formatting = {
                  decimal_precision = "2"
                  unit              = "bytes"
                }
                legend = {
                  mode     = "list"
                  position = "bottom"
                }
                visualization = {
                  fill_spans      = false
                  time_preference = "global_time"
                }
              }
            }
          }
          queries = [
            {
              kind = "time_series"
              spec = {
                name = "A"
                plugin = {
                  builder_query = {
                    kind = "signoz/BuilderQuery"
                    spec = {
                      metrics = {
                        aggregations = [
                          {
                            metric_name       = "system.network.io"
                            reduce_to         = "avg"
                            space_aggregation = "sum"
                            time_aggregation  = "rate"
                          },
                        ]
                        disabled = false
                        filter = {
                          expression = "k8s.node.name IN $k8s.node.name k8s.cluster.name in $k8s.cluster.name"
                        }
                        functions = [
                        ]
                        group_by = [
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "direction"
                          },
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "device"
                          },
                        ]
                        having = {
                          expression = "sum(system.network.io) > 0"
                        }
                        legend = "{{device}}::{{direction}}"
                        limit  = 30
                        name   = "A"
                        order = [
                        ]
                        signal        = "metrics"
                      }
                    }
                  }
                }
              }
            },
          ]
        }
      }
      "3f186d43-6b86-4b71-962b-4ccddd8d7481" = {
        kind = "Panel"
        spec = {
          display = {
            name = "System disk operations/s"
          }
          links = [
          ]
          plugin = {
            time_series_panel = {
              kind = "signoz/TimeSeriesPanel"
              spec = {
                axes = {
                  is_log_scale = false
                  soft_max     = 0
                  soft_min     = 0
                }
                chart_appearance = {
                  fill_mode          = "none"
                  line_interpolation = "spline"
                  line_style         = "solid"
                  show_points        = false
                  span_gaps = {
                    fill_only_below = false
                  }
                }
                formatting = {
                  decimal_precision = "2"
                  unit              = "short"
                }
                legend = {
                  mode     = "list"
                  position = "bottom"
                }
                visualization = {
                  fill_spans      = false
                  time_preference = "global_time"
                }
              }
            }
          }
          queries = [
            {
              kind = "time_series"
              spec = {
                name = "A"
                plugin = {
                  builder_query = {
                    kind = "signoz/BuilderQuery"
                    spec = {
                      metrics = {
                        aggregations = [
                          {
                            metric_name       = "system.disk.operations"
                            reduce_to         = "avg"
                            space_aggregation = "sum"
                            time_aggregation  = "rate"
                          },
                        ]
                        disabled = false
                        filter = {
                          expression = "k8s.node.name IN $k8s.node.name k8s.cluster.name in $k8s.cluster.name"
                        }
                        functions = [
                        ]
                        group_by = [
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "direction"
                          },
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "device"
                          },
                        ]
                        having = {
                          expression = "sum(system.disk.operations) > 0"
                        }
                        legend = "{{device}}::{{direction}}"
                        limit  = 30
                        name   = "A"
                        order = [
                        ]
                        signal        = "metrics"
                      }
                    }
                  }
                }
              }
            },
          ]
        }
      }
      "45a54f00-081e-42b2-8134-c3848f4ac19e" = {
        kind = "Panel"
        spec = {
          display = {
            name = "Memory Usage by Pod"
          }
          links = [
          ]
          plugin = {
            time_series_panel = {
              kind = "signoz/TimeSeriesPanel"
              spec = {
                axes = {
                  is_log_scale = false
                  soft_max     = 0
                  soft_min     = 0
                }
                chart_appearance = {
                  fill_mode          = "none"
                  line_interpolation = "spline"
                  line_style         = "solid"
                  show_points        = false
                  span_gaps = {
                    fill_only_below = false
                  }
                }
                formatting = {
                  decimal_precision = "2"
                  unit              = "bytes"
                }
                legend = {
                  mode     = "list"
                  position = "bottom"
                }
                visualization = {
                  fill_spans      = false
                  time_preference = "global_time"
                }
              }
            }
          }
          queries = [
            {
              kind = "time_series"
              spec = {
                name = "A"
                plugin = {
                  builder_query = {
                    kind = "signoz/BuilderQuery"
                    spec = {
                      metrics = {
                        aggregations = [
                          {
                            metric_name       = "k8s.pod.memory.usage"
                            reduce_to         = "avg"
                            space_aggregation = "sum"
                            time_aggregation  = "avg"
                          },
                        ]
                        disabled = false
                        filter = {
                          expression = "k8s.node.name IN $k8s.node.name k8s.cluster.name in $k8s.cluster.name"
                        }
                        functions = [
                        ]
                        group_by = [
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "k8s.pod.name"
                          },
                        ]
                        having = {
                        }
                        legend = "{{k8s.pod.name}}"
                        limit  = 30
                        name   = "A"
                        order = [
                        ]
                        signal        = "metrics"
                      }
                    }
                  }
                }
              }
            },
          ]
        }
      }
      "5d89be47-9c43-4b0f-96c0-1dc72dbfa356" = {
        kind = "Panel"
        spec = {
          display = {
            description = "Available CPU for Node"
            name        = "Allocatable CPU"
          }
          links = [
          ]
          plugin = {
            number_panel = {
              kind = "signoz/NumberPanel"
              spec = {
                formatting = {
                  decimal_precision = "2"
                  unit              = "none"
                }
                visualization = {
                  time_preference = "global_time"
                }
              }
            }
          }
          queries = [
            {
              kind = "scalar"
              spec = {
                name = "A"
                plugin = {
                  builder_query = {
                    kind = "signoz/BuilderQuery"
                    spec = {
                      metrics = {
                        aggregations = [
                          {
                            metric_name       = "k8s.node.allocatable_cpu"
                            reduce_to         = "avg"
                            space_aggregation = "avg"
                            time_aggregation  = "avg"
                          },
                        ]
                        disabled = false
                        filter = {
                          expression = "k8s.node.name IN $k8s.node.name k8s.cluster.name in $k8s.cluster.name"
                        }
                        functions = [
                        ]
                        group_by = [
                        ]
                        having = {
                        }
                        name = "A"
                        order = [
                        ]
                        signal        = "metrics"
                      }
                    }
                  }
                }
              }
            },
          ]
        }
      }
      "5f43aa0f-cc5f-4a29-9cd7-dd0505db35a9" = {
        kind = "Panel"
        spec = {
          display = {
            name = "CPU Usage"
          }
          links = [
          ]
          plugin = {
            time_series_panel = {
              kind = "signoz/TimeSeriesPanel"
              spec = {
                axes = {
                  is_log_scale = false
                  soft_max     = 0
                  soft_min     = 0
                }
                chart_appearance = {
                  fill_mode          = "none"
                  line_interpolation = "spline"
                  line_style         = "solid"
                  show_points        = false
                  span_gaps = {
                    fill_only_below = false
                  }
                }
                formatting = {
                  decimal_precision = "2"
                  unit              = "percentunit"
                }
                legend = {
                  mode     = "list"
                  position = "bottom"
                }
                visualization = {
                  fill_spans      = false
                  time_preference = "global_time"
                }
              }
            }
          }
          queries = [
            {
              kind = "time_series"
              spec = {
                plugin = {
                  composite_query = {
                    kind = "signoz/CompositeQuery"
                    spec = {
                      queries = [
                        {
                          builder_query = {
                            spec = {
                              metrics = {
                                aggregations = [
                                  {
                                    metric_name       = "system.cpu.time"
                                    reduce_to         = "avg"
                                    space_aggregation = "sum"
                                    time_aggregation  = "rate"
                                  },
                                ]
                                disabled = true
                                filter = {
                                  expression = "k8s.node.name IN $k8s.node.name k8s.cluster.name in $k8s.cluster.name"
                                }
                                functions = [
                                ]
                                group_by = [
                                  {
                                    field_context   = "attribute"
                                    field_data_type = "string"
                                    name            = "state"
                                  },
                                ]
                                having = {
                                }
                                legend = "{{state}}"
                                name   = "A"
                                order = [
                                ]
                                signal        = "metrics"
                              }
                            }
                            type = "builder_query"
                          }
                        },
                        {
                          builder_query = {
                            spec = {
                              metrics = {
                                aggregations = [
                                  {
                                    metric_name       = "system.cpu.time"
                                    reduce_to         = "avg"
                                    space_aggregation = "sum"
                                    time_aggregation  = "rate"
                                  },
                                ]
                                disabled = true
                                filter = {
                                  expression = "k8s.node.name IN $k8s.node.name k8s.cluster.name in $k8s.cluster.name"
                                }
                                functions = [
                                ]
                                group_by = [
                                ]
                                having = {
                                }
                                legend = "{{state}}"
                                name   = "B"
                                order = [
                                ]
                                signal        = "metrics"
                              }
                            }
                            type = "builder_query"
                          }
                        },
                        {
                          builder_formula = {
                            spec = {
                              disabled   = false
                              expression = "A/B"
                              having = {
                              }
                              legend = "{{state}}"
                              name   = "F1"
                            }
                            type = "builder_formula"
                          }
                        },
                      ]
                    }
                  }
                }
              }
            },
          ]
        }
      }
      "64f1ea50-0c34-4e43-9912-0d9547e2e436" = {
        kind = "Panel"
        spec = {
          display = {
            description = "The queue size of pending I/O operations."
            name        = "Queue size"
          }
          links = [
          ]
          plugin = {
            time_series_panel = {
              kind = "signoz/TimeSeriesPanel"
              spec = {
                axes = {
                  is_log_scale = false
                  soft_max     = 0
                  soft_min     = 0
                }
                chart_appearance = {
                  fill_mode          = "none"
                  line_interpolation = "spline"
                  line_style         = "solid"
                  show_points        = false
                  span_gaps = {
                    fill_only_below = false
                  }
                }
                formatting = {
                  decimal_precision = "2"
                  unit              = "short"
                }
                legend = {
                  mode     = "list"
                  position = "bottom"
                }
                visualization = {
                  fill_spans      = false
                  time_preference = "global_time"
                }
              }
            }
          }
          queries = [
            {
              kind = "time_series"
              spec = {
                name = "A"
                plugin = {
                  builder_query = {
                    kind = "signoz/BuilderQuery"
                    spec = {
                      metrics = {
                        aggregations = [
                          {
                            metric_name       = "system.disk.pending_operations"
                            reduce_to         = "avg"
                            space_aggregation = "sum"
                            time_aggregation  = "max"
                          },
                        ]
                        disabled = false
                        filter = {
                          expression = "k8s.node.name IN $k8s.node.name k8s.cluster.name in $k8s.cluster.name"
                        }
                        functions = [
                        ]
                        group_by = [
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "device"
                          },
                        ]
                        having = {
                          expression = "sum(system.disk.pending_operations) > 0"
                        }
                        legend = "{{device}}"
                        name   = "A"
                        order = [
                        ]
                        signal        = "metrics"
                      }
                    }
                  }
                }
              }
            },
          ]
        }
      }
      "92dd7aae-95eb-48ae-9d3a-6e062d468dab" = {
        kind = "Panel"
        spec = {
          display = {
            name = "File system usage"
          }
          links = [
          ]
          plugin = {
            table_panel = {
              kind = "signoz/TablePanel"
              spec = {
                formatting = {
                  column_units = {
                    A = "bytes"
                  }
                  decimal_precision = "2"
                }
                visualization = {
                  time_preference = "global_time"
                }
              }
            }
          }
          queries = [
            {
              kind = "scalar"
              spec = {
                name = "A"
                plugin = {
                  builder_query = {
                    kind = "signoz/BuilderQuery"
                    spec = {
                      metrics = {
                        aggregations = [
                          {
                            metric_name       = "system.filesystem.usage"
                            reduce_to         = "avg"
                            space_aggregation = "sum"
                            time_aggregation  = "rate"
                          },
                        ]
                        disabled = false
                        filter = {
                          expression = "k8s.node.name IN $k8s.node.name k8s.cluster.name in $k8s.cluster.name"
                        }
                        functions = [
                        ]
                        group_by = [
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "device"
                          },
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "mountpoint"
                          },
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "state"
                          },
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "type"
                          },
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "mode"
                          },
                        ]
                        having = {
                        }
                        legend = "usage"
                        limit  = 30
                        name   = "A"
                        order = [
                        ]
                        signal        = "metrics"
                      }
                    }
                  }
                }
              }
            },
          ]
        }
      }
      "9a8ac524-afe4-457a-b17a-45f11c4f0fcf" = {
        kind = "Panel"
        spec = {
          display = {
            name = "Network usage (packet/s)"
          }
          links = [
          ]
          plugin = {
            time_series_panel = {
              kind = "signoz/TimeSeriesPanel"
              spec = {
                axes = {
                  is_log_scale = false
                  soft_max     = 0
                  soft_min     = 0
                }
                chart_appearance = {
                  fill_mode          = "none"
                  line_interpolation = "spline"
                  line_style         = "solid"
                  show_points        = false
                  span_gaps = {
                    fill_only_below = false
                  }
                }
                formatting = {
                  decimal_precision = "2"
                  unit              = "pps"
                }
                legend = {
                  mode     = "list"
                  position = "bottom"
                }
                visualization = {
                  fill_spans      = false
                  time_preference = "global_time"
                }
              }
            }
          }
          queries = [
            {
              kind = "time_series"
              spec = {
                name = "A"
                plugin = {
                  builder_query = {
                    kind = "signoz/BuilderQuery"
                    spec = {
                      metrics = {
                        aggregations = [
                          {
                            metric_name       = "system.network.packets"
                            reduce_to         = "avg"
                            space_aggregation = "sum"
                            time_aggregation  = "rate"
                          },
                        ]
                        disabled = false
                        filter = {
                          expression = "k8s.node.name IN $k8s.node.name k8s.cluster.name in $k8s.cluster.name"
                        }
                        functions = [
                        ]
                        group_by = [
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "direction"
                          },
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "device"
                          },
                        ]
                        having = {
                        }
                        legend = "{{device}}::{{direction}}"
                        limit  = 30
                        name   = "A"
                        order = [
                        ]
                        signal        = "metrics"
                      }
                    }
                  }
                }
              }
            },
          ]
        }
      }
      "9abc2374-d1ef-4ad6-958b-2355addcb245" = {
        kind = "Panel"
        spec = {
          display = {
            name = "Network connections"
          }
          links = [
          ]
          plugin = {
            time_series_panel = {
              kind = "signoz/TimeSeriesPanel"
              spec = {
                axes = {
                  is_log_scale = false
                  soft_max     = 0
                  soft_min     = 0
                }
                chart_appearance = {
                  fill_mode          = "none"
                  line_interpolation = "spline"
                  line_style         = "solid"
                  show_points        = false
                  span_gaps = {
                    fill_only_below = false
                  }
                }
                formatting = {
                  decimal_precision = "2"
                  unit              = "short"
                }
                legend = {
                  mode     = "list"
                  position = "bottom"
                }
                visualization = {
                  fill_spans      = false
                  time_preference = "global_time"
                }
              }
            }
          }
          queries = [
            {
              kind = "time_series"
              spec = {
                name = "A"
                plugin = {
                  builder_query = {
                    kind = "signoz/BuilderQuery"
                    spec = {
                      metrics = {
                        aggregations = [
                          {
                            metric_name       = "system.network.connections"
                            reduce_to         = "avg"
                            space_aggregation = "sum"
                            time_aggregation  = "avg"
                          },
                        ]
                        disabled = false
                        filter = {
                          expression = "k8s.node.name IN $k8s.node.name k8s.cluster.name in $k8s.cluster.name"
                        }
                        functions = [
                        ]
                        group_by = [
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "protocol"
                          },
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "state"
                          },
                        ]
                        having = {
                        }
                        legend = "{{protocol}}::{{state}}"
                        limit  = 30
                        name   = "A"
                        order = [
                        ]
                        signal        = "metrics"
                      }
                    }
                  }
                }
              }
            },
          ]
        }
      }
      a9013487-0479-4a09-a613-b3fc20e4d666 = {
        kind = "Panel"
        spec = {
          display = {
            name = "System disk io (bytes transferred)"
          }
          links = [
          ]
          plugin = {
            time_series_panel = {
              kind = "signoz/TimeSeriesPanel"
              spec = {
                axes = {
                  is_log_scale = false
                  soft_max     = 0
                  soft_min     = 0
                }
                chart_appearance = {
                  fill_mode          = "none"
                  line_interpolation = "spline"
                  line_style         = "solid"
                  show_points        = false
                  span_gaps = {
                    fill_only_below = false
                  }
                }
                formatting = {
                  decimal_precision = "2"
                  unit              = "bytes"
                }
                legend = {
                  mode     = "list"
                  position = "bottom"
                }
                visualization = {
                  fill_spans      = false
                  time_preference = "global_time"
                }
              }
            }
          }
          queries = [
            {
              kind = "time_series"
              spec = {
                name = "A"
                plugin = {
                  builder_query = {
                    kind = "signoz/BuilderQuery"
                    spec = {
                      metrics = {
                        aggregations = [
                          {
                            metric_name       = "system.disk.io"
                            reduce_to         = "avg"
                            space_aggregation = "sum"
                            time_aggregation  = "rate"
                          },
                        ]
                        disabled = false
                        filter = {
                          expression = "k8s.node.name IN $k8s.node.name k8s.cluster.name in $k8s.cluster.name"
                        }
                        functions = [
                        ]
                        group_by = [
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "direction"
                          },
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "device"
                          },
                        ]
                        having = {
                          expression = "sum(system.disk.io) > 0"
                        }
                        legend = "{{device}}::{{direction}}"
                        limit  = 30
                        name   = "A"
                        order = [
                        ]
                        signal        = "metrics"
                      }
                    }
                  }
                }
              }
            },
          ]
        }
      }
      b33f0bad-e623-4c2b-b854-12270f211690 = {
        kind = "Panel"
        spec = {
          display = {
            description = "Node CPU utilization"
            name        = "CPU Used"
          }
          links = [
          ]
          plugin = {
            number_panel = {
              kind = "signoz/NumberPanel"
              spec = {
                formatting = {
                  decimal_precision = "2"
                  unit              = "none"
                }
                visualization = {
                  time_preference = "global_time"
                }
              }
            }
          }
          queries = [
            {
              kind = "scalar"
              spec = {
                name = "A"
                plugin = {
                  builder_query = {
                    kind = "signoz/BuilderQuery"
                    spec = {
                      metrics = {
                        aggregations = [
                          {
                            metric_name       = "k8s.node.cpu.usage"
                            reduce_to         = "avg"
                            space_aggregation = "avg"
                            time_aggregation  = "avg"
                          },
                        ]
                        disabled = false
                        filter = {
                          expression = "k8s.node.name IN $k8s.node.name k8s.cluster.name in $k8s.cluster.name"
                        }
                        functions = [
                        ]
                        group_by = [
                        ]
                        having = {
                        }
                        name = "A"
                        order = [
                        ]
                        signal        = "metrics"
                      }
                    }
                  }
                }
              }
            },
          ]
        }
      }
      d497c2d7-372e-4670-9917-9bcbc25d0487 = {
        kind = "Panel"
        spec = {
          display = {
            name = "CPU Usage by Pod"
          }
          links = [
          ]
          plugin = {
            time_series_panel = {
              kind = "signoz/TimeSeriesPanel"
              spec = {
                axes = {
                  is_log_scale = false
                  soft_max     = 0
                  soft_min     = 0
                }
                chart_appearance = {
                  fill_mode          = "none"
                  line_interpolation = "spline"
                  line_style         = "solid"
                  show_points        = false
                  span_gaps = {
                    fill_only_below = false
                  }
                }
                formatting = {
                  decimal_precision = "2"
                  unit              = "none"
                }
                legend = {
                  mode     = "list"
                  position = "bottom"
                }
                visualization = {
                  fill_spans      = false
                  time_preference = "global_time"
                }
              }
            }
          }
          queries = [
            {
              kind = "time_series"
              spec = {
                name = "A"
                plugin = {
                  builder_query = {
                    kind = "signoz/BuilderQuery"
                    spec = {
                      metrics = {
                        aggregations = [
                          {
                            metric_name       = "k8s.pod.cpu.usage"
                            reduce_to         = "avg"
                            space_aggregation = "avg"
                            time_aggregation  = "avg"
                          },
                        ]
                        disabled = false
                        filter = {
                          expression = "k8s.node.name IN $k8s.node.name k8s.cluster.name in $k8s.cluster.name"
                        }
                        functions = [
                        ]
                        group_by = [
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "k8s.pod.name"
                          },
                        ]
                        having = {
                        }
                        legend = "{{k8s.pod.name}}"
                        limit  = 30
                        name   = "A"
                        order = [
                        ]
                        signal        = "metrics"
                      }
                    }
                  }
                }
              }
            },
          ]
        }
      }
      e2683847-faa3-42f6-bb3c-4367a3e76294 = {
        kind = "Panel"
        spec = {
          display = {
            description = "Time spent in disk operations."
            name        = "Disk operations time"
          }
          links = [
          ]
          plugin = {
            time_series_panel = {
              kind = "signoz/TimeSeriesPanel"
              spec = {
                axes = {
                  is_log_scale = false
                  soft_max     = 0
                  soft_min     = 0
                }
                chart_appearance = {
                  fill_mode          = "none"
                  line_interpolation = "spline"
                  line_style         = "solid"
                  show_points        = false
                  span_gaps = {
                    fill_only_below = false
                  }
                }
                formatting = {
                  decimal_precision = "2"
                  unit              = "s"
                }
                legend = {
                  mode     = "list"
                  position = "bottom"
                }
                visualization = {
                  fill_spans      = false
                  time_preference = "global_time"
                }
              }
            }
          }
          queries = [
            {
              kind = "time_series"
              spec = {
                name = "A"
                plugin = {
                  builder_query = {
                    kind = "signoz/BuilderQuery"
                    spec = {
                      metrics = {
                        aggregations = [
                          {
                            metric_name       = "system.disk.operation_time"
                            reduce_to         = "avg"
                            space_aggregation = "sum"
                            time_aggregation  = "rate"
                          },
                        ]
                        disabled = false
                        filter = {
                          expression = "k8s.node.name IN $k8s.node.name k8s.cluster.name in $k8s.cluster.name"
                        }
                        functions = [
                        ]
                        group_by = [
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "device"
                          },
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "direction"
                          },
                        ]
                        having = {
                          expression = "sum(system.disk.operation_time) > 0"
                        }
                        legend = "{{device}}::{{direction}}"
                        name   = "A"
                        order = [
                        ]
                        signal        = "metrics"
                      }
                    }
                  }
                }
              }
            },
          ]
        }
      }
      e796af4a-abe8-4ff4-9bba-0b7eb81c022a = {
        kind = "Panel"
        spec = {
          display = {
            name = "Network drops"
          }
          links = [
          ]
          plugin = {
            time_series_panel = {
              kind = "signoz/TimeSeriesPanel"
              spec = {
                axes = {
                  is_log_scale = false
                  soft_max     = 0
                  soft_min     = 0
                }
                chart_appearance = {
                  fill_mode          = "none"
                  line_interpolation = "spline"
                  line_style         = "solid"
                  show_points        = false
                  span_gaps = {
                    fill_only_below = false
                  }
                }
                formatting = {
                  decimal_precision = "2"
                  unit              = "short"
                }
                legend = {
                  mode     = "list"
                  position = "bottom"
                }
                visualization = {
                  fill_spans      = false
                  time_preference = "global_time"
                }
              }
            }
          }
          queries = [
            {
              kind = "time_series"
              spec = {
                name = "A"
                plugin = {
                  builder_query = {
                    kind = "signoz/BuilderQuery"
                    spec = {
                      metrics = {
                        aggregations = [
                          {
                            metric_name       = "system.network.dropped"
                            reduce_to         = "avg"
                            space_aggregation = "sum"
                            time_aggregation  = "rate"
                          },
                        ]
                        disabled = false
                        filter = {
                          expression = "k8s.node.name IN $k8s.node.name k8s.cluster.name in $k8s.cluster.name"
                        }
                        functions = [
                        ]
                        group_by = [
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "direction"
                          },
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "device"
                          },
                        ]
                        having = {
                        }
                        legend = "{{device}}::{{direction}}"
                        limit  = 30
                        name   = "A"
                        order = [
                        ]
                        signal        = "metrics"
                      }
                    }
                  }
                }
              }
            },
          ]
        }
      }
      ea1d1541-7787-4e09-8e5b-69be7f6af1ce = {
        kind = "Panel"
        spec = {
          display = {
            name = "Memory Usage"
          }
          links = [
          ]
          plugin = {
            time_series_panel = {
              kind = "signoz/TimeSeriesPanel"
              spec = {
                axes = {
                  is_log_scale = false
                  soft_max     = 0
                  soft_min     = 0
                }
                chart_appearance = {
                  fill_mode          = "none"
                  line_interpolation = "spline"
                  line_style         = "solid"
                  show_points        = false
                  span_gaps = {
                    fill_only_below = false
                  }
                }
                formatting = {
                  decimal_precision = "2"
                  unit              = "bytes"
                }
                legend = {
                  mode     = "list"
                  position = "bottom"
                }
                visualization = {
                  fill_spans      = false
                  time_preference = "global_time"
                }
              }
            }
          }
          queries = [
            {
              kind = "time_series"
              spec = {
                name = "A"
                plugin = {
                  builder_query = {
                    kind = "signoz/BuilderQuery"
                    spec = {
                      metrics = {
                        aggregations = [
                          {
                            metric_name       = "system.memory.usage"
                            reduce_to         = "avg"
                            space_aggregation = "sum"
                            time_aggregation  = "avg"
                          },
                        ]
                        disabled = false
                        filter = {
                          expression = "k8s.node.name IN $k8s.node.name k8s.cluster.name in $k8s.cluster.name"
                        }
                        functions = [
                        ]
                        group_by = [
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "state"
                          },
                        ]
                        having = {
                        }
                        legend = "{{state}}"
                        name   = "A"
                        order = [
                        ]
                        signal        = "metrics"
                      }
                    }
                  }
                }
              }
            },
          ]
        }
      }
      f42a3a42-8099-4be9-a6b5-1528d1f1bdfa = {
        kind = "Panel"
        spec = {
          display = {
            name = "Network errors"
          }
          links = [
          ]
          plugin = {
            time_series_panel = {
              kind = "signoz/TimeSeriesPanel"
              spec = {
                axes = {
                  is_log_scale = false
                  soft_max     = 0
                  soft_min     = 0
                }
                chart_appearance = {
                  fill_mode          = "none"
                  line_interpolation = "spline"
                  line_style         = "solid"
                  show_points        = false
                  span_gaps = {
                    fill_only_below = false
                  }
                }
                formatting = {
                  decimal_precision = "2"
                  unit              = "short"
                }
                legend = {
                  mode     = "list"
                  position = "bottom"
                }
                visualization = {
                  fill_spans      = false
                  time_preference = "global_time"
                }
              }
            }
          }
          queries = [
            {
              kind = "time_series"
              spec = {
                name = "A"
                plugin = {
                  builder_query = {
                    kind = "signoz/BuilderQuery"
                    spec = {
                      metrics = {
                        aggregations = [
                          {
                            metric_name       = "system.network.errors"
                            reduce_to         = "avg"
                            space_aggregation = "sum"
                            time_aggregation  = "rate"
                          },
                        ]
                        disabled = false
                        filter = {
                          expression = "k8s.node.name IN $k8s.node.name k8s.cluster.name in $k8s.cluster.name"
                        }
                        functions = [
                        ]
                        group_by = [
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "direction"
                          },
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "device"
                          },
                        ]
                        having = {
                        }
                        legend = "{{device}}::{{direction}}"
                        limit  = 30
                        name   = "A"
                        order = [
                        ]
                        signal        = "metrics"
                      }
                    }
                  }
                }
              }
            },
          ]
        }
      }
      f4d0972c-6d7b-44b0-b813-8063f0bb7410 = {
        kind = "Panel"
        spec = {
          display = {
            name = "CPU Usage by namespace"
          }
          links = [
          ]
          plugin = {
            time_series_panel = {
              kind = "signoz/TimeSeriesPanel"
              spec = {
                axes = {
                  is_log_scale = false
                  soft_max     = 0
                  soft_min     = 0
                }
                chart_appearance = {
                  fill_mode          = "none"
                  line_interpolation = "spline"
                  line_style         = "solid"
                  show_points        = false
                  span_gaps = {
                    fill_only_below = false
                  }
                }
                formatting = {
                  decimal_precision = "2"
                  unit              = "none"
                }
                legend = {
                  mode     = "list"
                  position = "bottom"
                }
                visualization = {
                  fill_spans      = false
                  time_preference = "global_time"
                }
              }
            }
          }
          queries = [
            {
              kind = "time_series"
              spec = {
                name = "A"
                plugin = {
                  builder_query = {
                    kind = "signoz/BuilderQuery"
                    spec = {
                      metrics = {
                        aggregations = [
                          {
                            metric_name       = "k8s.pod.cpu.usage"
                            reduce_to         = "avg"
                            space_aggregation = "avg"
                            time_aggregation  = "avg"
                          },
                        ]
                        disabled = false
                        filter = {
                          expression = "k8s.node.name IN $k8s.node.name k8s.cluster.name in $k8s.cluster.name"
                        }
                        functions = [
                        ]
                        group_by = [
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "k8s.namespace.name"
                          },
                        ]
                        having = {
                        }
                        legend = "{{k8s.namespace.name}}"
                        limit  = 30
                        name   = "A"
                        order = [
                        ]
                        signal        = "metrics"
                      }
                    }
                  }
                }
              }
            },
          ]
        }
      }
      f984a994-50b8-4c1e-83b4-9a10ca128657 = {
        kind = "Panel"
        spec = {
          display = {
            name = "File system inode usage"
          }
          links = [
          ]
          plugin = {
            table_panel = {
              kind = "signoz/TablePanel"
              spec = {
                formatting = {
                  column_units = {
                    A = "short"
                  }
                  decimal_precision = "2"
                }
                visualization = {
                  time_preference = "global_time"
                }
              }
            }
          }
          queries = [
            {
              kind = "scalar"
              spec = {
                name = "A"
                plugin = {
                  builder_query = {
                    kind = "signoz/BuilderQuery"
                    spec = {
                      metrics = {
                        aggregations = [
                          {
                            metric_name       = "system.filesystem.inodes.usage"
                            reduce_to         = "avg"
                            space_aggregation = "sum"
                            time_aggregation  = "avg"
                          },
                        ]
                        disabled = false
                        filter = {
                          expression = "k8s.node.name IN $k8s.node.name k8s.cluster.name in $k8s.cluster.name"
                        }
                        functions = [
                        ]
                        group_by = [
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "device"
                          },
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "mountpoint"
                          },
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "state"
                          },
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "type"
                          },
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "mode"
                          },
                        ]
                        having = {
                        }
                        legend = "usage"
                        limit  = 30
                        name   = "A"
                        order = [
                        ]
                        signal        = "metrics"
                      }
                    }
                  }
                }
              }
            },
          ]
        }
      }
      f9df830b-cb02-4e70-b72a-f89a2e4f8196 = {
        kind = "Panel"
        spec = {
          display = {
            name = "Allocatable Memory"
          }
          links = [
          ]
          plugin = {
            number_panel = {
              kind = "signoz/NumberPanel"
              spec = {
                formatting = {
                  decimal_precision = "2"
                  unit              = "bytes"
                }
                visualization = {
                  time_preference = "global_time"
                }
              }
            }
          }
          queries = [
            {
              kind = "scalar"
              spec = {
                name = "A"
                plugin = {
                  builder_query = {
                    kind = "signoz/BuilderQuery"
                    spec = {
                      metrics = {
                        aggregations = [
                          {
                            metric_name       = "k8s.node.allocatable_memory"
                            reduce_to         = "avg"
                            space_aggregation = "sum"
                            time_aggregation  = "avg"
                          },
                        ]
                        disabled = false
                        filter = {
                          expression = "k8s.node.name IN $k8s.node.name k8s.cluster.name in $k8s.cluster.name"
                        }
                        functions = [
                        ]
                        group_by = [
                        ]
                        having = {
                        }
                        name = "A"
                        order = [
                        ]
                        signal        = "metrics"
                      }
                    }
                  }
                }
              }
            },
          ]
        }
      }
      fbc102af-88fb-488f-9c7a-c89551593c9e = {
        kind = "Panel"
        spec = {
          display = {
            name = "Memory Usage by namespace"
          }
          links = [
          ]
          plugin = {
            time_series_panel = {
              kind = "signoz/TimeSeriesPanel"
              spec = {
                axes = {
                  is_log_scale = false
                  soft_max     = 0
                  soft_min     = 0
                }
                chart_appearance = {
                  fill_mode          = "none"
                  line_interpolation = "spline"
                  line_style         = "solid"
                  show_points        = false
                  span_gaps = {
                    fill_only_below = false
                  }
                }
                formatting = {
                  decimal_precision = "2"
                  unit              = "bytes"
                }
                legend = {
                  mode     = "list"
                  position = "bottom"
                }
                visualization = {
                  fill_spans      = false
                  time_preference = "global_time"
                }
              }
            }
          }
          queries = [
            {
              kind = "time_series"
              spec = {
                name = "A"
                plugin = {
                  builder_query = {
                    kind = "signoz/BuilderQuery"
                    spec = {
                      metrics = {
                        aggregations = [
                          {
                            metric_name       = "k8s.pod.memory.usage"
                            reduce_to         = "avg"
                            space_aggregation = "sum"
                            time_aggregation  = "avg"
                          },
                        ]
                        disabled = false
                        filter = {
                          expression = "k8s.node.name IN $k8s.node.name k8s.cluster.name in $k8s.cluster.name"
                        }
                        functions = [
                        ]
                        group_by = [
                          {
                            field_context   = "attribute"
                            field_data_type = "string"
                            name            = "k8s.namespace.name"
                          },
                        ]
                        having = {
                        }
                        legend = "{{k8s.namespace.name}}"
                        limit  = 30
                        name   = "A"
                        order = [
                        ]
                        signal        = "metrics"
                      }
                    }
                  }
                }
              }
            },
          ]
        }
      }
    }
    variables = [
      {
        list_variable = {
          kind = "ListVariable"
          spec = {
            allow_all_value = false
            allow_multiple  = false
            display = {
              description = "The k8s.cluster.name"
              name        = "k8s.cluster.name"
            }
            name = "k8s.cluster.name"
            plugin = {
              dynamic_variable = {
                kind = "signoz/DynamicVariable"
                spec = {
                  name   = "k8s.cluster.name"
                  signal = "all"
                }
              }
            }
            sort = "none"
          }
        }
      },
      {
        list_variable = {
          kind = "ListVariable"
          spec = {
            allow_all_value = true
            allow_multiple  = true
            display = {
              description = "The name of the Node"
              name        = "k8s.node.name"
            }
            name = "k8s.node.name"
            plugin = {
              dynamic_variable = {
                kind = "signoz/DynamicVariable"
                spec = {
                  name   = "k8s.node.name"
                  signal = "all"
                }
              }
            }
            sort = "alphabetical-asc"
          }
        }
      },
    ]
  }
  tags = [
    {
      key   = "tag"
      value = "hostmetrics"
    },
    {
      key   = "tag"
      value = "k8s"
    },
    {
      key   = "tag"
      value = "node"
    },
  ]
}
