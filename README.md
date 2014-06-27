AutoSchema
===
AutoSchema allows you to define database structure in model, with a ActiveRecord::Migration like DSL. When the code in model updates, the database structure will be automatically updated.


Getting Started
---
This gem is still in development! But you can try it by adding the following line to your Gemfile.

```ruby
gem 'auto_schema', github: 'bbtfr/auto_schema'
```


How it works
---
When we create a new model like this:

```ruby
class TestModel
    
    table do
        t.string :title
    end

end
```

It will create a table named `test_models` with 2 columns `title` and `id` when the class is loaded for the first time, and the code in `table` block will always be in sync with the database structure, which means you can simply create/remove one column in the database by adding/deleting one line of your codes, without running `rake db:migrate`, just refresh your web page you can see the change.

For example, add a new line and delete an existed line:
```ruby
class TestModel
    
    table do
        t.integer :category_id
    end

end
```
and refresh your web page, the column `title` will be removed and new column `category_id` will be created in your database.

TODO
---
1. More column type (:string, :text, :integer, :float, :decimal, :datetime, :time, :date, :binary, :boolean by now), more options (:default, :limit by now) support
2. Works with other gems' migration DSL, like Paperclip's `t.attachement`
3. Find a way to `rename_column`, but not remove then create new one.


License
---
This project rocks and uses MIT-LICENSE.