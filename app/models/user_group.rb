class UserGroup < ApplicationRecord
  belongs_to :judicial_result_prompt, optional: true, inverse_of: :user_groups
end
