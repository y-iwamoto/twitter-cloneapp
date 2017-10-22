class Comment < ActiveRecord::Base
  belongs_to :user
  has_many :notifications, dependent: :destroy
  default_scope -> { order('created_at DESC') }
end
