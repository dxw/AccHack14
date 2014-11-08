class DataViewsController < ApplicationController
  def local_authorities
    @local_authorities = LocalAuthority.all
  end
  def homelessnesses
    @homelessnesses = Homelessness.all.order(type_1: :desc)
  end
  def social_housing_sales
    @social_housing_sales = SocialHousingSale.all.order(sales: :desc)
  end
end