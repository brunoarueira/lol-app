require 'spec_helper'

describe LeagueOfLegends::Item do
  describe '.find' do
    it 'returns the item by id' do
      item1 = described_class.new(id: 1054,
                                  name: "Doran's Shield",
                                  description: "+80 Health Passive: Restores 6 Health every 5 seconds. UNIQUE Passive: Blocks 8 damage from single target attacks and spells from champions.")

      item2 = described_class.find(1054)

      expect(item1).to eq item2
    end
  end

  describe '#initialize' do
    it 'sets the attributes passed as arguments' do
      attributes = { id: 79, name: "Gragas", description: "+80 Health" }

      item = described_class.new(attributes)

      expect(item.id).to eq 79
      expect(item.name).to eq "Gragas"
      expect(item.description).to eq "+80 Health"
    end
  end

  describe '#==' do
    let(:item1) do
      described_class.new(id: 1054,
                          name: "Doran's Shield",
                          description: "+80 Health Passive: Restores 6 Health every 5 seconds. UNIQUE Passive: Blocks 8 damage from single target attacks and spells from champions.")
    end

    context 'when is TRUE' do
      it 'the id of compared objects are equal' do
        item2 = described_class.new(id: 1054,
                                    name: "Doran's Shield",
                                    description: "+80 Health Passive: Restores 6 Health every 5 seconds. UNIQUE Passive: Blocks 8 damage from single target attacks and spells from champions.")

        expect(item1).to eq item2
      end
    end

    context 'when is FALSE' do
      it 'the id of compared objects are different' do
        item2 = described_class.new(id: 1055,
                                    name: "Doran's Shield",
                                    description: "+80 Health Passive: Restores 6 Health every 5 seconds. UNIQUE Passive: Blocks 8 damage from single target attacks and spells from champions.")

        expect(item1).to_not eq item2
      end
    end
  end
end
