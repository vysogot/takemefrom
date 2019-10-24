defmodule Takemefrom.AccountsTest do
  use Takemefrom.DataCase

  alias Takemefrom.Accounts
  alias Takemefrom.Accounts.User

  describe "users" do
    test "register_user/1 creates new user" do
      attrs = %{email: "some@email", password: "foobar"}
      {:ok, user} = Accounts.register_user(attrs)

      assert user.email == attrs[:email]
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
