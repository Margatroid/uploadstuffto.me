require 'spec_helper'

describe Image do
  it 'will have a key' do
    invite = Invite.create()
    invite.key should exist
  end
end
