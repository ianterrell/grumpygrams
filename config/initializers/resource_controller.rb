# Resource Controller uses the standard Rails flash[:notice] for everything.
# Our app uses flash[:success] for positives, flash[:notice] for warnings, and flash[:error] for errors.
# We'll override the methods to have our behavior.

module ResourceController
  module OverrideFlash
    protected
      # Sets the regular flash (i.e. flash[:notice] = '...')
      #
      def set_normal_flash(action)
        if f = options_for(action).flash
          flash[action.to_s.ends_with?("fails") ? :error : :success]     = f.is_a?(Proc) ? instance_eval(&f) : options_for(action).flash
        end
      end

      # Sets the flash.now (i.e. flash.now[:notice] = '...')
      #
      def set_flash_now(action)
        if f = options_for(action).flash_now
          flash.now[action.to_s.ends_with?("fails") ? :error : :success] = f.is_a?(Proc) ? instance_eval(&f) : options_for(action).flash_now
        end
      end
  end
  
  module ActionControllerExtension
    def resource_controller(*args)
      include ResourceController::Controller
      include ResourceController::OverrideFlash
      
      if args.include?(:singleton)
        include ResourceController::Helpers::SingletonCustomizations
      end
    end  
  end
end