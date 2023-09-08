require 'net/http'
require 'json'

class FireNationCharacterFetcher
  def self.fetch_all
    all_characters = []
    page_number = 1
    characters_per_page = 20

    loop do
      url = "https://last-airbender-api.fly.dev/api/v1/characters?affiliation=Fire+Nation&perPage=#{characters_per_page}&page=#{page_number}"
      uri = URI(url)
      response = Net::HTTP.get(uri)
      characters = JSON.parse(response)

      break if characters.empty? || characters.size < characters_per_page

      all_characters.concat(characters)
      page_number += 1
    end

    all_characters
  end
end
