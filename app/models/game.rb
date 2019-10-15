# frozen_string_literal: true

class Game < ApplicationRecord
  belongs_to :user

  def editable?(user)
    user && user.id == user_id
  end

  def touched?
    created_at != updated_at
  end
end
