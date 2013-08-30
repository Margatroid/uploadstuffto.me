require 'spec_helper'

describe Invite do
  #pending "add some examples to (or delete) #{__FILE__}"
  it 'should always have a key of resonable length after creation' do
    new_invite = Invite.new
    should ensure_length_of(new_invite.key).is_at_least(16)
      .with_message('key is too short')
  end
end
