class BooksController < ApplicationController
load_and_authorize_resource
before_action :set_book, only: [:show, :edit, :update, :destroy]

before_action :authenticate_user!
before_action :configure_permitted_parameters, if: :devise_controller?


respond_to :js, :json, :html

  def index
    @books = Book.all
  end


  def show
  end

  def new
    @book = Book.new
  end

   def get_info

    #AWS
    Amazon::Ecs.debug = true
    res = Amazon::Ecs.item_search(params[:isbn],
         :search_index   => 'Books',
         :response_group => 'Medium',
         :country        => 'jp'
       )
    info = {
      'Image' => res.first_item.get('MediumImage/URL'),      
      'Title' => res.first_item.get('ItemAttributes/Title'),
            'Author' => res.first_item.get('ItemAttributes/Author'),
            'Manufacturer' => res.first_item.get('ItemAttributes/Manufacturer'),
            'Publication_Date' => res.first_item.get('ItemAttributes/PublicationDate')
            }
    render json: info
   

    #Rakuten Books

        # item = Rakuten.item_search(params[:isbn])
   
        # info = {
        #   'Title' => item['Items']['Item']['title'],
        #         }
        # render json: info


end

    def isbn



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
    if @book.rental.nil?
      @book.destroy
      redirect_to books_path
    else
      redirect_to books_path, notice: "その本は貸出中のため削除できません。"
    end
  end

  private

    def book_params
      params[:book].permit(:title, :image, :author, :manufacturer, :publication_date, :isbn, :book_code)
    end

    def set_book
      @book = Book.find(params[:id])
    end

end
