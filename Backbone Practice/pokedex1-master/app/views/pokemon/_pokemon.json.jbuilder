json.id pokemon.id
json.attack pokemon.attack
json.defense pokemon.defense
json.image_url pokemon.image_url
json.moves pokemon.moves
json.name pokemon.name
json.poke_type pokemon.poke_type

if display_toys
  json.toys do
    json.array! pokemon.toys do |toy|
      json.partial! 'toys/toy', toy: toy
    end
  end
end
