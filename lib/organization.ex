defmodule Base64Example.Organization do
  @moduledoc false
  use Ecto.Schema
  use Waffle.Ecto.Schema

  alias Base64Example.Repo
  alias Base64Example.Logo

  require Logger

  schema "organizations" do
    field(:logo, Base64Example.Logo.Type)

    timestamps()
  end

  def create_organization(attrs \\ nil) do
    Repo.start_link()

    attrs = attrs || %{logo: %{filename: "phoenix.png", binary: base64_decoded_image()}}

    {_, org} =
      %__MODULE__{}
      |> attachments_changeset(attrs)
      |> Repo.insert()

    {:ok, status, _, _} = Logo.url({org.logo, org}) |> :hackney.get()

    if status == 404 do
      Logger.error("Image is not uploaded! Uploading via .store ...")

      {:ok, status, _, _} = reattach_image_to_organization(org)
      if status == 200, do: Logger.warn("Successs image upload")
    end
  end

  def reattach_image_to_organization(org) do
    Repo.start_link()

    Logo.store({%{filename: "phoenix.png", binary: base64_decoded_image()}, org})

    Logo.url({org.logo, org}) |> :hackney.get()
  end

  defp base64_decoded_image do
    (File.cwd!() <> "/phoenix.png") |> File.read!() |> Base.encode64() |> Base.decode64!()
  end

  def attachments_changeset(organization, attrs) do
    organization
    |> cast_attachments(attrs, [:logo])
  end

  def list_organizations do
    Repo.start_link()

    Repo.all(__MODULE__)
  end
end
