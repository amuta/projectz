## README

### ProjectZ - Project History Tracker 🚀

**Live Application Link:** [https://projectz.fly.dev/](https://projectz.fly.dev/)

ProjectZ is a Ruby on Rails application designed to track the history of projects, allowing users to leave comments and change project statuses. The application showcases real-time updates for comments and status changes using Turbo Streams and is set up for automated testing, linting, and deployment via GitHub Actions and Fly.io.

---

### Getting Started (Quick Start)

1.  **Account Creation:**
    * Navigate to the [live application](https://projectz.fly.dev/).
    * You can log in with any email and password. If the account doesn't exist, it will be created automatically. This simplified process is for ease of testing this assignment.
2.  **Create a Project:**
    * Once logged in, create a new project.
3.  **Interact:**
    * Leave comments on the project.
    * Change the project's status.
    * Observe live updates for comments and status changes, powered by Turbo Streams.

---

### Addressing the Brief: Questions & Design Choices 📝

As per the task, the following questions were considered to clarify the project requirements, along with the assumed answers that guided the development:

* **What version of Rails? Any other ruby/rails or test/deploy related requirements?**
    * **Answer:** Use Rails 7, RSpec for tests, PostgreSQL for the database, and deploy anywhere for the MVP.
* **Is authentication required? If so how should it be implemented?**
    * **Answer:** Yes. Implement basic user/password authentication without any external libraries. User creation can be done directly from the console for now. (A simplified web-based creation/login is implemented for this demo as seen in `app/controllers/sessions_controller.rb`).
* **What attributes or relations should the Project model have?**
    * **Answer:**
        * **Attributes:** Project name, creation datetime, last change datetime, current status. (Note: `description` was also added as a necessary attribute).
        * **Relations:** Has many status changes (implemented as `change_logs`), has many comments.
* **Should anyone be able to change or comment on any project?**
    * **Answer:** The ideal design was: "No, only the users added to that project. Only the creator or users that were added to the project can (or admins) can add or remove other users from a project."
    * **Current Implementation Note:** For the scope of this assignment and to simplify review, this feature was simplified. Currently, any authenticated user can see, comment on, and change the status of any project. The `Current.user` is, however, associated with these actions for logging purposes (e.g., in `app/controllers/comments_controller.rb` and `app/controllers/projects_controller.rb`).
* **What are the possible project statuses?**
    * **Answer:** Active, OnHold, Cancelled, Completed. (Note: A `draft` status was also added as an initial default. The implemented statuses are: `draft`, `active`, `on_hold`, `completed`, `cancelled` as seen in `app/models/project.rb`).
* **Are there rules for statuses changes? For example, should a Cancelled or Completed project be updated to Active?**
    * **Answer:** The ideal design was: "There are rules. No the only possible changes are: Active -> OnHold, Cancelled, Completed; OnHold -> Active, Cancelled, Completed; Cancelled or Completed statuses can't be changed."
    * **Current Implementation Note:** This specific state transition logic is not strictly enforced in the current simplified version. Any status can be changed to another via the UI, but the infrastructure (e.g., model callbacks or service objects) could be extended to enforce these rules.

---

### Features ✨

* User authentication (simplified: login creates user if not exists).
* Project creation, viewing, listing, and updating.
* Commenting on projects with real-time updates using Turbo Streams.
* Changing project statuses with real-time updates using Turbo Streams.
* Listing comments and project status changes (change logs) on the project page.
* Automated CI/CD pipeline using GitHub Actions for running tests, linting, and deploying to Fly.io.

---

### Tech Stack 🛠️

* **Backend:** Ruby on Rails 8.0 (as per `config/application.rb`).
* **Database:** PostgreSQL (default for Rails 8, configured in `config/database.yml`).
* **Testing:** RSpec.
* **Linters:** RuboCop with `rubocop-rails-omakase`.
* **Frontend:**
    * Hotwire (Turbo, Stimulus).
    * Tailwind CSS (via `tailwindcss-rails` gem, indicated by `app/assets/tailwind/application.css` and `config/puma.rb`).
* **Deployment:** Fly.io (configured via GitHub Actions).
* **Version Control:** Git, GitHub.
* **Dependency Management:** Bundler, Importmap.

---

### Local Setup & Installation 💻

1.  **Prerequisites:**
    * Ruby (see `.ruby-version` file - though not provided in the file list, typical for Rails 8 would be Ruby 3.x).
    * Bundler.
    * Node.js & Yarn (primarily for Tailwind CSS compilation if not using standalone).
    * PostgreSQL server running.
2.  **Clone the repository:**
    ```bash
    git clone <repository-url>
    cd projectz
    ```
3.  **Install dependencies:**
    ```bash
    bundle install
    ```
    Install Tailwind CSS:
    ```bash
    ./bin/rails tailwindcss:install
    ```
4.  **Database Setup:**
    Ensure your `config/database.yml` is configured for your local PostgreSQL instance.
    ```bash
    bin/rails db:create
    bin/rails db:migrate
    ```
5.  **Run the application:**
    ```bash
    bin/rails server
    ```
    The application will be available at `http://localhost:3000`.

---

### Running Tests & Linting 🧪

* **Run RSpec tests:**
    ```bash
    bin/bundle exec rspec
    ```
    (Automated in CI)
* **Run RuboCop for linting:**
    ```bash
    bin/rubocop -f github
    ```
    (Automated in CI)
* **Run Brakeman for security vulnerabilities scan (Rails):**
    ```bash
    bin/brakeman --no-pager
    ```
    (Automated in CI)
* **Run Importmap audit for JS dependency vulnerabilities:**
    ```bash
    bin/importmap audit
    ```
    (Automated in CI)

---

### Deployment ☁️

* The application is configured for deployment on Fly.io.
* Continuous deployment is set up using GitHub Actions, as defined in `.github/workflows/ci.yml`. This workflow handles testing, linting, and deploying the application to Fly.io upon pushes to the `main` branch.

---