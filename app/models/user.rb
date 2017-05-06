class User < ApplicationRecord
validates_email_format_of :email, :message => 'is not looking good'
validates :username, format: { with: /\A\w{1,40}\z/}
before_validation { self.name = self.name.downcase }
validates_uniqueness_of :name
end
