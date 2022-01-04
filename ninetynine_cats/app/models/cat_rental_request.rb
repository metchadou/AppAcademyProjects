class CatRentalRequest < ApplicationRecord
  STATUS = %w(PENDING APPROVED DENIED)

  validates :cat_id, :start_date, :end_date, :status, presence: true
  validates :status, inclusion: STATUS
  validate :does_not_overlap_approved_request

  belongs_to :cat

  def pending?
    status == 'PENDING'
  end

  def approve!
    ActiveRecord::Base.transaction do
      self.status = 'APPROVED'

      self.save!

      self.overlapping_pending_requests.each do |request|
        request.deny!
      end
    end
  end

  def deny!
    self.update_attribute(:status, 'DENIED')
  end

  def does_not_overlap_approved_request
    if overlapping_approved_requests.exists?
      errors[:overlapping_request] << ', cat has been rented out for this period'
    end
  end

  def overlapping_pending_requests
    overlapping_requests.where(status: 'PENDING')
  end

  def overlapping_approved_requests
    overlapping_requests.where(status: 'APPROVED')
  end

  def overlapping_requests
    CatRentalRequest
      .where.not(id: self.id)
      .where(cat_id: cat_id)
      .where.not("start_date > ?", end_date)
      .where.not("end_date < ?", start_date)
  end

end