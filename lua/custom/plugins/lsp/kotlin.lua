local M = {}

function M.setup()
  require('kotlin').setup {
    root_markers = {
      'gradlew',
      '.git',
      'mvnw',
      'settings.gradle',
    },

    jdk_for_symbol_resolution = nil, -- Auto-detect from project

    jvm_args = {
      '-Xmx4g', -- Increase max heap (useful for large projects)
    },

    inlay_hints = {
      enabled = true,
      parameters = true,
      parameters_compiled = true,
      parameters_excluded = false,
      types_property = true,
      types_variable = true,
      function_return = true,
      function_parameter = true,
      lambda_return = true,
      lambda_receivers_parameters = true,
      value_ranges = true,
      kotlin_time = true,
      call_chains = false,
    },

    folding = { enabled = true },
  }
end

return M
