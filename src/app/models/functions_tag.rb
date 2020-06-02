class FunctionsTag < ApplicationRecord
  belongs_to :function
  belongs_to :tag, counter_cache: true
end
