require 'rails_helper'

RSpec.describe "people/index.html.erb", type: :view do

  context 'when there are people' do  
    it 'displays the details' do
      # déclare la variable people, qui est un array contenant des personnes
      assign(:people,
        [
          build(:person, reference: "1", firstname: "Sofia"),
          build(:person, reference: "2", email: "sofia@yopmail.com"),
          build(:person, reference: "3")
        ]
      )

      render

      # vérifie que le firstname d'une des personnes soit affiché
      expect(rendered).to match /Sofia/

      # vérifie que l'email d'une des personnes soit affiché
      expect(rendered).to match /sofia@yopmail.com/
    end
  end

end