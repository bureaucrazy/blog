class Category < ActiveRecord::Base
  validates :title, presence:   {message: "must be present"},
                    # this will check for the uniqueness of the title/body
                    # combination. So title doesn't have to be unique by itself
                    # but the combination with body should.
                    uniqueness: true,
                    length:     {minimum: 3}    # title must have at least 3 chars
end
