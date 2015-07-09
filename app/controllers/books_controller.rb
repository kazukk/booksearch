class BooksController < ApplicationController

before_action :set_book, only: [:show, :edit, :update, :destroy]

before_action :authenticate_user!

respond_to :js, :json, :html




  def index
    @books = Book.all.order("created_at DESC")

  end


  def show


  end

  def new
    @book = Book.new
  end

def search_book
@book = Book.all

end


   def get_info
  @book = Book.new
  @book.isbn = params[:isbn]

  require 'open-uri'
  require 'json'

    #AWS
    # Amazon::Ecs.debug = true
    # res = Amazon::Ecs.item_search(params[:isbn],
    #      :search_index   => 'Books',
    #      :response_group => 'Medium',
    #      :country        => 'jp'
    #    )
    # info = {
    #   'Image' => res.first_item.get('MediumImage/URL'),      
    #   'Title' => res.first_item.get('ItemAttributes/Title'),
    #         'Author' => res.first_item.get('ItemAttributes/Author'),
    #         'Manufacturer' => res.first_item.get('ItemAttributes/Manufacturer'),
    #         'Publication_Date' => res.first_item.get('ItemAttributes/PublicationDate')
    #         }
    # render json: info

  
      params = {
        applicationId: ENV["RK_APPLICATION_ID"], 
        isbn: @book.isbn,
        format: "json"


        ###フォーム内のISBNを変数にAPIを叩く
        #isbn: isbn
      }

      # Prepare API request
      uri = URI.parse("https://app.rakuten.co.jp/services/api/BooksBook/Search/20130522")
      uri.query = URI.encode_www_form(params)

      #debug用にopen(uri).readの中身を吐き出す  
      Rails.logger.info open(uri).read

      # Submit request
      result = JSON.parse(open(uri).read)

      #Display results to screen
      #puts JSON.pretty_generate result

        info = {
        
        'Image' => result["Items"].first["Item"]["mediumImageUrl"],  
        'Isbn' => result["Items"].first["Item"]["isbn"],  
        'Title' => result["Items"].first["Item"]["title"],
        'Author' => result["Items"].first["Item"]["author"],
        'Manufacturer' => result["Items"].first["Item"]["publisherName"],
        'Publication_Date' => result["Items"].first["Item"]["salesDate"]
 

        }
         render json: info


    end


  def create
    @book = Book.new(book_params)
    if @book.save
      redirect_to books_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @book.update(book_params)
      redirect_to books_path
    else
      render 'edit'
    end
  end

  def destroy
    # if @book.rental.nil?
    #   @book.destroy
    #   redirect_to books_path
    # else
    #   redirect_to books_path, notice: "その本は貸出中のため削除できません。"
    # end

    @book.destroy
    redirect_to books_path

  end

  private

    def book_params
      params[:book].permit(:title, :image, :author, :manufacturer, :publication_date, :isbn, :book_code)
    end

    def set_book
      @book = Book.find(params[:id])
    end

end
