class Question < ApplicationRecord
validates_length_of :text, maximum: 255

end
