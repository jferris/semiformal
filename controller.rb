class UsersController < ApplicationController
  def edit
    assign_user_form
  end

  def update
    if assign_user_form.commit
      redirect_to @user, :flash => "User saved."
    else
      render 'new'
    end
  end

  private

  def assign_user_form
    @user = User.find(params[:id])
    @user_form = form_for(@user) do |form|
      form.accept :email
      form.accept :password
      form.accept :password_confirmation
    end
  end
end
