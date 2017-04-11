class InsalesAppController < ApplicationController
  skip_before_filter :authentication
  skip_before_filter :configure_api
  require 'digest/md5'

  def install
    raise "Fail to install" unless MyApp.install params[:shop], params[:token], params[:insales_id]
    head :ok
    @account = Account.find_by_insales_id(params[:insales_id])
    password = Digest::MD5.hexdigest(params[:token].to_s+MyApp.api_secret.to_s)
    if @account.present?
	  	@account.password = password
	  	@account.save
	  else
	  	@account = Account.create(:insales_subdomain => params[:shop], :password => password, :insales_id => params[:insales_id])
	  end	
  end

  def uninstall
    raise "Fail to uninstall" unless MyApp.uninstall params[:shop], params[:token]
    head :ok
  end
end