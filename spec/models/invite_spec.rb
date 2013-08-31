require 'spec_helper'

min_key_length = 16

describe Invite do
  before  { @invite = Invite.new(:description => 'Test invite') }
  subject { @invite }

  it 'should always have a key of reasonable length after creation' do
    subject.key.should_not be_empty
    subject.key.should satisfy { |key| key.length > min_key_length }
  end

  it 'should require a description' do
    invite = Invite.create(:description => '').should_not be_valid
  end

  it "should consider keys shorter than #{ min_key_length } to be invalid" do
    subject.key = 'hello'
    expect { subject.save! }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it 'can only be used once by default' do
    subject.reuse_times.should eq(0)
  end

  it 'must not save invites with the same key' do
    first  = Invite.new(:description => 'Test')
    second = Invite.new(:description => 'Same key as first',
                        :key         => first.key)
    first.save!
    expect { second.save! }.to raise_error(ActiveRecord::RecordInvalid)
  end
end
