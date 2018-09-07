json.code response.status
json.success true
json.message 'user was successfully created.'
json.data do
	json.user do
		json.id @user.id		
		json.email @user.email
	end
end