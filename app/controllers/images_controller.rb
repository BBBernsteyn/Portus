class ImagesController < ApplicationController
  before_action :set_image_and_repository, only: [:show, :update]

  respond_to :html, :js

  def show
    authorize @repository.namespace
  end

  def update
    @image.update_attributes(image_params)
  end

  private

  def set_image_and_repository
    @image = Image.find(params[:id])
    @repository = @image.repository
  end

  def image_params
    params.require(:image).permit(:dockerfile)
  end
end
