class Devise::PasswordsController < ApplicationController
  prepend_before_filter :require_no_authentication
   before_filter :authenticate_user!

  include Devise::Controllers::InternalHelpers

  # GET /resource/password/new
  def new
    build_resource
    render_with_scope :new
  end

  # POST /resource/password
  def create
    self.resource = resource_class.send_reset_password_instructions(params[resource_name])

    if resource.errors.empty?
      set_flash_message :notice, :send_instructions
      redirect_to new_session_path(resource_name)
    else
      render_with_scope :new
    end
  end

  # GET /resource/password/edit?reset_password_token=abcdef
    def edit
    @user = current_user
    if @author.save
    Admin.admin_approval(@author).deliver
   end
  end

  def update
    @user = current_user

    if @user.update_with_password(params[:user])
      sign_in(@user, :bypass => true)
      redirect_to root_path, :notice => "Password updated!"
    else
      render :edit
    end
  end
end

end
