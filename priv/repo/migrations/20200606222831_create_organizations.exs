defmodule Base64Example.Repo.Migrations.CreateOrganizations do
  use Ecto.Migration

  def change do
    create table(:organizations) do
      add(:logo, :string)

      timestamps()
    end
  end
end
