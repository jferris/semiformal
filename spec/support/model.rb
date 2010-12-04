require 'active_model'

class Model
  extend ActiveModel::Naming
  include ActiveModel::Conversion

  def persisted?
    false
  end
end
