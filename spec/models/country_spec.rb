# spec/models/country_spec.rb
require 'rails_helper'

RSpec.describe Country, type: :model do
  subject {
    described_class.new(
      team: "Argentina",
      team_code: "ARG",
      associated_with: "AFA"
    )
  }

  describe "validations" do
    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    it "is not valid without a team" do
      subject.team = nil
      expect(subject).to_not be_valid
    end

    it "is not valid without a team_code" do
      subject.team_code = nil
      expect(subject).to_not be_valid
    end

    it "is not valid with a team_code that is not 3 characters long" do
      subject.team_code = "AR"
      expect(subject).to_not be_valid

      subject.team_code = "ARGU"
      expect(subject).to_not be_valid
    end

    it "is not valid without an association" do
      subject.associated_with = nil
      expect(subject).to_not be_valid
    end
  end

  describe "associations" do
    it { is_expected.to have_many(:home_matches) }
    it { is_expected.to have_many(:away_matches) }
  end

  describe 'column specifications' do
    it { is_expected.to have_db_column(:id).of_type(:integer) }
    it { is_expected.to have_db_column(:team).of_type(:string) }
    it { is_expected.to have_db_column(:team_code).of_type(:string) }
    it { is_expected.to have_db_column(:associated_with).of_type(:string) }
  end
end
