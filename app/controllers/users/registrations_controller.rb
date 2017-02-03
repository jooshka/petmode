class Users::RegistrationsController < Devise::RegistrationsController

  protected
  
  def build_resource(hash=nil)
    super(hash)
    self.resource.build_avatar
  end

end
