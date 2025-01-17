# == Schema Information
#
# Table name: attachments
#
#  id                  :bigint(8)        not null, primary key
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  title               :text
#  attachmentable_id   :bigint(8)
#  attachmentable_type :string
#  content_type        :string
#

class Attachment < ApplicationRecord
  belongs_to :attachmentable, polymorphic: true, optional: true
  has_one_attached :file

  validates :title, presence: true, length: { maximum: 20 }, on: :update, if: -> { will_save_change_to_title? }

  before_create :assign_title, :assign_content_type

  def assign_title
    self.title = self.file.blob.filename
  end

  def assign_content_type
    self.content_type = self.file.blob.content_type
  end

  def image?
    file.image?
  end

  def video?
    file.video? && content_type.include?('mp4')
  end
end
