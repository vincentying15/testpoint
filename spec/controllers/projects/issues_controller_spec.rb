require 'rails_helper'

RSpec.describe Projects::IssuesController, type: :controller do
  let!(:project) { create :project }
  let(:plan) { create :plan, project: project }
  let(:task) { plan.tasks.first }
  let(:issue) { create :issue, project: project }
  let(:superadmin) { create :user, :superadmin }
  let!(:owner) { create :member, :owner, project: project, user: superadmin }
  let!(:manager) { create :member, :manager, project: project }
  before { sign_in superadmin }

  describe "GET index" do
    let!(:label) { create :label }
    let!(:issue) { create :issue, label_ids: [label.id], project: project }
    let!(:attributes) { { project_id: project.id } }
    action { get :index, params: attributes }

    context "without task" do
      it { is_expected.to respond_with :success }
    end

    context "with related_task" do
      before { attributes[:related_task] = task.id }

      it { is_expected.to respond_with :success }
    end

    context "filter by created" do
      before { attributes[:filter] = "assigned" }

      it { is_expected.to respond_with :success }
    end

    context "filter by assigned" do
      before { attributes[:filter] = "created" }

      it { is_expected.to respond_with :success }
    end

    context "filter by subscribed" do
      before { attributes[:filter] = "subscribed" }

      it { is_expected.to respond_with :success }
    end

    context "filter by states" do
      context "filter opending issues" do
        before { attributes[:q] = { "state_filter" => "opening" } }

        it { is_expected.to respond_with :success }
      end
      context "filter all issues" do
        before { attributes[:q] = { "state_filter" => "all" } }

        it { is_expected.to respond_with :success }
      end

      context "filter closed issues" do
        before { attributes[:q] = { "state_filter" => "closed" } }

        it { is_expected.to respond_with :success }
      end
    end
  end

  describe "GET new" do
    action { get :new, params: { task_id: task.id, project_id: project.id } }
    it { is_expected.to respond_with :success }
  end

  describe "POST create" do
    let(:attributes) { { title: "issue create", content: "content for issue" } }
    action { post :create, params: { issue: attributes, task_id: task.id, project_id: project.id } }

    context "assignee other members as creator" do
      let!(:user) { create :user }
      let!(:member) { create :member, project: project, user: user }
      before { attributes[:creator_id] = member.id }

      it { is_expected.to respond_with :redirect }
    end

    context "admin creat the issue" do
      it { is_expected.to respond_with :redirect }
    end
  end

  describe "GET edit" do
    action { get :edit, params: { project_id: project.id, id: issue.id } }

    it { is_expected.to respond_with :success }
  end

  describe "PUT update" do
    context "update with valid attributes" do
      let(:attributes) { { title: "issue update", content: "hello" } }
      action { put :update, params: { id: issue.id, issue: attributes, project_id: project.id } }

      it { is_expected.to respond_with :redirect }
    end

    context "update with invalid attributes" do
      let!(:attributes) { { title: "" } }
      action { put :update, params: { id: issue.id, issue: attributes, project_id: project.id } }

      it { expect(issue.title).not_to be_empty }
    end

    context "update with state to generate activities" do
      let(:attributes) { { state: "closed" } }
      action { put :update, params: { id: issue.id, issue: attributes, project_id: project.id } }

      it { is_expected.to respond_with :redirect }
    end
  end

  describe "GET show" do
    context "without comments" do
      action { get :show, params: { id: issue.id, project_id: project.id } }
      it { is_expected.to respond_with :success }
    end

    context "with comments" do
      let!(:comment) { create :comment, content: "<p>this is a comment</p>", issue: issue }
      before { issue.update(state: "processing") }
      action { get :show, params: { id: issue.id, project_id: project.id } }
      it { is_expected.to respond_with :success }
    end
  end
end
