json.code response.status
json.success true
json.data do
	json.users do 
		json.array! @users#, :id, :name
	end
end