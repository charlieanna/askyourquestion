require 'pubnub'
class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_pubnub
  
  def set_pubnub
    ## Instantiate a new PubNub instance.
    @pubnub = Pubnub.new(
        :publish_key   => 'pub-75a3aad0-d9c8-4763-8838-9aae1226ed0c', # publish_key only required if publishing.
        :subscribe_key => 'sub-fdd15440-8939-11e1-aa2b-41374c390533', # required
        :secret_key    => "sec-NThiMGVkZTAtNjZjYS00NTMyLWE0ZDYtNjJjYmU2YTBkNzJj",    # optional, if used, message signing is enabled
        :cipher_key    => nil,    # optional, if used, encryption is enabled
        :ssl           => nil     # true or default is false
    )
  end
  
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user
end