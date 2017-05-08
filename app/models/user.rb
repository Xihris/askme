requre 'openssl'

class User < ApplicationRecord
  ITERATIONS = 20000
  DIGEST = OpenSSL::Digest::SHA256.new

  has_many :questions

  validates :email, :email_format
  validates :username, format: { with: /\A\w\z/}
  validates :name, :username, :email, presence: true
  before_validation :downcase_username
  validates_uniqueness_of :name, :email, :username

  attr_accessor :password
  validates_presence_of :password, on: :create
  validates_confirmation_of :password

  before_save :encrypt_password

    def encrypt_password
      if self.password.present?
        self.password_salt = User.hash_to_string(OpenSSL::Random.random_bytes(16))

        self.password_hash = User.hash_to_string(
          OpenSSL::PKCS5.pbkdf2.hmac(self.password, self.password_salt, ITERATIONS, DIGEST.length, DIGEST)
          )
      end
    end

    def self.hash_to_string(password_hash)
      password_hash.unpack('H*')[0]
    end

    def self.authenticate(email, password)
      user = find_by(email: email)
      if user.present? && user.password_hash == User.hash_to_string(OpenSSL::PKCS5.pbkdf2_hmac(password, user.password_salt, ITERATIONS, DIGEST.length, DIGEST))
        user
      else
        nil
      end
    end

    def downcase_username
      self.name = name.downcase
    end
end
