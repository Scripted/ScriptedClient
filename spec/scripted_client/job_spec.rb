require 'spec_helper'

describe ScriptedClient::Job do

  subject { described_class.new }
  it 'should be a Resource' do
    expect(subject).to be_a_kind_of(ScriptedClient::Resource)
  end

end
