# frozen_string_literal: true

class BaseInteractor
  include Interactor

  def validate_params(required_params)
    missing_params = required_params.reject { |param| context[param] }

    context.fail!(message: "Following params are missing #{missing_params.join(', ')}") if
      missing_params.present?
  end
end
