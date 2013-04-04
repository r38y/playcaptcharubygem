require "uri"
module PlayCaptcha
  module Verify
    # Your private API can be specified in the +options+ hash or preferably
    # using the Configuration.
    def verify_playcaptcha(options = {})
      if !options.is_a? Hash
        options = {:model => options}
      end

      env = options[:env] || ENV['RAILS_ENV']
      return true if PlayCaptcha.configuration.skip_verify_env.include? env
      model = options[:model]
      attribute = options[:attribute] || :base
      private_key = options[:private_key] || PlayCaptcha.configuration.private_key
      raise RecaptchaError, "No private key specified." unless private_key

      begin
        recaptcha = nil
        playcaptcha = (params[:recaptcha_challenge_field].downcase == "playcaptcha")
        if(PlayCaptcha.configuration.proxy)
          proxy_server = URI.parse(PlayCaptcha.configuration.proxy)
          http = Net::HTTP::Proxy(proxy_server.host, proxy_server.port, proxy_server.user, proxy_server.password)
        else
          http = Net::HTTP
        end

        if playcaptcha
          playcaptchaValidationUrl = PlayCaptcha.configuration.playcaptcha_verify_url + params[:recaptcha_response_field]
          puts playcaptchaValidationUrl
          Timeout::timeout(options[:timeout] || 3) do
            recaptcha = http.post_form(URI.parse(playcaptchaValidationUrl), {})
          end
        else
          Timeout::timeout(options[:timeout] || 3) do
            recaptcha = http.post_form(URI.parse(PlayCaptcha.configuration.verify_url), {
              "privatekey" => private_key,
              "remoteip"   => request.remote_ip,
              "challenge"  => params[:recaptcha_challenge_field],
              "response"   => params[:recaptcha_response_field]
            })
          end
        end
        answer, error = recaptcha.body.split.map { |s| s.chomp }
        unless answer == 'true'
          flash[:recaptcha_error] = if defined?(I18n)
            I18n.translate("recaptcha.errors.#{error}", {:default => error})
          else
            error
          end

          if model
            if playcaptcha
              message = "PlayCaptcha verification response is incorrect, please try again."
            else
              message = "Word verification response is incorrect, please try again."
            end
            message = I18n.translate('recaptcha.errors.verification_failed', {:default => message}) if defined?(I18n)
            model.errors.add attribute, options[:message] || message
          end
          return false
        else
          flash.delete(:recaptcha_error)
          return true
        end
      rescue Timeout::Error
        if PlayCaptcha.configuration.handle_timeouts_gracefully
          flash[:recaptcha_error] = if defined?(I18n)
            I18n.translate('recaptcha.errors.recaptcha_unreachable', {:default => 'Validation service unreachable.'})
          else
            'Validation service unreachable.'
          end

          if model
            
            if playcaptcha
              message = "Oops, we failed to validate your PlayCaptcha verification response. Please try again."
            else
              message = "Oops, we failed to validate your word verification response. Please try again."
            end
            message = I18n.translate('recaptcha.errors.recaptcha_unreachable', :default => message) if defined?(I18n)
            model.errors.add attribute, options[:message] || message
          end
          return false
        else
          raise RecaptchaError, "Recaptcha unreachable."
        end
      rescue Exception => e
        raise RecaptchaError, e.message, e.backtrace
      end
    end # verify_recaptcha
  end # Verify
end # Recaptcha
