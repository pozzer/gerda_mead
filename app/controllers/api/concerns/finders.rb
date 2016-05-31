module Finders
  extend ActiveSupport::Concern

  def find_resource_class
    @resouce_class = ResourceClass.find_by(name: receive_params[:resource_class_name])

    if @resouce_class.nil?
      error_message = "Resource Class not found"

      Log.received_warning(request.env["REQUEST_METHOD"], @current_system.account.id, @current_system.id, error_message, nil, receive_params)

      return unprocessable_entity(error_message)
    end
  end

  def find_resource_type
    @resource_type = ResourceType.find_by(account_id: @current_system.account.id, resource_class_id: @resouce_class.id)

    if @resource_type.nil?
      error_message = "Resource Type not found"
      Log.received_warning(request.env["REQUEST_METHOD"], @current_system.account.id, @current_system.id, error_message, nil, receive_params)

      return unprocessable_entity(error_message)
    end
  end

  def need_not_find_resource_object
    resource_object = find_resource_object

    unless resource_object.nil?
      error_message = "Object already exists"
      Log.post_received_warning(@current_system.account.id, @current_system.id, error_message, nil, receive_params)

      return unprocessable_entity(error_message)
    end
  end

  def need_find_resource_object
    @resource_object = find_resource_object

    if @resource_object.nil?
      error_message = "Object not exists"
      Log.put_received_warning(@current_system.account.id, @current_system.id, error_message, nil, receive_params)

      return unprocessable_entity(error_message)
    end
  end

  private
    def find_resource_object
      ResourceObject.find_by(object_ref: receive_params[:object_ref_id],
        system_id: @current_system.id,
        resource_id: @resource_type.resources.map(&:id))
    end

    def find_other_systems
      @current_account.systems.all_but_this(@current_system.id)
    end
end
