require 'rails_helper'

RSpec.describe "buildings/index.html.erb", type: :view do

  context 'when there are buildings' do  
    it 'displays the details' do
      # déclare la variable buildings, qui est un array contenant des buildings
      assign(:buildings,
        [
          build(:building, reference: "1", address: "237 Rue du Faubourg Saint-Martin"),
          build(:building, reference: "2", zip_code: "75010"),
          build(:building, reference: "3")
        ]
      )

      render

      # vérifie que l'address d'un des buildings soit affiché
      expect(rendered).to match /237 Rue du Faubourg Saint-Martin/

      # vérifie que le zipcode d'un des buildings soit affiché
      expect(rendered).to match /75010/
    end
  end

end