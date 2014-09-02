AutoSchema
===
AutoSchema allows you to define database structure in model, with a ActiveRecord::Migration like DSL. When the code in model updates, the database structure will be automatically updated.


Getting Started
---
This gem is still in development! But you can try it by adding the following line to your Gemfile.

```ruby
gem 'activerecord-autoschema', github: 'bbtfr/activerecord-autoschema'
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
        t.text :desc, index: true
    end

end
```
and refresh your web page, the column `title` will be removed and new column `desc` with an index will be created in your database.

AutoSchema also support Rails style column type, eg: `:timestamps`, `:references`:
```ruby
class TestModel
    
    table do
        t.integer :user_id
        t.index   :user_id

        t.string :title, limit: 128, null: false
        t.text   :desc
        t.references :category, index: true
        t.boolean :published, index: true

        t.attachement :image

        t.timestamps
    end

end
```

AutoSchema now support column types:

> :string, :text, :integer, :float, :decimal, :datetime, :time, :date, :binary, :boolean, :timestamps, :references, :attachement

AutoSchema now support column options:

> :default, :limit, :null, :index

TODO
---
1. Works with other gems' migration DSL, like Paperclip's `t.attachement`.
2. Find a way to `rename_column`, but not remove then create new one.

CHANGELOG
---
0.0.2 `:timestamps` `:references` `options[:null]` `index` support

License
---
This project rocks and uses MIT-LICENSE.