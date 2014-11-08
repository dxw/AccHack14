class DataViewsController < ApplicationController
  def local_authorities
    @local_authorities = LocalAuthority.all
  end
  def homelessnesses
    @homelessnesses = Homelessness.all
  end
  def social_housing_sales
    @social_housing_sales = SocialHousingSale.all
  end
end