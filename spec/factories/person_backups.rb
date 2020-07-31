FactoryBot.define do
  factory :person_backup do
    person { FactoryBot.create(:person)}
  end
end
