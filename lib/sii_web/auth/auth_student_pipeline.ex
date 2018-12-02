defmodule Sii.Guardian.AuthStudentPipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :sii,
    module: Sii.Student.Guardian,
    error_handler: Sii.AuthErrorHandler

  plug Guardian.Plug.VerifyHeader, realm: "Bearer"
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
