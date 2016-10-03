require 'spec_helper'

describe LeagueOfLegends::GameVersion, vcr: { cassette_name: "league_of_legends/game_version" } do
  describe '.all' do
    it 'returns all the game versions' do
      version = described_class.new(number: "6.20.1")

      all_versions = described_class.all

      expect(all_versions.count).to eq 146

      first_version = all_versions.first

      expect(first_version).to eq version
    end
  end

  describe '.last' do
    it 'returns the last game version' do
      version = described_class.new(number: "6.20.1")

      expect(described_class.last).to eq version
    end
  end

  describe '#initialize' do
    it 'sets the version passed as arguments' do
      version = described_class.new(number: "0.151.2")

      expect(version.number).to eq "0.151.2"
    end
  end

  describe '#==' do
    let(:version1) { described_class.new(number: "0.151.2") }

    context 'when is TRUE' do
      it 'all the attributes of compared objects are equal' do
        version2 = described_class.new(number: "0.151.2")

        expect(version1).to eq version2
      end
    end

    context 'when is FALSE' do
      it 'any of the attributes of compared objects are different' do
        version2 = described_class.new(number: "0.151.3")

        expect(version1).to_not eq version2
      end
    end
  end
end
