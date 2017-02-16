class Role < ApplicationRecord
  has_many :clients
  has_many :roles_actions
  has_many :actions, through: :roles_actions

  validates :definition, presence: true, 
            uniqueness: true

  validates :permission, presence: true

  ROLES = {
      :AGENT_0     => "Агент 0",
      :AGENT       => "Агент",
      :INDIVIDUAL  => "Физ.лицо",
      :SUPPLIER    => "Поставщик"
  }

  scope :get_agent_0,   -> { where(definition: ROLES[:AGENT_0]).first }
  scope :get_agent,     -> { where(definition: ROLES[:AGENT]).first }
  scope :get_individual,-> { where(definition: ROLES[:INDIVIDUAL]).first }
  scope :get_supplier,  -> { where(definition: ROLES[:SUPPLIER]).first }


  PERMISSIONS = {
      :DO_EMISSION     => 0b0000001,
      :BUY             => 0b0000010,
      :SELL            => 0b0000100,
      :ACCEPT_TRANSFER => 0b0001000,
      :DO_TRANSFER     => 0b0010000,
      :ACCEPT_PAYMENT  => 0b0100000,
      :DO_PAYMENT      => 0b1000000
  }


  def init_permissions(*permissions)
    @permission = 0
    permissions.each do |permission|
      @permission |= PERMISSIONS[permission]
    end
    @permission
  end

  def list_permissions
    result = Array.new
    PERMISSIONS.each_with_index do |(permission_key, permission_value)|
      result << permission_key if (self.permission & permission_value) == permission_value
    end
    result
  end

  def register_role_as( role )
    self.definition = ROLES[role]
    self.permission = @permission
    self.save!
  end

  def can_do_emission?
    (self.permission & PERMISSIONS[:DO_EMISSION]) == PERMISSIONS[:DO_EMISSION]
  end

  def can_buy?
    (self.permission & PERMISSIONS[:BUY]) == PERMISSIONS[:BUY]
  end

  def can_sell?
    (self.permission & PERMISSIONS[:SELL]) == PERMISSIONS[:SELL]
  end

  def can_accept_transfer?
    (self.permission & PERMISSIONS[:ACCEPT_TRANSFER]) == PERMISSIONS[:ACCEPT_TRANSFER]
  end

  def can_do_transfer?
    (self.permission & PERMISSIONS[:DO_TRANSFER]) == PERMISSIONS[:DO_TRANSFER]
  end

  def can_accept_payment?
    (self.permission & PERMISSIONS[:ACCEPT_PAYMENT]) == PERMISSIONS[:ACCEPT_PAYMENT]
  end

  def can_do_payment?
    (self.permission & PERMISSIONS[:DO_PAYMENT]) == PERMISSIONS[:DO_PAYMENT]
  end

end
