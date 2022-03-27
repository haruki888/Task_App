class Task < ApplicationRecord
  belongs_to :user
  
  validates:name,length:{maximum: 50},presence:true
  validates:description,lenght:{maximum:100}
  
  validate:description_is_invalid_without_a_name
  
  def description_is_invalid_without_a_name
    errors.add(:name,"が必要です") if name.blank? && description.present?
  end  
end
