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

FactoryGirl.define do
  factory :image do
    dockerfile "FROM scratch\nADD rootfs.tar.gz /"
    docker_image_id  "7d7ae134f8eb"
    repository
  end
end
