require 'rails_helper'

RSpec.describe "Projects", type: :request do
  let(:user)    { create(:user) }
  let(:project) { create(:project) }

  before do
    sign_in_as user
  end

  describe "GET /projects" do
    it "returns http success" do
      get projects_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /projects/:id" do
    it "renders the show template and includes project name" do
      get project_path(project)
      expect(response).to have_http_status(:success)
      expect(response.body).to include(project.name)
    end
  end

  describe "PATCH /projects/:id/change_status" do
    it "changes status, creates a ChangeLog, and streams turbo response" do
      expect {
        patch change_status_project_path(project, format: :turbo_stream), params: {
          project: { status: "active" }
        }
      }.to change { project.reload.status }.from("draft").to("active")

      change_log = project.change_logs.last
      expect(change_log.changed_data).to include("from" => "draft", "to" => "active")
      expect(response.media_type).to eq("text/vnd.turbo-stream.html")

      # Ensure turbo-stream template appended the new log
      expect(response.body).to match(/<turbo-stream action="prepend" target="project_#{project.id}">/)
    end

    it "returns unprocessable_entity for invalid status" do
      patch change_status_project_path(project, format: :turbo_stream), params: {
        project: { status: "invalid_status" }
      }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
