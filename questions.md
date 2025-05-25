# Project Project History

Defined task:
- be able to leave a comment on a project
- change status on a project
- list comments and changes in status of a project
- use ruby on rails to build

# My questions and answers:

- What version of Rails? Any other ruby/rails or test/deploy related requirements?
Use Rails 7, use RSpec for tests, Postgres for database and deploy anywhere for the MVP. 
- Is authentcation required? If so how should it be implemented?
Yes. Implement some basic user/password authentication without any external libraries. The user creation can be done directly form the console for now.

- What attributes or relations should the Project model have?
For attributes it should have the 
    project name, 
    creation datetime, 
    last change datetime, 
    current status.
Relations:
    has many status changes, 
    has many comments

But feel free to add some other attributes if you see necessary 

- Should anyone be able to change or comment any project?
No, only the users added to that project. Only the creator or users that were added to the project can (or admins) can add or remove other users from a project.

- what are the possible project statuses?
Active, OnHold, Cancelled, Completed,

- Are there rules for statuses changes? for example should a Cancelled or Completed project be updated to Active?
There are rules. No the only possible changes are:
 Active -> OnHold, Cancelled, Completed
 OnHold -> Active, Cancelled, Completed
 Cancelled or Completed statuses can't be changed.


