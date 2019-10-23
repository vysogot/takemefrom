defmodule Takemefrom.AccountsTest do
  use Takemefrom.DataCase

  alias Takemefrom.Accounts

  describe "users" do
    @valid_attrs %{email: "some@email", password: "foobar"}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.register_user()

      user
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Accounts.get_user!(user.id).email == user.email
    end
  end
end
