require "rails_helper"
require "spec_helper"
RSpec.describe "books/index", type: :view do

  describe "books/index.html.erb" do
    before do
      assign :books, FactoryGirl.create_list(:book, 10)
      assign :categories, FactoryGirl.create_list(:category, 2)
      assign :publishers, FactoryGirl.create_list(:publisher, 2)
      assign :languages, FactoryGirl.create_list(:language, 2)
      assign :authors, FactoryGirl.create_list(:author, 2)
      assign :search, Book.ransack(params[:q])
      allow(view).to receive_messages(paginate: nil)
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in FactoryGirl.create(:user)
      render
    end

    describe "UI book index page" do
      context "should have button Request by book" do
        it {expect(rendered).to have_link "Request by book"}
      end

      context "should have button Search" do
        it {expect(rendered).to have_button "Search"}
      end

      context "should have search field" do
        it {expect(rendered).to have_selector "input"}
      end

      context "should have link Category" do
        it {expect(rendered).to have_link "Category"}
      end

      context "should have link Author" do
        it {expect(rendered).to have_link "Author"}
      end

      context "should have link Publisher" do
        it {expect(rendered).to have_link "Publisher"}
      end

      context "should have link Language" do
        it {expect(rendered).to have_link "Language"}
      end

      context "should have two category" do
        categories = Category.all
        it {expect(rendered).to have_text categories.first.name, count:2}
      end

      context "should have two author" do
        authors = Author.all
        it {expect(rendered).to have_text authors.first.name, count:2}
      end

      context "should have two publisher" do
        publishers = Publisher.all
        it {expect(rendered).to have_text publishers.first.name, count:2}
      end

      context "should have two language" do
        languages = Language.all
        it {expect(rendered).to have_text languages.first.name, count:2}
      end

      context "should have ten link book" do
        books = Book.all
        it {expect(rendered).to have_xpath("//a[@href = '/books/#{books.first.title.downcase}']")}
      end
    end


    describe "test with mock and stub" do
      before do
        book1 = double "book"
        book2 = double "book"
        category1= double "category"
        category2= double "category"
        author1= double "author"
        author2= double "author"
        assign :books, [book1, book2]
        assign :categories, [category1, category2]
        assign :authors, [author1, author2]
        allow(view).to receive_messages(paginate: nil)
        @request.env["devise.mapping"] = Devise.mappings[:user]
        sign_in FactoryGirl.create(:user)
      end

      context "should have two link book" do
        allow(Book)
      end
    end
  end
end
