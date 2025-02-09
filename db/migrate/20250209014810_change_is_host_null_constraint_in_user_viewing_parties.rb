class ChangeIsHostNullConstraintInUserViewingParties < ActiveRecord::Migration[7.1]
  def change
    change_column_null :user_viewing_parties, :is_host, false
  end
end
