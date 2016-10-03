require 'spec_helper'

describe LeagueOfLegends::Champion do
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
