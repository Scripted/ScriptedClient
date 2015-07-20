require 'spec_helper'

describe ScriptedClient::Pitch do

  subject { described_class }

  describe 'an instance' do
    subject { described_class.new }
    it 'should be a Resource' do
      expect(subject).to be_a_kind_of(ScriptedClient::Resource)
    end
  end

end
