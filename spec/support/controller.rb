require 'action_controller'

class Controller
  include ActionController::RecordIdentifier

  def url_for(target)
    base_url = "/#{target.class.model_name.plural}"
    if target.persisted?
      ([base_url] + target.to_key).join("/")
    else
      base_url
    end
  end
end

