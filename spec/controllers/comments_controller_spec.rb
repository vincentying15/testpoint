require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let!(:issue) { create :issue }
  let!(:user) { create :user }
  let!(:comment) { create :comment, issue: issue, user: user }

  describe "POST create" do
    let(:attributes) { { content: "comment create" } }
    action { post :create, xhr: true, params: { comment: attributes, issue_id: issue.id } }
    it { is_expected.to respond_with :success }
  end
end
