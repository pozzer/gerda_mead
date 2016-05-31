module LoggingHelpers
  extend ActiveSupport::Concern

  module ClassMethods
    def post_received_success(account_id, system_id, message=nil, resource_id=nil, parameters=nil)
      create_log({status: "success", log_type: "post_received", account_id: account_id,
        system_id: system_id, resource_id: resource_id, message: message, parameters: parameters})
    end

    def post_received_warning(account_id, system_id, message=nil, resource_id=nil, parameters=nil)
      create_log({status: "warning", log_type: "post_received", account_id: account_id,
        system_id: system_id, resource_id: resource_id, message: message, parameters: parameters})
    end

    def post_received_error(account_id, system_id, message=nil, exception=nil, resource_id=nil, parameters=nil)
      create_log({status: "error", log_type: "post_received", account_id: account_id,
        system_id: system_id, resource_id: resource_id, message: message, parameters: parameters, exception: exception})
    end

    def put_received_success(account_id, system_id, message=nil, resource_id=nil, parameters=nil)
      create_log({status: "success", log_type: "put_received", account_id: account_id,
        system_id: system_id, resource_id: resource_id, message: message, parameters: parameters})
    end

    def put_received_warning(account_id, system_id, message=nil, resource_id=nil, parameters=nil)
      create_log({status: "warning", log_type: "put_received", account_id: account_id,
        system_id: system_id, resource_id: resource_id, message: message, parameters: parameters})
    end

    def put_received_error(account_id, system_id, message=nil, exception=nil, resource_id=nil, parameters=nil)
      create_log({status: "error", log_type: "put_received", account_id: account_id,
        system_id: system_id, resource_id: resource_id, message: message, parameters: parameters, exception: exception})
    end

    def received_warning(method, account_id, system_id, message=nil, resource_id=nil, parameters=nil)
      create_log({status: "warning", log_type: "#{method.downcase}_received", account_id: account_id,
        system_id: system_id, resource_id: resource_id, message: message, parameters: parameters})
    end

    def general_error(account_id, system_id, message, exception=nil, resource_id=nil, parameters=nil)
      create_log({status: "error", log_type: "general", account_id: account_id,
        system_id: system_id, resource_id: resource_id, message: message, parameters: parameters, exception: exception})
    end

    def post_sended_success(account_id, system_id, message, resource_id, parameters=nil)
      create_log({status: "success", log_type: "post_sended", account_id: account_id,
        system_id: system_id, resource_id: resource_id, message: message, parameters: parameters})
    end

    def put_sended_success(account_id, system_id, message, resource_id, parameters=nil)
      create_log({status: "success", log_type: "put_sended", account_id: account_id,
        system_id: system_id, resource_id: resource_id, message: message})
    end

    private
      def create_log(attributes)
        Log.create! attributes
      end
  end
end
