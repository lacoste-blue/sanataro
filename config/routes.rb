Kakeibo3::Application.routes.draw do
  root :to => "login#login"

  match 'simple', :to => 'entries#new', :entry_type => 'simple', :as => 'simple_input'
  match 'login' => 'login#login', :as => :login, :via => :get
  match 'login' => 'login#do_login', :as => :login, :via => :post
  match 'logout' => 'login#do_logout', :as => :logout
  match 'reload_config' => 'main#reload_config', :as => :reload_config
  
  scope 'months/:year/:month' do
    resources :entries
    resources :profit_losses
    resources :balance_sheets
  end

  scope 'current' do
    resources :entries, :as => 'current_entries'
    resources :profit_losses, :as => 'current_profit_losses'
    resources :balance_sheets, :as => 'current_balance_sheets'
  end
  
  scope '/tags/:tag' do
    resources :entries, :as => 'tag_entries'
  end
  
  scope '/marks/:mark' do
    resources :entries, :as => 'mark_entries'
  end
  
  resources :entries do
    resource :confirmation_required
  end
  
  resource :account_status
  resource :confirmation_status
  resource :tag_status
  resources :entry_candidates
  namespace(:admin) do
    resources :users
  end
    
  namespace(:settings) do
    resources :accounts
    resources :credit_relations
    resource :user
  end

  namespace(:api) do
    resources :assets
    resources :budgets
    resources :yearly_budgets
    resources :yearly_assets
    scope ':year_month' do
      resources :entries
    end
  end
end

