class CommentsController < ApplicationController
  before_action :set_project

  def create
    @comment = @project.comments.build(comment_params.merge(user: Current.user))
    if @comment.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to @project }
      end
    else
      head :unprocessable_entity
    end
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
