class Book < ActiveRecord::Base



has_one :rental

    validates :title, :author, :manufacturer, :publication_date, :isbn, :book_code, presence: true



end
