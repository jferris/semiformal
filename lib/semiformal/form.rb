module Semiformal
  # Decorates a Resource to provide default HTML attributes and button values
  # for an HTML form.
  class Form
    def initialize(resource)
      @resource = resource
    end

    def commit_button_value
      "#{action} #{title}"
    end

    def method
      @resource.method
    end

    def url
      @resource.url
    end

    def input(name)
      @resource.input(name)
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

    def name
      @resource.name
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

    def to_key
      @resource.to_key
    end

    def post?
      @resource.method == "post"
    end
  end
end
