class DataViewsController < ApplicationController
  def homelessnesses
    @homelessnesses = Homelessness.all.order(type_1: :desc)
  end
  def social_housing_sales
    @social_housing_sales = SocialHousingSale.all.order(sales: :desc)
  end
  def social_housing
    @social_housings = SocialHousing.all
  end
end