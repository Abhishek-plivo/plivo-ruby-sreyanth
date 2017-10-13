module Plivo
  # Utils module
  module Utils
    module_function

    def valid_account?(account_id, raise_directly = false)
      valid_subaccount?(account_id, raise_directly) || valid_mainaccount?(account_id, raise_directly)
    end

    # @param [String] account_id
    # @param [Boolean] raise_directly
    def valid_subaccount?(account_id, raise_directly = false)
      unless account_id.is_a? String
        return false unless raise_directly
        raise_invalid_request('subaccount_id must be a string')
      end

      if account_id.length != 20
        return false unless raise_directly
        raise_invalid_request('subaccount_id should be of length 20')
      end

      if account_id[0..1] != 'SA'
        return false unless raise_directly
        raise_invalid_request("subaccount_id should start with 'SA'")
      end
      true
    end

    def valid_mainaccount?(account_id, raise_directly = false)
      unless account_id.is_a? String
        return false unless raise_directly
        raise_invalid_request('account_id must be a string')
      end

      if account_id.length != 20
        return false unless raise_directly
        raise_invalid_request('account_id should be of length 20')
      end

      if account_id[0..1] != 'MA'
        return false unless raise_directly
        raise_invalid_request("account_id should start with 'SA'")
      end
      true
    end

    def raise_invalid_request(message = '')
      raise Exceptions::InvalidRequestError, message
    end

    def valid_param?(param_name, param_value, expected_types = nil, mandatory = false, expected_values = nil)
      if mandatory && param_value.nil?
        raise_invalid_request("#{param_name} is a required parameter")
      end

      return true if param_value.nil?

      return expected_type?(param_name, expected_types, param_value) unless expected_values
      expected_value?(param_name, expected_values, param_value)
    end

    def expected_type?(param_name, expected_types, param_value)
      return true if expected_types.nil?
      if expected_types.is_a? Array
        return true if expected_types.include? param_value.class
        raise_invalid_request("#{param_name}: Expected one of #{expected_types}"\
          " but received #{param_value.class} instead")
      else
        return true if expected_types == param_value.class
        raise_invalid_request("#{param_name}: Expected a #{expected_types}"\
          " but received #{param_value.class} instead")
      end
    end

    def expected_value?(param_name, expected_values, param_value)
      return true if expected_values.nil?
      if expected_values.is_a? Array
        return true if expected_values.include? param_value
        raise_invalid_request("#{param_name}: Expected one of #{expected_values}"\
          " but received '#{param_value}' instead")
      else
        return true if expected_values == param_value
        raise_invalid_request("#{param_name}: Expected '#{expected_values}'"\
          " but received '#{param_value}' instead")
      end
    end
  end
end
