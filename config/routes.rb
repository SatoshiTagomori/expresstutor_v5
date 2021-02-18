Rails.application.routes.draw do
  root 'home#index'
  get 'faq'=>'home#faq',as: :faq
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
