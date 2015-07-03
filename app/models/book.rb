class Book < ActiveRecord::Base
require 'open-uri'
require 'json'


has_one :rental

    validates :title, :author, :manufacturer, :publication_date, :isbn, :book_code, presence: true


@RK_APPLICATION_ID = "1035159221819974394"
@DEVELOPER_ID  = "141a1617.2081c016.141a1618.f28ccd83"
@polling_url = "https://app.rakuten.co.jp/services/api/BooksBook/Search/20130522"


end
