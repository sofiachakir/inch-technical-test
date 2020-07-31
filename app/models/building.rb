class Building < ApplicationRecord
	require 'csv'

	attr_accessor :triggered_by_import

	has_many :building_backups

	validates :reference, presence: true 
	validates :address, presence: true
	validates :zip_code, presence: true
	validates :city, presence: true
	validates :country, presence: true
	validates :manager_name, presence: true

	# Effacer les changements sur le field manager_name si modification 
	# déclenchée par l'import
	# Et si la valeur a déjà été une valeur du champ
	before_update :restore_manager_name!, 
		unless: :manager_name_was_never_previous_value?, 
		if: :triggered_by_import
	
	# Si le nom reste modifié suite au premier callback
	# Mettre à jour la table de sauvegarde
	before_update :update_building_backup, 
		if: :manager_name_changed?

	def self.import(file)
		# Créer un array pour la réponse et un compteur pour identifier les lignes problématiques
		response = []
		counter = 1
		if file.nil?
			response << "No file provided"
		else
			CSV.foreach(file.path, headers: true) do |row|
				# Sélectionner les paramètres pour create / update
				building_params = building_params(row)
				# Si erreur, on quitte la boucle et on informe qu'il y a une erreur
				if building_params.empty?
					response << "CSV Format Error"
					break
				end
				# Vérifier l'existence du building via sa référence
				building = Building.find_by(reference: building_params['reference'])
				# Si on trouve le building, passer triggered by import à true pour déclencher le callback
				building.triggered_by_import = true if building
				# Si le building existe, le mettre à jour, sinon, le créer
				building ? building.update(building_params) : building = Building.create(building_params)
				# Repasser le triggered by import à false dans tous les cas pour permettre les mises à jour manuelles
				building.triggered_by_import = false
				# Si on rencontre des erreurs, les enregistrer dans l'array response
				response << "l#{counter} - #{building.errors.full_messages.join(',')}" if building.errors.any?
				# Incrémenter le compteur
				counter += 1
			end
		end
		response.empty? ? response.push('Import was successful') : response.unshift('Errors prevented import')
		return response
	end

	private

	def update_building_backup
		self.building_backups.create(manager_name: self.manager_name)
	end

	def manager_name_was_never_previous_value?
		self.building_backups.where(manager_name: self.manager_name).empty?
	end

	def self.building_params(row)
		res = row.to_h.slice('reference', 'address', 'zip_code', 'city', 'country', 'manager_name')
		if res.keys != ['reference', 'address', 'zip_code', 'city', 'country', 'manager_name']
			return {}
		else
			return res
		end
	end

end