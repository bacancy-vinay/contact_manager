# frozen_string_literal: true

class Contact < ApplicationRecord
  belongs_to :group
  has_one_attached :avatar

  validates :name, :email, :group_id, presence: true
  validates :name, length: { minimum: 2 }
  validate :avatar_format
  def gravatar
    hash = Digest::MD5.hexdigest(email.downcase)
    "https://www.gravatar.com/avatar/#{hash}"
  end

  private

  def avatar_format
    return unless avatar.attached?

    if avatar.blob.content_type.start_with? 'image/'
      if avatar.blob.byte_size > 1.megabytes
        errors.add(:avatar, 'size needs to be less than 1MB')
        avatar.purge
      end
    else
      avatar.purge
      errors.add(:avatar, 'needs to be an image')
     end
  end

end
