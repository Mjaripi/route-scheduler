# README

This project uses:
* Ruby 3.1.2
* Rails 7.0.4
* Node 14.21.1
* Postgres 14.3

To run on local
-----
Run the following commands on the root of the repo:
* `bundle install`
* `yarn install`

Prepare the database
* `rails db:create`
* `rails db:migrate`
* `rails db:seed`

Note: Seed currently not configured.

Finally, to start the application run:
```bash
bin/dev
```

To execute the console run:
```bash
rails c
```

### Create a model object
The following factories are currently created:
* :organization
* :vehicle
* :driver
* :user
* :route

Example:
* To create one object
```ruby
FactoryBot.create(:organization)
```
* To create n objects, in this case 5
```ruby
FactoryBot.create_list(:organization, 5)
```
