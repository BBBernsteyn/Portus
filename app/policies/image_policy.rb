# Defines the policy for the image object.
class ImagePolicy
  attr_reader :user, :image

  def initialize(user, image)
    @user = user
    @image = image
  end

  # Returns true if the image can be destroyed.
  def destroy?
    raise Pundit::NotAuthorizedError, "must be logged in" unless @user
    @user.admin? ||
      @image.tags.first.repository.namespace.team.owners.exists?(@user.id)
  end
end
