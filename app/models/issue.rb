# == Schema Information
#
# Table name: issues
#
#  id           :bigint(8)        not null, primary key
#  title        :string
#  content      :text
#  state        :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  milestone_id :bigint(8)
#  creator_id   :bigint(8)
#  assignee_id  :bigint(8)
#  project_id   :bigint(8)
#

class Issue < ApplicationRecord
  enumerize :state, in: [:open, :processing, :closed, :solved], default: :open

  has_many :tasks, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :issues_labels, dependent: :destroy
  has_many :labels, through: :issues_labels
  belongs_to :milestone, optional: true
  belongs_to :creator, class_name: User.to_s
  belongs_to :assignee, class_name: User.to_s, optional: true
  belongs_to :project

  has_many :issue_attachments, dependent: :destroy
  accepts_nested_attributes_for :issue_attachments, allow_destroy: true
  has_many :attachments, as: :attachmentable, through: :issue_attachments, dependent: :destroy

  validates :title, presence: true

  scope :with_labels, -> { includes(:labels) }
  scope :opened, -> { where(state: "open") }
  scope :created_issues, ->(user) { where(creator_id: user.id) }
  scope :assigned_issues, ->(user) { where(assignee_id: user.id) }

  def default_title
    tasks.map do |task|
      test_case = task.test_case
      "#{test_case.component.name}-#{test_case.title}"
    end.join(" ")
  end

  def default_content
    tasks.map(&:message).join(" ")
  end
end
