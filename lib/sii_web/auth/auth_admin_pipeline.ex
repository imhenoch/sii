defmodule Sii.Guardian.AuthAdminPipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :sii,
    module: Sii.Admin.Guardian,
    error_handler: Sii.AuthErrorHandler

  plug Guardian.Plug.VerifyHeader, realm: "Bearer"
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
