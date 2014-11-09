class LocalAuthoritiesController < ApplicationController
  def index
    @local_authorities = LocalAuthority.all
  end
  def show
    @local_authority = LocalAuthority.find_by_la_code(params[:id])
    @households = 1257
    @social_housing = 300
    @social_housing_average_households = 0.26
    @local_authority_percentage_households = 0.32
    @homeless_average = 0.1
    @local_authority_percentage_homeless = 0.05
  end
end