class Comment < ActiveRecord::Base
    belongs_to :post
    belongs_to :user
    validates :body, presence: true

    def user_name
      if user
        user.full_name
      else
        "Anonymous"
      end
    end
end
