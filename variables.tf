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
  # --- Unconfirmed validation candidates, derived from azurerm_app_service_slot_custom_hostname_binding's provider source ---
  # Not auto-enabled: either a bespoke provider validator we can't safely translate,
  # or a path that crosses a list-typed block (needs its own for_each wrapping).
  # Review, translate into a real validation{} block above, and delete once confirmed.
  # path: app_service_slot_id
  #   source:    [from webapps.ValidateSlotID] !ok
  # path: app_service_slot_id
  #   source:    [from webapps.ValidateSlotID] err != nil
  # path: ssl_state
  #   source:    validation.StringInSlice value list is not a literal []string - likely a generated PossibleValuesFor*() helper; resolve separately
}

