module Semiformal
  # Decorates a Resource to provide default HTML attributes and button values
  # for an HTML form.
  class Form
    def initialize(router, resource)
      @router = router
      @resource = resource
    end

    def method
      @resource.method
    end

    def url_target
      @resource.url_target
    end

    def name
      @resource.name
    end

    def to_key
      @resource.to_key
    end

    def input(name)
      @resource.input(name)
    end

    def url
      @router.url_for(@resource.url_target)
    end

    def commit_button_value
      "#{action} #{title}"
    end

    def default_attributes
      { 'method' => 'post',
        'class' => name,
        'action' => url,
        'id'=> id }
    end

    private

    def action
      if post?
        "Create"
      else
        "Update"
      end
    end

    def title
      name.titleize
    end

    def id
      if post?
        new_id
      else
        persisted_id
      end
    end

    def new_id
      ["new", name].join("_")
    end

    def persisted_id
      (["edit", name] + to_key).join("_")
    end

    def post?
      @resource.method == "post"
    end
  end
end
