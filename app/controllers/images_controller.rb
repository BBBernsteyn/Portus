class ImagesController < ApplicationController
  before_action :set_image_and_repository, only: :show

  def show
  end

  private

  def set_image_and_repository
    @image = Image.find(params[:id])
    @repository = @image.repository
  end
end
