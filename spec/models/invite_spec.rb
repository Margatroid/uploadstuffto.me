require 'spec_helper'

describe Invite do
  #pending "add some examples to (or delete) #{__FILE__}"
  it 'should always have a key after creation' do
    new_invite = Invite.new
    expect(new_invite.key).to have(16).characters
  end
end
