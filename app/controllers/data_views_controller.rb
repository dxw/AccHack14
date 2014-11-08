class DataViewsController < ApplicationController
  def local_authorities
    @local_authorities = LocalAuthority.all
  end
  def homelessnesses
    @homelessnesses = Homelessness.all
  end
end