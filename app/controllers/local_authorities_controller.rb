class LocalAuthoritiesController < ApplicationController
  def index
    @local_authorities = LocalAuthority.all.sort{|a,b| a.name <=> b.name}
  end
  def show
    @local_authority = LocalAuthority.find_by_la_code(params[:id])
    @households = @local_authority.total_households

    @social_housing = @local_authority.number_social_housing
    @social_housing_average_households = LocalAuthority.average_social_housing_household_percentage
    @local_authority_percentage_households = @local_authority.percentage_social_housing

    @number_of_homeless = @local_authority.number_of_homeless
    @homeless_average = LocalAuthority.average_homeless_percentage
    @local_authority_percentage_homeless = @local_authority.percentage_homeless

    @local_authority_houses_sold = @local_authority.houses_sold
    @local_authority_percentage_houses_sold = @local_authority.percentage_houses_sold
    @houses_sold_average = LocalAuthority.average_houses_sold

    @total_need = @local_authority.need
    @local_authority_percentage_need = @local_authority.percentage_need
    @need_average = LocalAuthority.average_need

  end
end