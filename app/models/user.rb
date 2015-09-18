class User < ActiveRecord::Base
  has_secure_password
  has_many :posts, dependent: :nullify
  has_many :comments, dependent: :nullify
  has_many :favourites, dependent: :destroy
  has_many :favourited_posts, through: :favourites, source: :post

  validates :email, presence: {message: "must be present"}, uniqueness: true,
            format: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  def full_name
    "#{first_name} #{last_name}".strip
  end

  def favourited_post?(post)
    favourited_posts.include?(post)
  end
end
