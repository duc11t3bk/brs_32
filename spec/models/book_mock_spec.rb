require "rails_helper"

describe Book do
  before do
    @book = instance_double("Book",
      title: "Harry Portter",
      cover_image_name: "book.jpg",
      number_of_pages: 400,
      description: "description",
      publish_date: "2016-09-14",
      price: 500,
      author_id: 1,
      category_id: 1,
      publisher_id: 1,
      language_id: 1,
      is_in_library: true,
      average_rating: 5.0)
  end

  it "should return same title if call title from book" do
    expect(@book.title).to eq "Harry Portter"
  end

  it "should return same cover_image_name if call cover_image_name from book" do
    expect(@book.cover_image_name).to eq "book.jpg"
  end

  it "should return same number_of_pages if call title from book" do
    expect(@book.number_of_pages).to eq 400
  end

  it "should return same description if call title from book" do
    expect(@book.description).to eq "description"
  end
end
