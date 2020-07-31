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
			# Sélectionner les paramètres pour create / update
			person_params = person_params(row)
			# Si erreur, on quitte la boucle et on informe qu'il y a une erreur
			if person_params.empty?
				response << "CSV Format Error"
				break
			end
			# Vérifier l'existence de la personne via sa référence
			person = Person.find_by(reference: person_params['reference'])
			# Si la personne existe, la mettre à jour, sinon, la créer
			person ? person.update(person_params) : person = Person.create(person_params)
			# Si on rencontre des erreurs, les enregistrer dans l'array response
			response << "l#{counter} - #{person.errors.full_messages.join(',')}" if person.errors.any?
			# Incrémenter le compteur
			counter += 1
		end
		response.empty? ? response.push('Import was successful') : response.unshift('Errors prevented import')
		return response
	end

	private

	def self.person_params(row)
		res = row.to_h.slice('reference', 'email', 'firstname', 'lastname', 'home_phone_number', 'mobile_phone_number', 'address')
		if res.keys != ['reference', 'email', 'firstname', 'lastname', 'home_phone_number', 'mobile_phone_number', 'address']
			return {}
		else
			return res
		end
	end

end