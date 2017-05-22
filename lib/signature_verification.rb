require "signature_verification/version"

module SignatureVerification
  class << self
    REQUIRED_KEYS = %w(access_key kind time)
    TIMEOUT_MINUTES = 2

    def generate_signature(params)
      params = params.merge(secret_key: secret_key)
      Digest::SHA1.hexdigest(convert_params(params).flatten.join)
    end

    def authenticate(params)
      return false, 'invalid_parameter', 400 unless params[:signature]
      required_params = params.stringify_keys.slice(*REQUIRED_KEYS)
      return false, 'invalid_parameter', 400 if required_params.size != REQUIRED_KEYS.size
      return false, 'expired_signature', 400 if expired_signature?(params[:time])
      return false, 'invalid_server', 401 unless secret_key

      signature = Digest::SHA1.hexdigest(convert_params(params.merge(secret_key: secret_key)).flatten.join)
      if signature == params[:signature]
        true
      else
        return false, 'invalid_signature', 400
      end
    end

    def secret_key
      data = YAML.load_file("#{Rails.root}/config/sun_gem.yml")
      data["secret_key"]
    end

    private

    def expired_signature?(time)
      time.to_i < TIMEOUT_MINUTES.minutes.ago.to_i
    end

    def convert_params(params)
      params.sort.to_h.values.flatten.map { |e| e.is_a?(Hash) ? convert_params(e) : e }
    end

  end
end
