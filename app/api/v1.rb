class API::V1 < Grape::API
  version "v1", using: :path
  desc "Returns the current API version, v1."
  get do
    {version: "v1"}
  end
  mount TestsAPI
end
