class AuthenticateAccount
    prepend SimpleCommand
  
    def initialize(email, password)
      @email = email
      @password = password
    end
  
    def call
      JsonWebToken.encode(account_id: account.id) if account
    end
  
    private
  
    attr_accessor :email, :password
  
    def account
      account = Account.find_by_email(email)
      return account if account && account.authenticate(password)
  
      errors.add :account_authentication, 'invalid credentials'
      nil
    end
  end