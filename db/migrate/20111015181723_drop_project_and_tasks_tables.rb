class DropProjectAndTasksTables < ActiveRecord::Migration
  def self.up
    drop_table :projects
    drop_table :tasks
  end

  def self.down
    create_table "projects", :force => true do |t|
      t.string   "name"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "tasks", :force => true do |t|
      t.integer  "project_id"
      t.string   "name"
      t.datetime "completed_at"
      t.datetime "created_at"
      t.datetime "updated_at"
    end
  end
end
