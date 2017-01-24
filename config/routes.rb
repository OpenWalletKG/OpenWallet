Rails.application.routes.draw do

  root 'main#homepage' # needs to be changed to main#show
  # devise_for :clients
  
  # SHOULD BE DELETED BLOCK
  # get 'main/multistep'


  # #ЛК физ.лица
  # get '/individual_cabinet' => 'individuals#individual_cabinet', as: 'individual_cabinet'
  # get '/individual_payment' => 'individuals#payment', as: 'individual_payment'
  # get '/money_transfer' => 'individuals#money_transfer', as: 'money_transfer'

  # #ЛК юр.лица
  # get '/corporate_cabinet' => 'corporates#corporate_cabinet', as: 'corporate_cabinet'

  # END OF SHOULD BE DELETED BLOCK

  devise_for :clients, path: '', skip: [:sessions, :registrations, :passwords]
  as :client do
  #   #SignIn/SignOut[Sessions]
    get     'login', to: 'devise/sessions#new',      as: 'new_client_session'
    post    'login',  to: 'devise/sessions#create',   as: 'client_session'
    delete  'logout', to: 'devise/sessions#destroy',  as: 'destroy_client_session'

    #Registration
    get     'sign_up'   => 'devise/registrations#new',    as: 'new_client_registration'
    get     'sign_up/cancel' => 'devise/registrations#cancel', as: 'cancel_client_registration'
    get     'sign_up/edit'   => 'devise/registrations#edit', as: 'edit_client_registration'
    post    'sign_up'   => 'devise/registrations#create', as: 'client_registration'
    patch   'sign_up'   => 'devise/registrations#update'
    put     'sign_up'   => 'devise/registrations#update'
    delete  'sign_up'   => 'devise/registrations#destroy'

    #Password
    get   'reset'                => 'devise/passwords#new',      as: 'new_client_password'
    get   'reset/new_password'   => 'devise/passwords#edit',     as: 'edit_client_password'
    post  'reset'                => 'devise/passwords#create',   as: 'client_password'
    patch 'reset'                => 'devise/passwords#update'
    put   'reset'                => 'devise/passwords#update'

  end

  get '/wallet' => 'wallet#show', as: 'show_wallet'

  scope '/wallet' do
    get    '/buy/new'      => 'buy#new',         as: 'new_buy'
    post   '/buy'          => 'buy#create',      as: 'buy'
    get    '/sell/new'     => 'sell#new',        as: 'new_sell'
    post   '/sell'         => 'sell#create',     as: 'sell'
    get    '/withdraw/new' => 'withdraw#new',    as: 'new_withdraw'
    post   '/withdraw'     => 'withdraw#create', as: 'withdraw'
    get    '/transfer/new' => 'transfer#new',    as: 'new_transfer'
    post   '/transfer'     => 'transfer#create', as: 'transfer'
    get    '/payment/new'  => 'paymentr#new',    as: 'new_payment'
    post   '/payment'      => 'payment#create',  as: 'payment'
    get    '/history'      => 'history#show',    as: 'history'
  end

end
