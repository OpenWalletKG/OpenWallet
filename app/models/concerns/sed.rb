class Sed < Account

  def self.register( client_obj )
    wallet_number = Base58.encode( client_obj.entity.in.to_i )
    create(number: wallet_number, client_id: client_obj.id )
  end

end