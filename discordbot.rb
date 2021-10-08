require 'discordrb'
require 'dotenv'
Dotenv.load
require 'uri'
require 'net/http'

bot = Discordrb::Commands::CommandBot.new token: ENV['TOKEN'], client_id: ENV['CLIENT'], prefix: '!'

bot.command(:gif) do |event|
    tokens = event.message.content.split(" ")
    keywords = "coding train"
    if tokens.length > 1
        keywords = (tokens.slice(1, tokens.length)).join(" ")
    end

    gifhy = URI.parse("https://api.giphy.com/v1/gifs/search?api_key=#{ENV['GIFHY_API_KEY']}&q=#{keywords}&limit=8&offset=0&rating=g&lang=tr")
    responses = Net::HTTP.get_response gifhy
    datas = responses.body
    jsonn = JSON.parse(datas)
    event.respond (jsonn["data"][rand(0..7)]["url"]).to_s
    tenor = URI.parse("https://g.tenor.com/v1/search?q=#{keywords}&key=#{ENV['TENOR_API_KEY']}&limit=8&contentfilter=high")
    response = Net::HTTP.get_response tenor
    data = response.body
    json = JSON.parse(data)
    event.respond (json["results"][rand(0..7)]["url"]).to_s
end

bot.run