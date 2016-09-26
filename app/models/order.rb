class Order < ActiveRecord::Base
  scope :where_status_for_admin, -> do
    where "status = ? or status = ?", statuses[:pendding], statuses[:done]
  end

  belongs_to :user
  has_many :detail_orders, dependent: :destroy

  enum status: [:created, :pendding, :done, :cancel]

  before_create :create_order
  before_save :update_total_money

  def total_money
    self.detail_orders.collect do |item|
      item.valid? ? (item.quantity * item.price) : 0
    end.sum
  end

  def download_keys keys
    CSV.generate do |csv|
      csv << column_names
      keys.each do |key|
        csv << key.attributes.values_at(*column_names)
      end
    end
  end

  private
  def create_order
    self.status = :created
    self.date_update = Time.now
  end

  def update_total_money
    self.total_money = total_money
  end
end
