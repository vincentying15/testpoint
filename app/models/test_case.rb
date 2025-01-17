# == Schema Information
#
# Table name: test_cases
#
#  id           :bigint(8)        not null, primary key
#  title        :string
#  content      :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  component_id :bigint(8)
#  archived     :boolean          default(FALSE)
#  project_id   :bigint(8)
#

class TestCase < ApplicationRecord
  belongs_to :component
  has_and_belongs_to_many :platforms
  belongs_to :project

  cleanup_column :title, :content

  validates :title, :component_id, :platform_ids, presence: true

  scope :available, -> { where(archived: false) }
  scope :archived, -> { where(archived: true) }
  scope :with_component, -> { joins(:component).includes(:component) }

  def archive
    update(archived: true)
  end
end
