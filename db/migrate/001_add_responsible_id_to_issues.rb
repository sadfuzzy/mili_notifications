class AddResponsibleIdToIssues < ActiveRecord::Migration
  def change
    add_column :issues, :responsible_id, :integer
  end
end
