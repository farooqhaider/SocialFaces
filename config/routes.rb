FbDssd::Application.routes.draw do
  #resources :uploads

  devise_for :users, :controllers => {:registrations => "registrations"} do
    match "users/sign_in" => "/users/registrations/#new"
  end

  resources :albums do
    collection do
      post "edit_album"
      get "tag_photo"
      post "add_description"
      get "upload2"
      post "upload_photos"
    end
  end

  resources :videos do
    collection do
      get "display"
    end
  end

  resources :photos do
    collection do
      get "view_others_photos"
      post "tag_people"
      get "gettaggedusers"
      post "upload_photo"
    end
  end

  #resources :users
  
  match 'show_profile' => 'users#show_profile', :as => :user_root
  match ':controller(/:action(/:id))'
  #root :to => "Home#homepage"
  root :to => redirect("/users/registration/sign_up")

end
