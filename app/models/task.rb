class Task < ApplicationRecord
  belongs_to:user # 1対1
  validates:name,presence:true,length:{maximum:30}
  validates:description,presence:true,length:{maximum:100}
end
