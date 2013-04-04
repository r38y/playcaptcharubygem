require 'net/http'
require 'playcaptcha'
module Rails
  module PlayCaptcha
    class Railtie < Rails::Railtie
      initializer "setup config" do
        begin
          ActionView::Base.send(:include, ::PlayCaptcha::ClientHelper)
          ActionController::Base.send(:include, ::PlayCaptcha::Verify)
        end
      end
    end
  end
end

