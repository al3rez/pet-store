require 'test_helper'

class PetTest < ActiveSupport::TestCase
  should have_db_column(:name)
  should have_db_column(:pet_type)
  should belong_to(:user)
end
