require 'spec_helper'

describe LeagueOfLegends::Cache do
  subject { described_class.new(url: 'redis://localhost:6379', api_version: '6.22.1') }

  describe '#exists?' do
    context 'is TRUE' do
      it 'when the data exists on the cache' do
        subject.set "champion", { name: 'Jax' }

        expect(subject.exists?("champion")).to be_truthy
      end
    end

    context 'is FALSE' do
      it 'when the data not exists on the cache' do
        Redis::Connection::Memory.reset_all_databases
        Redis::Connection::Memory.reset_all_channels

        expect(subject.exists?("champion")).to be_falsy
      end
    end
  end

  describe '#get' do
    it 'returns the cached data if it exists' do
      subject.set "champion", { name: 'Jax' }

      expect(subject.get("champion")).to eq "{\"name\":\"Jax\"}"
    end
  end

  describe '#set' do
    it 'persist the data to be cached' do
      expect(subject.set("champion", { name: 'Jax' })).to be_truthy
    end
  end
end
