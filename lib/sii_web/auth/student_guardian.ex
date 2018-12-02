defmodule Sii.Student.Guardian do
  use Guardian, otp_app: :sii

  def subject_for_token(student, _claims) do
    sub = to_string(student.id)
    {:ok, sub}
  end

  def subject_for_token(_, _) do
    {:error, :reason_for_error}
  end

  def resource_from_claims(claims) do
    id = claims["sub"]
    resource = Sii.Users.get_student!(id)
    {:ok, resource}
  end

  def resource_from_claims(_claims) do
    {:error, :reason_for_error}
  end
end
