class User

  attr_reader :errors
  attr_accessor :first_name, :last_name, :errors

  def initialize(first_name, last_name)
    @first_name = first_name
    @last_name  = last_name
    @errors     = []
  end

  def save
    puts "saving in some db..."
  end

  def add_errors(message)
    @errors.push message 
  end
end


class UserCreator < LightServices::Service

  attributes :first_name, :last_name
  validates  :first_name, :last_name, presence: true
  execute    :create_user, if: :input_valid?, fallback: :add_error
  
  returns User do |user|
    @user = user.new @first_name, @last_name
  end

  def create_user
    @user.save
    # ... other complexity logic
  end

  def add_error
    @user.add_errors( "Opss, something it's wrong" )
  end

end

user = UserCreator.new(first_name: 'Aragorn II', last_name: 'son of Arathorn').call