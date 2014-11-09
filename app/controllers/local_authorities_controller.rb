class LocalAuthoritiesController < ApplicationController
  def index
    @local_authorities = LocalAuthority.all
  end
  def show
    @local_authority = LocalAuthority.find_by_la_code(params[:id])
    @households = @local_authority.total_households
    @social_housing = @local_authority.number_social_housing
    @social_housing_average_households = LocalAuthority.average_social_housing_household_percentage
    @local_authority_percentage_households = @local_authority.percentage_social_housing
    @homeless_average = 0.1
    @local_authority_percentage_homeless = @local_authority.percentage_homeless
  end
end