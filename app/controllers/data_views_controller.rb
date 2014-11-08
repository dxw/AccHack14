class DataViewsController < ApplicationController
  def local_authorities
    @local_authorities = LocalAuthority.all
  end
end