Rails.application.routes.draw do
  get 'students' => 'students#index',as: :students
  get 'students/edit' => 'students#edit',as: :student_edit
  post 'students/edit' =>'students#create'
  patch 'students/edit' => 'students#update_personal'
  get 'students/payment' => 'students#payment',as: :payment
  post 'create-checkout-session' => 'students#create_checkout_session'
  get 'setup'=>'students#setup',as: :setup
  get 'success'=>'students#success',as: :success
  get 'cancel'=>'students#cancel',as: :cancel

  get 'logout' => 'students#logout'

  root 'home#index'
  get 'faq'=>'home#faq',as: :faq
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
