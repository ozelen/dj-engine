class Lead < ActiveRecord::Base
  belongs_to :leader, polymorphic: true
  attr_accessible :leader_id, :leader_type, :params, :provider

  def parameters
    params ? ActiveSupport::JSON.decode(params) : Hash.new
  end

  def parameters=(obj)
    self.params = obj.to_json
  end
end
