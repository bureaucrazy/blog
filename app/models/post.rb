class Post < ActiveRecord::Base
    validates :title, presence: true, uniqueness: true

    def self.search(value)
      search_term = "%#{value}%"
      where(["title ILIKE :term OR body ILIKE :term", {term: search_term}])
    end

end
