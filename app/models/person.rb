class Person < ApplicationRecord
	require 'csv'

	has_many :person_backups

	validates :reference, presence: true 
	validates :email, presence: true
	validates :firstname, presence: true
	validates :lastname, presence: true
	validates :home_phone_number, presence: true
	validates :mobile_phone_number, presence: true
	validates :address, presence: true
	
	def self.import(file)
		# Créer un array pour la réponse et un compteur pour identifier les lignes problématiques
		response = []
		counter = 1
		CSV.foreach(file.path, headers: true) do |row|
			# Convertir la ligne en hash
			row_hash = row.to_h
			# Vérifier l'existence de la référence
			person = Person.find_by(reference: row_hash['reference'])
			# Si la personne existe, la mettre à jour, sinon, la créer
			person ? person.update(row_hash) : person = Person.create(row_hash)
			response << "l#{counter} - #{person.errors.full_messages.join(',')}" if person.errors.any?
			counter += 1
		end
		response.empty? ? response.push('Import was successful') : response.unshift('Errors prevented import')
		return response
	end

end