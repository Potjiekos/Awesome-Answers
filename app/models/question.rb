class Question < ActiveRecord::Base

# When using 'has_many' you must put a symbol for the associated record in plural format. You should also provide the :dependent option which can be either ':destroy:' which deletes all the associated answers when the question is deleted, or ':nullify:' which makes 'question_id' NULL for all associated answers.
  has_many :answers, dependent: :destroy
  belongs_to :category
  belongs_to :user

# validates_presence_of :title  # This is considered to be depricated- outdated syntax that will likely soon be removed and/or considered obsolete.

# Multiple fields of validation may also be written in a single line as:
# validates :title, :body, presence: true

# This is the long format

    validates(:title, {presence: true, uniqueness: {message: "must be unique!"}})
    validates :body, length: {minimum: 5}
    validates :view_count, numericality: {greater_than_or_equal_to: 0}

# This may be used to validate a valid email.
    # VALID_EMAIL_REGEX = /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
    # validates :email, format: VALID_EMAIL_REGEX

# This validates that the combination of title and body are unique. That means that the title by itself doesn't necessarily need to be unique, but the combination of both the title and body must be unique.
    # validates :title, uniqueness: {scope: [:body]}

# To build a custom validation method you use 'validate' instead of 'validates'. Here, we use 'validate' to reference a method that will be used for our custom validation.

  validate :no_monkey

# this will call the set_defaults method right after the initialize phase.
  after_initialize :set_defaults

  before_validation :titleize_title

# If you have a query or set of operations that are frequently executed, you may define a class method such as:

  # def self.recent_three
  #   order("created_at DESC").limit(3)
  # end

# And then call Question.recent_three to run it. It may also be written as:

scope :recent_three, lambda {order("created_at DESC").limit(3)}

# With the below method you may run Question.search("search_term") to look for entries with the search term in either the title or body.

  def self.search(search_term)
    where(["title ILIKE ? OR body ILIKE ?", "%#{search_term}%", "%#{search_term}%"])
# May also be written as:
#   where(["title ILIKE :term OR body ILIKE :term", {term: "%#{search_term}%"}])
  end

  def user_full_name
    user ? user.full_name : ""
  end

  private

  def titleize_title
    self.title = title.titleize
  end

  def set_defaults #||= or equals assigns a value if it is nil
    self.view_count ||= 0
  end

  def no_monkey
    if title.present? && title.downcase.include?("monkey")
      errors.add(:title, "No monkeys allowed!")
    end
  end


end
