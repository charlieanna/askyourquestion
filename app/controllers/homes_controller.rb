require 'pubnub'
class HomesController < ApplicationController
  def show
    
    ## Instantiate a new PubNub instance.
    pubnub = Pubnub.new(
        :publish_key   => 'pub-75a3aad0-d9c8-4763-8838-9aae1226ed0c', # publish_key only required if publishing.
        :subscribe_key => 'sub-fdd15440-8939-11e1-aa2b-41374c390533', # required
        :secret_key    => "sec-NThiMGVkZTAtNjZjYS00NTMyLWE0ZDYtNjJjYmU2YTBkNzJj",    # optional, if used, message signing is enabled
        :cipher_key    => nil,    # optional, if used, encryption is enabled
        :ssl           => nil     # true or default is false
    )

    
    ## Create a callback for checking response of Publish
    @my_callback = lambda { |message| puts(message) }

    ## Execute Publish
    pubnub.publish(
        :channel  => :a,
        :message  => {text:"Hi"},
        :callback => @my_callback
    )
    @question = Question.new
    @questions = Question.all
    unless session[:user_id]
      @user = User.new_guest
      if @user.save
        session[:user_id] = @user.id
      end
    end
  end
end
