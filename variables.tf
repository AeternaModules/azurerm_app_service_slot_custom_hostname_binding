variable "app_service_slot_custom_hostname_bindings" {
  description = <<EOT
Map of app_service_slot_custom_hostname_bindings, attributes below
Required:
    - app_service_slot_id
    - hostname
Optional:
    - ssl_state
    - thumbprint
EOT

  type = map(object({
    app_service_slot_id = string
    hostname            = string
    ssl_state           = optional(string)
    thumbprint          = optional(string)
  }))
  validation {
    condition = alltrue([
      for k, v in var.app_service_slot_custom_hostname_bindings : (
        v.thumbprint == null || (length(v.thumbprint) > 0)
      )
    ])
    error_message = "must not be empty"
  }
  # Note: 3 additional provider-side validators are enforced at apply time but not mirrored as validation{} blocks here (bespoke or non-mechanically-translatable).
}

