RSpec.shared_context "recipe setup" do
  let(:user) { FactoryBot.create(:user) }
  let(:recipe) { FactoryBot.create(:recipe) }
end
