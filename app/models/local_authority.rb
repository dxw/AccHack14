class LocalAuthority < ActiveRecord::Base
  has_one :social_housing
  has_one :homelessness

  def number_of_homeless
    homelessness.type_1 + homelessness.type_2 + homelessness.type_3
  end
end