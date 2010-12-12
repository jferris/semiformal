require 'action_controller'

class Controller
  include ActionController::RecordIdentifier

  def url_for(target)
    "/#{target.class.model_name.plural}"
  end
end

