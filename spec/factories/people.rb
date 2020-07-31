FactoryBot.define do
  factory :person do
  	reference { "1" }
    firstname { "Henri" }
    lastname { "Dupont" }
    home_phone_number { "0123456789" }
    mobile_phone_number { "0623456789" }
    email { "h.dupont@gmail.com" } 
    address { "10 Rue La bruyère" }  
  end
end