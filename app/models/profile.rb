class Profile < ActiveRecord::Base

	belongs_to :user
	belongs_to :city
  has_many :ratings, :as => :rateable, :dependent => :destroy
  has_many :avatars, -> { where picture_type: 1 }, as: :attachable, class_name: "Picture", :dependent => :destroy
  has_many :covers, -> { where picture_type: 2 }, as: :attachable, class_name: "Picture", :dependent => :destroy
  has_one :address, dependent: :destroy

  accepts_nested_attributes_for :address, :allow_destroy => true
  accepts_nested_attributes_for :user

  scope :joins_search, -> { joins(:user).joins("LEFT JOIN addresses ON addresses.profile_id = profiles.id
                             LEFT JOIN cities ON addresses.city_id = cities.id
                             LEFT JOIN states ON addresses.state_id = states.id") }
  scope :top_rated, -> { find_with_reputation(:ratings, :all).order("votes DESC") }

  paginates_per 12

  def full_name
    "#{first_name} #{last_name}"
  end

  def city_and_symbol
    unless address.nil?
      return [address.city.name, address.state.symbol]
    else
      return ["Não informado", "-"]
    end
  end


  def self.columns_search
    ["coalesce(profiles.first_name, '') || ' ' || coalesce(profiles.last_name, '')", "profiles.about", "profiles.organization_name",
     "addresses.street", "addresses.district",
     "states.name",
     "cities.name"]
  end

end
