module LeagueOfLegends
  class Item
    RESOURCE = "item"

    class << self
      def all(itemData: "all")
        response = Request.get(RESOURCE, { itemListData: itemData, dataById: true })
        data = response["data"]
        items = []

        data.values.each do |raw_item|
          items << self.new(id: raw_item["id"],
                            description: raw_item["sanitizedDescription"],
                            name: raw_item["name"])
        end

        items
      end

      def find(id)
        all.select { |item| item.id.to_i == id.to_i }.first
      end
    end

    attr_accessor :id, :description, :name

    def initialize(params = {})
      params.each do |key, value|
        send("#{key}=", value)
      end
    end

    def ==(object)
      return false unless object.kind_of?(Item)

      self.id == object.id
    end
  end
end
