class Role < ApplicationRecord
  has_many :clients
  has_many :roles_actions
  has_many :actions, through: :roles_actions

  validates :definition, presence: true, 
            uniqueness: true

  AGENT_0     = 1
  AGENT       = 2
  INDIVIDUAL  = 3
  SUPPLIER    = 4

  scope :get_agent_0,   -> { where(id: AGENT_0).first }
  scope :get_agent,     -> { where(id: AGENT).first }
  scope :get_individual,-> { where(id: INDIVIDUAL).first }
  scope :get_supplier,  -> { where(id: SUPPLIER).first }

  DO_EMISSION     = 0b0000001
  BUY             = 0b0000010
  SELL            = 0b0000100
  ACCEPT_TRANSFER = 0b0001000
  DO_TRANSFER     = 0b0010000
  ACCEPT_PAYMENT  = 0b0100000
  DO_PAYMENT      = 0b1000000



  ROLE_PERMISSIONS = {
      AGENT_0     => 0b0000101,  # [DO_EMISSION, SELL]
      AGENT       => 0b0010101,  # [DO_EMISSION, SELL, DO_TRANSFER]
      INDIVIDUAL  => 0b1011110,  # [BUY, SELL, ACCEPT_TRANSFER, DO_TRANSFER, DO_PAYMENT]
      SUPPLIER    => 0b0100100,  # [SELL, ACCEPT_PAYMENT]
  }

  def can_do_emission?
    (self.permission & DO_EMISSION) == DO_EMISSION
  end

  def can_buy?
    (self.permission & BUY) == BUY
  end

  def can_sell?
    (self.permission & SELL) == SELL
  end

  def can_accept_transfer?
    (self.permission & ACCEPT_TRANSFER) == ACCEPT_TRANSFER
  end

  def can_do_transfer?
    (self.permission & DO_TRANSFER) == DO_TRANSFER
  end

  def can_accept_payment?
    (self.permission & ACCEPT_PAYMENT) == ACCEPT_PAYMENT
  end

  def can_do_payment?
    (self.permission & DO_PAYMENT) == DO_PAYMENT
  end

end
