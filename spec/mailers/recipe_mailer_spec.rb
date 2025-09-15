require "rails_helper"

RSpec.describe RecipeMailer, type: :mailer do
  describe "#recent" do
    let(:user) { FactoryBot.create(:user) }
    let(:date) { 1.week.ago }
    let!(:recent_recipe) { FactoryBot.create(:recipe, created_at: 3.days.ago) }
    let!(:old_recipe) { FactoryBot.create(:recipe, created_at: 8.days.ago) }

    it "renders an email of recent recipes" do
      mail = RecipeMailer.with(user: user, date: date).recent

      expect(mail.subject).to eq("Recent new recipes")
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(["recipes@example.com"])

      expect(mail.body).to include(recent_recipe.name)
      expect(mail.body).not_to include(old_recipe.name)
    end
  end
end
