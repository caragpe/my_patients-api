# frozen_string_literal: true

class BaseRepository
  KLASS_ERROR_MESSAGE = 'Raised from BaseRepository. Should be overridden.'.freeze

  class << self
    def find_all
      klass.all
    end

    def find_by_id(object_id)
      klass.where(id: object_id).first
    end

    def create(params)
      object = klass.new(params)
      object.save

      object
    end

    def update(object, params)
      object.update(params)

      object
    end

    def destroy(object)
      object.destroy
    end

    private

    def klass
      raise KLASS_ERROR_MESSAGE
    end
  end
end
