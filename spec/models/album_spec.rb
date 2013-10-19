require 'spec_helper'

describe Album do
  it { should validate_presence_of :user_id }

  it 'must be deleted if the user is deleted' do
    pending 'test that album is gone if user is deleted'
  end
end
