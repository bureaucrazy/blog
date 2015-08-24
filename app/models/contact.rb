class Contact < ActiveRecord::Base
  validates :email,   presence:   {message: "must be present"},
                      # length:     {minimum: 4}    # title must have at least 3 chars
  validates :name,    presence:   {message: "must be present"},
  validates :subject, presence:   {message: "must be present"},
  validates :message, presence:   {message: "must be present"},
end
