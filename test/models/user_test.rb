require 'test_helper'

class UserTest < ActiveSupport::TestCase
  should have_db_column(:email)
  should have_db_column(:password_digest)
  should have_db_column(:role)
  should have_db_index(:role)
  should have_db_index(:email)
  should have_db_index(:password_digest)
  should have_many(:pets)
end
