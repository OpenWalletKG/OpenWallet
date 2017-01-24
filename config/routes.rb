Rails.application.routes.draw do

  devise_for :clients
 
  root 'main#homepage'
  get 'main/multistep'

  #ЛК физ.лица
  get '/individual_cabinet' => 'individuals#individual_cabinet', as: 'individual_cabinet'
  get '/individual_payment' => 'individuals#payment', as: 'individual_payment'
  get '/money_transfer' => 'individuals#money_transfer', as: 'money_transfer'

  #ЛК юр.лица
  get '/corporate_cabinet' => 'corporates#corporate_cabinet', as: 'corporate_cabinet'
end
