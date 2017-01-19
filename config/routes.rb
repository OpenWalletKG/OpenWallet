Rails.application.routes.draw do

  root 'main#homepage'
  get 'main/multistep'

  #ЛК физ.лица
  get '/individual_cabinet' => 'individuals#individual_cabinet', as: 'individual_cabinet'


  #ЛК юр.лица
  get '/corporate_cabinet' => 'corporates#corporate_cabinet', as: 'corporate_cabinet'

end
