require 'spec_helper'

describe Invite do
  it 'should always have a key of reasonable length after creation' do
    invite = Invite.new
    invite.key.should_not be_empty
    invite.key.should satisfy { |key| key.length > 16 }
  end

  it 'should require a description' do
    invite = Invite.create(:description => '').should_not be_valid
  end
end
