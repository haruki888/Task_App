class AddAdminToUsers < ActiveRecord::Migration[5.1]
   def change  #migrationの時にはそのメソッドを実行し、ロールバックの時には、その処理と逆の処理をRailsが自動で判定して行う。
    add_column :users, :admin, :boolean, default: false
  end
end
