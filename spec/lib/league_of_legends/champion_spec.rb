require 'spec_helper'

describe LeagueOfLegends::Champion, vcr: { cassette_name: "league_of_legends/champion" } do
  describe '.all' do
    it 'returns all the champions' do
      champion1 = described_class.new(id: 89,
                                      title: "the Radiant Dawn",
                                      name: "Leona",
                                      key: "Leona",
                                      info: { "attack" => 4, "defense" => 8, "magic" => 3, "difficulty" => 4 })

      all_champions = described_class.all

      expect(all_champions.count).to eq 132

      first_champion = all_champions.first

      expect(first_champion).to eq champion1
    end
  end

  describe '.search_by' do
    it 'returns the champions queried by a value' do
      champion1 = described_class.new(id: 89,
                                      title: "the Radiant Dawn",
                                      name: "Leona",
                                      key: "Leona",
                                      info: { "attack" => 4, "defense" => 8, "magic" => 3, "difficulty" => 4 })

      champions = described_class.search_by("Leon")

      expect(champions.count).to eq 1

      expect(champions).to include champion1
    end

    describe '.find' do
      it 'returns the champion by id' do
        champion1 = described_class.new(id: 89,
                                        title: "the Radiant Dawn",
                                        name: "Leona",
                                        key: "Leona",
                                        info: { "attack" => 4, "defense" => 8, "magic" => 3, "difficulty" => 4 })

        expect(described_class.find(89)).to eq champion1
      end
    end
  end

  describe '#initialize' do
    it 'sets the attributes passed as arguments' do
      attributes = { id: 79, title: "the Rabble Rouser", name: "Gragas", key: "Gragas", info: { "attack" => 4, "defense" => 7, "magic" => 6, "difficulty" => 5 } }

      champion = described_class.new(attributes)

      expect(champion.id).to eq 79
      expect(champion.title).to eq "the Rabble Rouser"
      expect(champion.name).to eq "Gragas"
      expect(champion.key).to eq "Gragas"
      expect(champion.info).to eq "attack" => 4, "defense" => 7, "magic" => 6, "difficulty" => 5
    end
  end

  describe '#image' do
    it 'returns the image of the champion' do
      champion = described_class.new(id: 89,
                                     title: "the Radiant Dawn",
                                     name: "Leona",
                                     key: "Leona",
                                     info: { "attack" => 4, "defense" => 8, "magic" => 3, "difficulty" => 4 })

      expect(champion.image).to eq "http://ddragon.leagueoflegends.com/cdn/6.20.1/img/champion/Leona.png"
    end
  end

  describe '#recommended_items' do
    it 'returns the recommended items of the champion' do
      item = LeagueOfLegends::Item.new(id: 1054,
                                       name: "Doran's Shield",
                                       description: "+80 Health Passive: Restores 6 Health every 5 seconds. UNIQUE Passive: Blocks 8 damage from single target attacks and spells from champions.")

      champion = described_class.all.first

      expect(champion.recommended_items).to include item
    end
  end

  describe '#==' do
    let(:champion1) do
      described_class.new(id: 89,
                          title: "the Radiant Dawn",
                          name: "Leona",
                          key: "Leona",
                          info: { "attack" => 4, "defense" => 8, "magic" => 3, "difficulty" => 4 })
    end

    context 'when is TRUE' do
      it 'all the attributes of compared objects are equal' do
        champion2 = described_class.new(id: 89,
                                        title: "the Radiant Dawn",
                                        name: "Leona",
                                        key: "Leona",
                                        info: { "attack" => 4, "defense" => 8, "magic" => 3, "difficulty" => 4 })

        expect(champion1).to eq champion2
      end
    end

    context 'when is FALSE' do
      it 'any of the attributes of compared objects are different' do
        champion2 = described_class.new(id: 90,
                                        title: "the Radiant Dawn",
                                        name: "Leona",
                                        key: "Leona",
                                        info: { "attack" => 4, "defense" => 8, "magic" => 3, "difficulty" => 4 })

        expect(champion1).to_not eq champion2
      end
    end
  end
end
