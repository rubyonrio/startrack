class Comment < ActiveRecord::Base
  belongs_to :story
end
