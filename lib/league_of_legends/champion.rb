module LeagueOfLegends
  class Champion
    RESOURCE = "champion"
    API_VERSION = "v1.2"

    attr_accessor :id, :info, :key, :lore, :name, :title

    def initialize(params = {})
      self.info = params.delete(:info)

      params.each do |key, value|
        send("#{key}=", value)
      end
    end

    def image
      "http://ddragon.leagueoflegends.com/cdn/#{last_game_version}/img/champion/#{self.key}.png"
    end

    def ==(object)
      return false unless object.kind_of?(Champion)

      self.id == object.id && self.key == object.key
    end

    class << self
      def all(champData = "all")
        response = Request.get(RESOURCE, API_VERSION, { champData: champData, dataById: true })
        data = response["data"]
        champions = []

        data.values.each do |raw_champion|
          champions << self.new(id: raw_champion["id"],
                                title: raw_champion["title"],
                                name: raw_champion["name"],
                                key: raw_champion["key"],
                                lore: raw_champion["lore"],
                                info: raw_champion["info"])
        end

        champions
      end

      def search_by(query)
        all.select { |champion| champion.name.downcase =~ /#{query.downcase}/ }
      end
    end

    private

    def last_game_version
      GameVersion.last
    end
  end
end
