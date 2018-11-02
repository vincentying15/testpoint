class Projects::CommentsController < BaseProjectController
  before_action -> { @project = current_project }
  authorize_resource :project
  load_and_authorize_resource :issue
  load_and_authorize_resource through: :issue
  load_and_authorize_resource through: :project

  def new
  end

  def create
    @comment.user = current_user
    @comment.save
    respond_with @comment, location: ok_url_or_default([@project, @issue])
  end

protected
  def comment_params
    params.fetch(:comment, {}).permit(:content, comment_attachments_attributes: [:id, :attachment_id, :_destroy])
  end
end