class UserBook < ActiveRecord::Base
  belongs_to :user
  belongs_to :book
  has_many :comments, dependent: :destroy
  validates :user, presence: true
  validates :book, presence: true

  scope :favorited, -> do
    where is_favorite: true
  end

  scope :reading_history, -> do
    read_reading_status = "#{Settings.user_book_status.reading},
      #{Settings.user_book_status.read}"
    where "status IN (#{read_reading_status})"
  end

  scope :current_user_rating, -> user {find_by user_id: user.id}

  after_update :update_book

  def average_rating user_rating
    total_rating = self.book.user_books.count + 1
    (self.book.average_rating * total_rating + user_rating.to_f)/total_rating
  end

  private

  def update_book
    book_average_rating = average_rating self.rating
    self.book.update average_rating: book_average_rating
  end
end
