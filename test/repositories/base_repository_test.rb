# frozen_string_literal: true

require 'test_helper'

class BaseRepositoryTest < ActiveSupport::TestCase
  test 'klass raises an exception if called from within base repository' do
    exception = assert_raises(RuntimeError) do
      BaseRepository.create({})
    end
    assert_equal BaseRepository::KLASS_ERROR_MESSAGE, exception.message
  end
end
