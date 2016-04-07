class WelcomeController < ApplicationController

# This defines an 'action' called index for the 'WelcomeController'
  def index

# By default (convention) Rails will render: views/welcome/index.html.erb (when receiving a request that has an HTML format). You can also do render :index OR render "/some_other_folder/some_other_action".

# If you use another format by going to a url such as '/home.text', Rails will render a template according to that format so the case of '/home.text' it would be views/welcome/index.text.erb

  end

  def about

  end

end
