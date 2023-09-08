class SearchFacade
  attr_reader :selected_nation, :total_members, :all_characters

  def initialize(nation)
    @selected_nation = nation
    @all_characters = []
    fetch_members
  end

  def first_25_characters
    @all_characters.first(25)
  end

  private

  def fetch_members
    conn = Faraday.new(url: 'https://last-airbender-api.fly.dev')
    page = 1
    loop do
      response = conn.get("/api/v1/characters?affiliation=#{URI.encode_www_form_component(@selected_nation)}&page=#{page}")

      raise ApiError, "API returned an error: #{response.status} #{response.body}" unless response.status == 200

      characters = JSON.parse(response.body)
      break if characters.empty?

      @all_characters += characters

      page += 1
    end

    @total_members = @all_characters.size
  end
end
