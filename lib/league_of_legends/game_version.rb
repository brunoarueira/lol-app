module LeagueOfLegends
  class GameVersion
    RESOURCE = "versions"

    attr_accessor :number

    def initialize(params = {})
      self.number = params[:number]
    end

    def ==(object)
      return false unless object.kind_of?(GameVersion)

      self.number == object.number
    end

    def to_s
      self.number
    end

    class << self
      def all
        response = Request.get(RESOURCE)
        game_versions = []

        response.each do |raw_game_version|
          game_versions << self.new(number: raw_game_version)
        end

        game_versions
      end

      def last
        @game_version ||= all.first
      end
    end
  end
end
