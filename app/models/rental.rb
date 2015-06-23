class Rental < ActiveRecord::Base
  belongs_to :Book
  belongs_to :User
  belongs_to :Log
end
