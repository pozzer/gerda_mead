class Bottle < ActiveRecord::Base

  has_many :ratings, :as => :rateable, :dependent => :destroy
  has_many :bottle_trades
	belongs_to :user

  validates :label, :organization_name, :amount, :measure, :abv, :style_list, :type_list, presence: true

  scope :publics, -> { where(private: false) }
  scope :random_order, -> { order('DBMS_RANDOM.VALUE')}

  scope :joins_search, -> { publics.joins("INNER JOIN users ON users.id = bottles.user_id
                                           INNER JOIN profiles ON users.id = profiles.user_id") }

  scope :with_stock, -> {where("amount > 0")}

  paginates_per 20

  def to_s
    "#{type_s} #{label}"
  end

  def self.columns_search
    ["bottles.label", "bottles.style", "bottles.organization_name",
    "coalesce(profiles.first_name, '') || ' ' || coalesce(profiles.last_name, '')"]
  end

  def style_s
    style_list.first
  end

  def type_s
    type_list.first
  end

  def reputation
    ratings.any? ? (ratings.map(&:score).sum/ratings.size).to_i : 0
  end

  def creator?(user_id)
    user_id == self.user_id
  end

  def can_edit?(user_id)
    creator?(user_id)
  end

  def can_see?(user_id)
    !self.private or creator?(user_id)
  end

end
