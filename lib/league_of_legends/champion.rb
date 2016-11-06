module LeagueOfLegends
  class Champion
    RESOURCE = "champion"

    class << self
      def all
        response = Request.get_by_resource(RESOURCE, { champData: "info,lore,recommended", dataById: true })
        champions = []

        if response
          data = response["data"]

          data.values.each do |raw_champion|
            champions << self.new(id: raw_champion["id"],
                                  title: raw_champion["title"],
                                  name: raw_champion["name"],
                                  key: raw_champion["key"],
                                  lore: raw_champion["lore"],
                                  info: raw_champion["info"],
                                  recommended: raw_champion["recommended"])
          end
        end

        champions
      end

      def search_by(query)
        all.select { |champion| champion.name.downcase =~ /#{query.downcase}/ }
      end

      def find(id)
        all.select { |champion| champion.id.to_i == id.to_i }.first
      end
    end

    attr_accessor :id, :info, :key, :lore, :name, :recommended, :title

    def initialize(params = {})
      self.info = params.delete(:info)

      params.each do |key, value|
        send("#{key}=", value)
      end
    end

    def image
      "http://ddragon.leagueoflegends.com/cdn/#{last_game_version}/img/champion/#{self.key}.png"
    end

    def recommended_items
      build_recommended_items(recommended)
    end

    def ==(object)
      return false unless object.kind_of?(Champion)

      self.id == object.id && self.key == object.key
    end

    private

    def last_game_version
      GameVersion.last
    end

    def build_recommended_items(recommended)
      recommended_items = []

      recommended.each do |raw_recommended|
        items = raw_recommended["blocks"].map { |h| h["items"] }.flatten
        item_ids = items.map { |h| h["id"] }.uniq

        item_ids.each do |item_id|
          recommended_items << Item.find(item_id)
        end
      end

      recommended_items
    end
  end
end
