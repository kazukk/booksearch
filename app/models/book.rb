class Book < ActiveRecord::Base



has_one :rental

    validates :title, :author, :manufacturer, :publication_date, :isbn, presence: true



end
