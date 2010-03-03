require 'test/unit'
require File.expand_path(File.dirname(__FILE__) + "/../rc")

class RCTest < Test::Unit::TestCase

  def test_check_auth_failure_on_token
    assert_raise(NameError) do
      check_auth 'sdflkjsdflkj'
    end
  end

  def test_check_auth_pass
    check_auth 'aclae4w4esar423qafds'
  end

end