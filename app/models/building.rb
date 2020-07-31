class Building < ApplicationRecord
	require 'csv'

	has_many :building_backups

	validates :reference, presence: true 
	validates :address, presence: true
	validates :zip_code, presence: true
	validates :city, presence: true
	validates :country, presence: true
	validates :manager_name, presence: true

	def self.import(file)
		# Créer un array pour la réponse et un compteur pour identifier les lignes problématiques
		response = []
		counter = 1
		CSV.foreach(file.path, headers: true) do |row|
			# Convertir la ligne en hash
			row_hash = row.to_h
			# Vérifier l'existence de la référence
			building = Building.find_by(reference: row_hash['reference'])
			# Si le building existe, le mettre à jour, sinon, le créer
			building ? building.update(row_hash) : building = Building.create(row_hash)
			response << "l#{counter} - #{building.errors.full_messages.join(',')}" if building.errors.any?
			counter += 1
		end
		response.empty? ? response.push('Import was successful') : response.unshift('Errors prevented import')
		return response
	end

end