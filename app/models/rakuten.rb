class Rakuten < ActiveResource::Base
  self.site     = "https://app.rakuten.co.jp/services/api/BooksBook/Search/20130522" #リソースのURL
  self.format   = :xml #リソースのフォーマット
  AFFILIATE_ID  = ENV["RK_APPLICATION_ID"]
  DEVELOPER_ID  = ENV["RK_AFFILIATE_ID"]

  def self.item_search(isbn)
    self.find(
      :one,
      :params => {
        :developerId  =>  DEVELOPER_ID,
        :affiliateId  =>  AFFILIATE_ID,
        :format => json,
        :isbn     =>  isbn
      }
    )
  end
end