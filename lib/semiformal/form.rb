module Semiformal
  class Form
    attr_reader :controller, :target

    def initialize(controller, target)
      @controller = controller
      @target = target
    end

    def url
      target
    end

    def default_attributes
      { 'class'  => controller.dom_class(target),
        'id'     => controller.dom_id(target),
        'action' => controller.url_for(url),
        'method' => 'post' }
    end
  end
end

