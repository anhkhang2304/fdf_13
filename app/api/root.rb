module API
  class Root < Grape::API
    #…
    error_formatter :json, API::ErrorFormatter
    #…
  end
end
