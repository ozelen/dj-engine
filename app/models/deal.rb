class Deal < ActiveRecord::Base
  belongs_to :dealable, polymorphic: true
  attr_accessible :begin_date, :contacts, :dealable_id, :dealable_type, :expire_date, :login, :password, :person_name, :price, :status

  after_update :update_rating

  def update_rating
    dealable.donated      = dealable.deals.sum(:price)
    dealable.deal_expire  = dealable.deals.maximum(:expire_date) || '2006-04-20'.to_date
    dealable.save!
  end

end
