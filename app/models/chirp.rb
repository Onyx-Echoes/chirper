class Chirp < ActiveRecord::Base
  belongs_to :user
  attr_accessible :body

  validates :body, :presence => true, :length => {:maximum => 150}
end