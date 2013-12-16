require 'spec_helper'

describe Admin do
   it {should respond_to(:event) }
   it {should respond_to(:email)}
   it {should respond_to(:password)}
   it {should respond_to(:password_confirmation)}
  
end