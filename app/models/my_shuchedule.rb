class MyShuchedule < ApplicationRecord
  belongs_to :user
  #   scope :succeed_results, -> { where(deleted: false) }
  #   def succeed_shuchedule(target)
  #     @userShuchedule = User.find_by!(id: target.id)
  #   end
end
