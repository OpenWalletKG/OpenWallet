module ApplicationHelper

  # Helper methods for Devise. Those methods are needed to create our own views and use them in modal windows.
  def resource_name
    :client
  end

  def resource
   @resource ||= Client.new
  end

  def devise_mapping
   @devise_mapping ||= Devise.mappings[:client]
  end
# End of devise helpers.

end
