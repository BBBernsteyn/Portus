require "rails_helper"

describe Image do
  it { should belong_to(:repository) }
  it { should have_many(:tags) }
end
