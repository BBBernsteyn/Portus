class RepurposeImageIdOnTags < ActiveRecord::Migration
  def up
    tags = Tag.all.select do |tag|
      tag.image_id && !tag.image_id.empty?
    end

    images = tags.map do |tag|
      Image.create docker_image_id: tag.image_id,
        repository_id: tag.repository_id
    end

    tags.each do |tag|
      tag.update image_id: nil
    end

    change_column :tags, :image_id, :integer, default: nil
    add_index :tags, :image_id
    Tag.reset_column_information

    tags.each_with_index do |tag, index|
      tag.update image_id: images[index].id
    end
  end

  def down
    tag_id_and_image = Tag.select(&:image).map do |tag|
      [tag.id, tag.image]
    end

    change_column :tags, :image_id, :string, default: ''
    remove_index :tags, :image_id
    Tag.reset_column_information

    tag_id_and_image.each do |(tag_id, image)|
      Tag.find(tag_id).update image_id: image.docker_image_id
      image.destroy
    end
  end
end
