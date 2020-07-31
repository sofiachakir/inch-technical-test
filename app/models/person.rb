class Person < ApplicationRecord
	require 'csv'

	attr_accessor :triggered_by_import

	has_many :person_backups

	validates :reference, presence: true 
	validates :email, presence: true
	validates :firstname, presence: true
	validates :lastname, presence: true
	validates :home_phone_number, presence: true
	validates :mobile_phone_number, presence: true
	validates :address, presence: true

	# Effacer les changements sur les field email, home_phone_number
	# mobile_phone_number et address si modification 
	# déclenchée par l'import
	# Et si la valeur a déjà été une valeur du champ
	before_update :restore_values, if: :triggered_by_import
	
	# Mettre à jour la table de sauvegarde s'il reste des modifications
	before_update :update_person_backup, 
		if: :person_values_changed?
	
	def self.import(file)
		# Créer un array pour la réponse et un compteur pour identifier les lignes problématiques
		response = []
		counter = 1
		if file.nil?
			response << "No file provided"
		else
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
				# Si on trouve la personne, passer triggered by import à true pour déclencher le callback
				person.triggered_by_import = true if person
				# Si la personne existe, la mettre à jour, sinon, la créer
				person ? person.update(person_params) : person = Person.create(person_params)
				# Repasser le triggered by import à false dans tous les cas pour permettre les mises à jour manuelles
				person.triggered_by_import = false
				# Si on rencontre des erreurs, les enregistrer dans l'array response
				response << "l#{counter} - #{person.errors.full_messages.join(',')}" if person.errors.any?
				# Incrémenter le compteur
				counter += 1
			end
		end
		response.empty? ? response.push('Import was successful') : response.unshift('Errors prevented import')
		return response
	end

	private

	def restore_values
		restore_email! unless self.person_backups.where(email: self.email).empty?
		restore_home_phone_number! unless self.person_backups.where(home_phone_number: self.home_phone_number).empty?
		restore_mobile_phone_number! unless self.person_backups.where(mobile_phone_number: self.mobile_phone_number).empty?
		restore_address! unless self.person_backups.where(address: self.address).empty?
	end

	def update_person_backup
		self.person_backups.create(email: self.email, home_phone_number: self.home_phone_number, mobile_phone_number: self.mobile_phone_number, address: self.address)
	end

	def person_values_changed?
		email_changed? || home_phone_number_changed? || mobile_phone_number_changed? || address_changed?
	end

	def self.person_params(row)
		res = row.to_h.slice('reference', 'email', 'firstname', 'lastname', 'home_phone_number', 'mobile_phone_number', 'address')
		if res.keys != ['reference', 'email', 'firstname', 'lastname', 'home_phone_number', 'mobile_phone_number', 'address']
			return {}
		else
			return res
		end
	end

end