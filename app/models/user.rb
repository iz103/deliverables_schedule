class User < ActiveRecord::Base
  acts_as_authentic do |c|
    c.logged_in_timeout = 10.minutes
  end
  
  
  named_scope :with_role, lambda { |role| {:conditions => "roles_mask & #{2**ROLES.index(role.to_s)} > 0"} }
  
  ROLES = %w[admin manager]
  

  def roles=(roles)
    self.roles_mask = (roles & ROLES).map { |r| 2**ROLES.index(r) }.sum
  end
  
  def roles
    ROLES.reject { |r| ((roles_mask || 0) & 2**ROLES.index(r)).zero? }
  end
  
  def role?(role)
    roles.include? role.to_s
  end   

  
end

# to add a role to a user
# role = []
# role << User::ROLES[1]
# user.roles = role
# user.save

# # progress = []
# # progress << Delivery::PROGRESSES[0]
# delivery.progresses = progress
# delivery.save

