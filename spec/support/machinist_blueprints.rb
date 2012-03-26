
rndgen = Random.new

Sham.define do
  youtube_id { Faker::Lorem.words(2).join}

  email { Faker::Internet.email }
  name { Faker::Name::name }
  password { Faker::Lorem::words.join[0,15] }
  id {(rand * 900001243173116).to_i}
  small_id { (rand * 100000).to_i }
  token { Faker::Lorem::words(10).join }
  phone { Faker::PhoneNumber.phone_number }
  coefficient { rand }

  snippet_content { Faker::Lorem::paragraphs }

  unit_name { Faker::Lorem.words(3).join(' ') }
  unit_description { Faker::Lorem.sentence }
  image_url { "http://#{Faker::Internet.domain_name}/#{Faker::Lorem.words(1).first}/#{Faker::Lorem.words(1).first}.jpg"}
  md5 {Digest::MD5.hexdigest(Faker::Lorem::sentence)}
  city_name {Faker::Address.city}
  county_name {Faker::Lorem.words(2).join}
  zip_code {Faker::Address.zip_code.slice(0,5)}
  neighborhood_name {Faker::Address.city_prefix+Faker::Address::city_suffix}
  university_name { Faker::Address.city + " University" }
  state_name { Faker::Address.us_state_abbr }
end

User.blueprint do
  email { Sham.email }
  password {Sham.password }
end

Request.blueprint do
  user
  youtube_id { Sham.youtube_id }
end

Play.blueprint do
  youtube_id { Sham.youtube_id }
end
