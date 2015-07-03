class Rakuten < ActiveResource::Base

require 'open-uri'
require 'json'


#   self.site     = "https://app.rakuten.co.jp/services/api/BooksBook/Search/20130522" #リソースのURL
#   self.format   = :xml #リソースのフォーマット
#   APPLICATION_ID  = ENV["RK_APPLICATION_ID"]
#   DEVELOPER_ID  = ENV["RK_AFFILIATE_ID"]

#   def self.item_search(isbn)
#     self.find(
#       :one,
#       :params => {
#         :developerId  =>  DEVELOPER_ID,
#         :applicationId  =>  APPLICATION_ID,
#         :format => "json",
#         :isbn     =>  isbn
#       }
#     )
#   end
# end

# Set API token and URL
RK_APPLICATION_ID = "1035159221819974394"
DEVELOPER_ID  = "141a1617.2081c016.141a1618.f28ccd83"
polling_url = "https://app.rakuten.co.jp/services/api/BooksBook/Search/20130522"
#isbn = "9784893252227"

def self.item_search(isbn)

  # Specify request parameters
  params = {
    applicationId: RK_APPLICATION_ID, 
    format: "json",
      isbn: isbn
  }

  # Prepare API request
  uri = URI.parse(polling_url)
  uri.query = URI.encode_www_form(params)

  # Submit request
  result = JSON.parse(open(uri).read)

  # Display results to screen
  #puts JSON.pretty_generate result

  #puts result["Items"].first["Item"]["isbn"]

  result["Items"].first["Item"].each do |book|
    @book = Book.new
    @book.name = book["title"]
    @book.author = book["author"]
    @book.isbn = book["isbn"]
    @book.manufacture = book["publisherName"]
    @book.publication_date = book["salesDate"]
    @book.save
  puts @book.name
  end

end