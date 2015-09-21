class Post < ActiveRecord::Base
    validates :title, presence: true, uniqueness: true

    has_many :comments, dependent: :destroy
    has_many :favourites, dependent: :destroy
    has_many :favouriting_users, through: :favourites, source: :user
    has_many :taggings, dependent: :destroy
    has_many :tags, through: :taggings

    belongs_to :user
    belongs_to :category

    mount_uploader :image, ImageUploader

    def user_name
      if user
        user.full_name
      else
        "Anonymous"
      end
    end

    def favourite_for(user)
      favourites.find_by_user_id(user.id)
    end

    delegate :name, to: :category, prefix: true

    def self.search(value)
      search_term = "%#{value}%"
      where(["title ILIKE :term OR body ILIKE :term", {term: search_term}])
    end

end
