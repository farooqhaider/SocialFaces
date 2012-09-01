class RegistrationsController < Devise::RegistrationsController

  def after_sign_up_path_for(resource)
    "http://www.google.com" # <- Path you want to redirect the user to.
  end


    def create

      if verify_recaptcha
        super
      else
        build_resource
        clean_up_passwords(resource)
        flash.now[:alert] = "There was an error with the recaptcha code below. Please re-enter the code."
        render_with_scope :new
      end
    end
  end
