Rails.application.routes.draw do

  root 'main#homepage'
  get '/individual_cabinet' => 'individuals#individual_cabinet', as: 'individual_cabinet'
end
