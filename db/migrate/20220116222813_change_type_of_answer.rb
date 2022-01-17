class ChangeTypeOfAnswer < ActiveRecord::Migration[6.1]

  def change
    def change
      change_column :answers, :point, :float
    end
  end
end
