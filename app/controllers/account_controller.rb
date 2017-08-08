# frozen_string_literal: true

class AccountController < ApplicationController
  before_action :authenticate_user!

  def profile
    @identity = {}
    current_user.identities.each do |identity|
      @identity[identity.provider] = identity.id
    end
    @identity
  end

  def disconnect
    @identity = current_user.identities.find_by(id: permitted_params[:identity_id])
    @identity.destroy
    redirect_to account_profile_path, notice: '中斷成功'
  end

  private

  def permitted_params
    params.permit(:identity_id)
  end
end
