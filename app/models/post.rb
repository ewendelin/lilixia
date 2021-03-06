class Post < ApplicationRecord
  belongs_to :restaurant
  has_many :claims, dependent: :destroy

  validates :name, presence: true
  validates :original_price, numericality: true
  validates :discount, numericality: { greater_than: 0, less_than_or_equal_to: 1 }
  validates :start_time, presence: true
  validates :end_time, presence: true
  validate :end_must_be_after_start
  before_save :clean_time_zone
  mount_uploader :image, PhotoUploader

  def clean_time_zone
    self.start_time = self.start_time - 8.hours if self.start_time
    self.end_time = self.end_time - 8.hours if self.end_time
  end

  def everyday_enum
    ['yes', 'no']
  end

  def kind_enum
    ['admin', 'manager']
  end

  def discount_price
    return original_price*discount
  end

  def end_must_be_after_start
    if start_time >= end_time
      errors.add(:end_time, "End time must be greater than start time")
    end
  end

  def active_inactive
    if everyday == "yes"
      return "active"
    elsif end_time.hour >= Time.now.hour && everyday == "no"
      return "active"
    else
      return "inactive"
    end
    # @posts = Post.where(end_time.hours > Time.now.hours).select{ |post| (post.everyday == "no")}
  end

  def start_time
    s = super
    return nil if s.nil?
    s.in_time_zone('Beijing')
  end
  def end_time
    s = super
    return nil if s.nil?
    s.in_time_zone('Beijing')
  end
end
