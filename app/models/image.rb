# == Schema Information
#
# Table name: images
#
#  id              :integer          not null, primary key
#  repository_id   :integer
#  dockerfile      :text(65535)
#  docker_image_id :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_images_on_repository_id  (repository_id)
#

class Image < ActiveRecord::Base
  belongs_to :repository
  has_many :tags
end
