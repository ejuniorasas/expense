json.extract! expense, :id, :name, :description, :value, :status, :date, :created_at, :updated_at
json.url expense_url(expense, format: :json)
