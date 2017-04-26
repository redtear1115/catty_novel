class Chapter < ApplicationRecord
  belongs_to :novel, dependent: :destroy
end
