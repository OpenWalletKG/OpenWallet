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
    delete  'logout', to: 'devise_sessions#destroy',  as: 'destroy_client_session'

    #Registration
    get     'sign_up'   => 'devise_registrations#new',    as: 'new_user_registration'
    get     'sign_up/cancel' => 'devise_registrations#cancel', as: 'cancel_user_registration'
    get     'sign_up/edit'   => 'devise_registrations#edit', as: 'edit_user_registration'
    post    'sign_up'   => 'devise_registrations#create', as: 'user_registration'
    patch   'sign_up'   => 'devise_registrations#update'
    put     'sign_up'   => 'devise_registrations#update'
    delete  'sign_up'   => 'devise_registrations#destroy'

    #Password
    get   'reset'                => 'devise_passwords#new',      as: 'new_user_password'
    get   'reset/new_password'   => 'devise_passwords#edit',     as: 'edit_user_password'
    post  'reset'                => 'devise_passwords#create',   as: 'user_password'
    patch 'reset'                => 'devise_passwords#update'
    put   'reset'                => 'devise_passwords#update'
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
