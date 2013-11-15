class Redirect < ActiveRecord::Base
  attr_accessible :new_path, :old_domain, :old_path
end
