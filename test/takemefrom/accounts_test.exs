defmodule Takemefrom.AccountsTest do
  use Takemefrom.DataCase

  alias Takemefrom.Accounts
  alias Takemefrom.Accounts.User

  describe "users" do
    @valid_attrs %{email: "some@email", password: "foobar"}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.register_user()

      user
    end

    test "register_user/1 creates new user" do
      {:ok, user} = Accounts.register_user(@valid_attrs)

      assert user.email == @valid_attrs[:email]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Accounts.get_user!(user.id).email == user.email
    end

    test "get_user_by/1 returns the user by given opts" do
      user = user_fixture()
      assert Accounts.get_user_by(email: user.email).email == user.email
    end

    test "authenticate_by_email_and_pass/2 should return ok if password match" do
      user = user_fixture()

      assert Accounts.authenticate_by_email_and_pass(user.email, "foobar") ==
               {:ok, %User{user | password: nil}}
    end
  end
end
