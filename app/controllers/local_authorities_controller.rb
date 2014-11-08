class LocalAuthoritiesController < ApplicationController
  def index
    @local_authorities = LocalAuthority.all
  end
  def show
    @local_authority = LocalAuthority.find_by_la_code(params[:id])
  end
end