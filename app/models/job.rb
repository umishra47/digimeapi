class Job < ActiveRecord::Base
   attr_accessor :name, :public, :author

   validates :title, presence: true 
end
