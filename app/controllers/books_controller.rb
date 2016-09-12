class BooksController < ApplicationController
  before_action :authenticate_user!

  def index
    params[:books_filter] ||= Settings.books_filter[:category]
    @search = Book.send(params[:books_filter], params[params[:books_filter]])
      .ransack(params[:q])
    @books = @search.result
      .joins(:category, :author, :publisher, :language)
      .page(params[:page]).per(Settings.per_page)
    @categories = Category.all
    @authors = Author.all
    @languages = Language.all
    @publishers = Publisher.all
  end

  def show
    @book = Book.find_by id: params[:id]
    unless @book
      flash[:danger] = t "books.book_infomation.not_found"
      redirect_to books_path
    end
  end
end
