require 'rails_helper'

RSpec.describe "Comments", type: :request do
  let(:user)    { create(:user) }
  let(:project) { create(:project) }

  before do
    sign_in_as user
  end

  describe "POST /projects/:project_id/comments" do
    context "with valid parameters" do
      it "creates a comment and streams turbo response" do
        expect {
          post project_comments_path(project, format: :turbo_stream), params: {
            comment: { body: "This is a test comment." }
          }
        }.to change(project.comments, :count).by(1)

        comment = project.comments.last
        expect(comment.body).to eq("This is a test comment.")
        expect(response.media_type).to eq("text/vnd.turbo-stream.html")
        expect(response.body).to include(comment.body)
      end
    end

    context "with invalid parameters" do
      it "does not create a comment and returns unprocessable_entity" do
        expect {
          post project_comments_path(project, format: :turbo_stream), params: {
            comment: { body: "" }
          }
        }.not_to change(project.comments, :count)

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
