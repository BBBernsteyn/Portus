require "rails_helper"

feature "Images support" do
  let!(:registry) { create(:registry) }
  let!(:user) { create(:admin) }
  let!(:user2) { create(:user) }
  let!(:user3) { create(:user) }
  let!(:team) { create(:team, owners: [user], contributors: [user2], viewers: [user3]) }
  let!(:namespace) { create(:namespace, team: team) }
  let!(:repository) { create(:repository, namespace: namespace) }
  let!(:image) { create(:image, repository: repository) }
  let!(:tag) { create(:tag, repository: repository, image: image) }

  before do
    login_as user, scope: :user
  end

  describe "image#show" do
    before do
      visit repository_path(repository)
      within "tbody" do
        click_link image.docker_image_id
      end
    end

    scenario "Show breadcrumbs", js: true do
      within ".panel-heading" do
        expect(page).to have_content(namespace.clean_name)
        expect(page).to have_content(repository.name)
        expect(page).to have_content(image.docker_image_id)
      end
    end
  end
end
