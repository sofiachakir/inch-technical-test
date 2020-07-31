FactoryBot.define do
  factory :building_backup do
    building { FactoryBot.create(:building)}
  end
end
