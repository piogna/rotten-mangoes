class Movie < ActiveRecord::Base

  has_many :reviews

  mount_uploader :poster, PosterUploader

  validates :title, presence: true

  validates :director, presence: true

  validates :runtime_in_minutes, numericality: { only_integer: true }

  validates :description, presence: true

  validate :release_date_is_in_the_past

  def review_average
    reviews_sum = reviews.sum(:rating_out_of_ten)
    return reviews_sum/reviews.size if reviews_sum > 0
    return 0
  end

  protected

  def release_date_is_in_the_past
    if release_date.present?
      errors.add(:release_date, "should be in the past") if release_date > Date.today
    end
  end
end
