class WelcomeController < ApplicationController
  def index
    @local_authorities = LocalAuthority.all
  end

  def about
  end
end
