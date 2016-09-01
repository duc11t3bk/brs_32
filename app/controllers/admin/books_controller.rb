class Admin::BooksController < ApplicationController
  before_action :verify_admin
  before_action :load_books_association, only: :new

  def index
    @search = Book.ransack params[:q]
    @search.sorts = Settings.default_sort if @search.sorts.empty?
    @books = @search.result
      .joins(:category, :author, :publisher, :language)
      .page(params[:page]).per(Settings.per_page)
    @search.build_condition if @search.conditions.empty?
    @search.build_sort if @search.sorts.empty?
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new book_params
    if @book.save
      redirect_to root_path
    else
      load_books_association
      render :new
    end
  end

  private
  def book_params
    params.require(:book).permit(:title, :cover_image_name,
      :number_of_pages, :description, :publish_date, :price,
      :author_id, :category_id, :publisher_id, :language_id, :is_in_library )
  end

  def load_books_association
    @authors = Author.all
    @categories = Category.all
    @publishers = Publisher.all
    @languages = Language.all
  end
end
