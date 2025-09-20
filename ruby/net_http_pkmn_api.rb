require 'net/http'
require 'uri'
require 'json'
require 'pp'

uri = URI('https://pokeapi.co/api/v2/pokemon/charmander')

## Moves By Generation Practice

GEN_LIST = {
    1 => ["red-blue", "yellow"],
    2 => ["gold-silver", "crystal"],
    3 => ["ruby-sapphire", "emerald", "firered-leafgreen"],
    4 => ["diamond-pearl", "platinum", "heartgold-soulsilver"],
    5 => ["black-white", "black-2-white-2"],
    6 => ["x-y", "omega-ruby-alpha-sapphire"],
    7 => ["sun-moon", "ultra-sun-ultra-moon"],
    8 => ["lets-go-pikachu-lets-go-eevee", "sword-shield", "brilliant-diamond-and-shining-pearl"],
    9 => ["scarlet-violet"]
  }

SUPPORTED_VERSIONS = GEN_LIST.values.flatten

def moves_sorted_by_generation(uri)
  pkm_data = JSON.parse(Net::HTTP.get(uri), symbolize_names: true)
  moves = {}

  # File.open('out.json', 'w') do |f|
  #   f.write(JSON.pretty_generate(pkm_data))
  # end

  pkm_data[:moves].each do |move|
    catch :unsupported_gen do
      name = move[:move][:name]
      move[:version_group_details].each do |version|
        throw :unsupported_gen unless SUPPORTED_VERSIONS.include?(version[:version_group][:name])
        version_name = version[:version_group][:name]
        moves[version_name] ||= {}
        moves[version_name][name] = { learn_from: version[:move_learn_method][:name], level: version[:level_learned_at] }
      end
    end
  end

  pp moves
    .sort_by { |gen, _| SUPPORTED_VERSIONS.index(gen) }
    .to_h
    .transform_values { |move_hash| move_hash.sort_by { |name, stat| [stat[:learn_from], stat[:level]] }.to_h }
end

moves_sorted_by_generation(uri)

## Spirte By Generation Practice

def sprite_by_generation(uri)
  pkm_data = JSON.parse(Net::HTTP.get(uri), symbolize_names: true)
  sprites = {
    # front: { "gen-i": { "red": url, "blue": url } }
  }

  # front: { "gen-i": { "red": url, "blue": url } }
  # if url is null then remove gen or game name entry completely

  # generations = pkm_data[:sprites][:versions].keys
  # sprite_types = 

  pkm_data[:sprites][:versions].each do |gen_name, game|
    game.each do |game_name, sprites_data|
      sprites_data.each do |sprite_type, url|
        sprites[sprite_type] ||= {}
        sprites[sprite_type][gen_name] ||= {}
        sprites[sprite_type][gen_name][game_name] = url
      end
    end
  end

  pp sprites
end

# sprite_by_generation(uri)

def moves_data_table

end


