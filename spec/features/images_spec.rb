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

    describe "image#show" do
      scenario "Show breadcrumbs", js: true do
        within "#breadcrumbs" do
          expect(page).to have_content(namespace.clean_name)
          expect(page).to have_content(repository.name)
          expect(page).to have_content(image.docker_image_id)
        end
      end

      scenario "Show tags", js: true do
        within "#tags" do
          expect(page).to have_content(tag.name)
        end
      end

      scenario "Show Dockerfile", js: true do
        within "#dockerfile .ace_editor" do
          expect(page).to have_content(image.dockerfile)
        end
      end
    end
  end

  describe "#update" do
    before do
      visit repository_path(repository)
      within "tbody" do
        click_link image.docker_image_id
      end
    end

    let(:maintainer_info) { "MAINTAINER jane@doe.org" }
    let(:edited_dockerfile) { image.dockerfile + "\r\n" + maintainer_info }

    scenario "persists changes", js: true do
      payload = ActionController::Base.helpers.escape_javascript(edited_dockerfile)

      find("#edit_dockerfile").click
      page.execute_script("ace.edit('editor').setValue('#{payload}');")

      find("#dockerfile button[type='submit']").click
      wait_for_ajax

      expect(image.reload.dockerfile).to eql(edited_dockerfile)
    end
  end
end
