# frozen_string_literal: true

class Contact < ApplicationRecord
  belongs_to :group
  belongs_to :user
  has_one_attached :avatar

  validates :name, :email, :group_id, presence: true
  validates :name, length: { minimum: 2 }
  validate :avatar_format
  def gravatar
    hash = Digest::MD5.hexdigest(email.downcase)
    "https://www.gravatar.com/avatar/#{hash}"
  end

  scope :search, -> (term){
    where('LOWER(name) LIKE :term or LOWER(company) LIKE :term or LOWER(email) LIKE :term', term: "%#{term.downcase}%") if term.present?
  }
  # def self.search(teLOWER(rm)
  #   if term && !term.empty?
  #     where('name LIKE ?', "%#{term}%")
  #   else
  #     all
  #   end
  # end

  scope :by_group, -> (group_id){
    where(group_id: group_id) if group_id.present?
  }
  # def self.by_group(group_id)
  #   if group_id && !group_id.empty?
  #     where(group_id: group_id)
  #   else
  #     all
  #   end
  # end 

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
