class LocalAuthoritiesController < ApplicationController
  def index
    @local_authorities = LocalAuthority.all
  end
  def show
    @local_authority = LocalAuthority.find_by_la_code(params[:id])
    @households = @local_authority.total_households
    @social_housing = @local_authority.social_housing.household_total_rent
    @social_housing_average_households = 0.26
    @local_authority_percentage_households = @social_housing*100.0/@households
    @homeless_average = 0.1
    @local_authority_percentage_homeless = @local_authority.number_of_homeless*100.0/@households
  end
end