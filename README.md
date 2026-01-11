# Change Log

Change Log is a gem keeps all model changes you care about.
It keeps a record of who made which change at what time.

You can skip any database columns as well.
For example: `updated_at`, `created_at` and `password` etc.

## Installation

Add it to your `Gemfile` then `bundle install`

```
gem 'change_log'
```

Next we need to create a table to keep all changes

Generate a migration:

```
rails generate change_log ChangeLog
```

Then:

```sh
rails db:migrate
```

## Use Change Log Gem

1. **Add current_user Method in application_controller.rb**

This method will tell change_log who is the current user

```ruby
def current_user
  return session[:user] # replace this with your own code
end
```

2. **ActiveRecord Models**  
   Enable change_log for Active Record Model,  
   just put following line in very beginning of model file.

```ruby
enable_change_log :ignore=>[:updated_at]
```

Put any columns you do not want to keep in the change log table in `:ignore` option.  
eg. the password hash

Then the system should record every changes the user made to change_log table.  
If you are making changes within Model file:  
For Example:

```ruby
# this is a model file
def making_some_changes
  user = User.first
  user.email = 'peter@example.com'
  user.save
end
```

An attribute called `whodidit` is automatically available.  
So if you want to keep the changes in this scenario, do following:

```ruby
# this is a model file
def making_some_changes
  user = User.first
  user.email = 'peterz@ncs.co.nz'
  user.whodidit = 'Peter'
  user.save
end
```

3. **About the ChangeLogs Model**  
   ChangeLogs model is core ActiveRecord model used by change_log gem.

You can use it directly in your model, controller even in helper.

For example:

```ruby
# List all changes
ChangeLogs.all
```

```ruby
# List all changes made by user 'peterz'
ChangeLogs.where('user = ?', 'peterz')
```

```ruby
# List all changes for table 'accounts'
ChangeLogs.where('table_name = ?', 'accounts')
```

4. **Turn ChangeLogs off in testing environment**  
   You can globally turn it off for your testing.

```ruby
# config/environment.rb
ChangeLog.enabled = false if Rails.env.test?
```

5. **Database and table name**  
   change_log gem can save changes into separate database from the main application.  
   The database could be MySQL, SQLite or any other database that active record is happy to connect with.

Here is an example of database.yml when using separate database for 'change_logs':

```yaml
change_logs:
  adapter: mysql2
  encoding: utf8
  database: change_logs
  username: username
  password: ********
  host: hostname
  port: 3306
```

And also you need to tell change_log gem to establish the connection.

```ruby
# config/environment.rb
ChangeLogs.establish_connection(:change_logs)
```

Table name is also configurable. Instead of 'change_logs', choose your preferred table name and run the migration.  
Just remember in your environment.rb file, you need to tell change_log gem what is your table name:

```ruby
# config/environment.rb
ChangeLogs.table_name :hr_maintenances
```

## Wish List

Please email me if you have any enquiry.

### Author

Peter Zhang  
Copyright (c) 2026 Peter Zhang, released under the MIT license
