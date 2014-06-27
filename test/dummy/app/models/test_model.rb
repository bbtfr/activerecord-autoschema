class TestModel < ActiveRecord::Base

  table do |t|
    t.string :title
    t.string :name
    t.integer :hello
  end

end