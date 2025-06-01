require 'rails_helper'

RSpec.describe WeeklyDigestJob, type: :job do
  describe "#perform" do
    let!(:user1) { FactoryBot.create(:user) }
    let!(:user2) { FactoryBot.create(:user) }

    it "sends weekly digest emails to all users" do
      mailer_double = instance_double(ActionMailer::MessageDelivery)
      allow(RecipeMailer).to receive(:with).and_return(RecipeMailer)
      allow(RecipeMailer).to receive(:recent).and_return(mailer_double)
      allow(mailer_double).to receive(:deliver_later)

      WeeklyDigestJob.perform_now

      freeze_time = Time.current do
        expected_date = 1.week.ago

        expect(RecipeMailer).to have_received(:with)
          .with(user: user1, date: expected_date)
        expect(RecipeMailer).to have_received(:with)
          .with(user: user2, date: expected_date)
        expect(RecipeMailer).to have_received(:recent).exactly(2).times
        expect(mailer_double).to have_received(:deliver_later).exactly(2).times
      end
    end
  end
end
