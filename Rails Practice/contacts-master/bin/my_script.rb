require 'addressable/uri'
require 'rest-client'

def users
  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: '/users.json'
  ).to_s

  puts RestClient.get(url)

end

def create_user(name, email)
  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: '/users.json'
  ).to_s

  puts RestClient.post(
    url,
    { user: { name: name, email: email}}
  )
end

def show_user(user_id)
  url = Addressable::URI.new(
  scheme: 'http',
  host: 'localhost',
  port: 3000,
  path: "/users/#{user_id}.json"
  ).to_s

  puts RestClient.get(url)
end

def update_user(user_id, name, email)
  url = Addressable::URI.new(
  scheme: 'http',
  host: 'localhost',
  port: 3000,
  path: "/users/#{user_id}.json"
  ).to_s

  puts RestClient.put(url,
  { user: { name: name, email: email}}
  )
end

def destroy(user_id)
  url = Addressable::URI.new(
  scheme: 'http',
  host: 'localhost',
  port: 3000,
  path: "/users/#{user_id}.json"
  ).to_s

  puts RestClient.delete(url)
end

destroy(1)
# update_user(2, "Second Modern Lieutenant Strang", "stringmeister@yahoo.fr")
