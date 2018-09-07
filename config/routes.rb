Rails.application.routes.draw do
  namespace :api, dafaults:{format: :json} do 
  	namespace :v1 do 
  		resources :users
  		resources :sessions, only:[:create, :destroy]
  	end
  end
end
