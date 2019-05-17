json.extract! movement_proof, :id, :person_id, :deposit_id, :movement_type_id, :date, :comment, :created_at, :updated_at
json.url movement_proof_url(movement_proof, format: :json)
