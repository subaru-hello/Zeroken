class Description < ApplicationRecord
  belongs_to :analyze_result

  def description(desc)
  when total_points > 3
    alcohol_strongness = 4
   when total_points > 0
    alcohol_strongness =  3
   when total_points > -3
     alcohol_strongness = 1
   when total_points < -3
     alcohol_strongness =  0
   else 
     alcohol_strongness =  2
   end
  end
end
