class AuthenticationsController < ApplicationController
  before_action :set_authentication, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @authentications = Authentication.all
    respond_with(@authentications)
  end

  def show
    respond_with(@authentication)
  end

  def new
    @authentication = Authentication.new
    respond_with(@authentication)
  end

  def edit
  end

  def create
    @authentication = Authentication.new(authentication_params)
    @authentication.save
    respond_with(@authentication)
  end

  def update
    @authentication.update(authentication_params)
    respond_with(@authentication)
  end

  def destroy
    @authentication.destroy
    respond_with(@authentication)
  end

  private
    def set_authentication
      @authentication = Authentication.find(params[:id])
    end

    def authentication_params
      params.require(:authentication).permit(:user_id, :provider, :uid)
    end
end
