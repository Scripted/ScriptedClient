require 'spec_helper'

describe ScriptedClient::Job do

  subject { described_class.new }
  it 'should be a Resource' do
    expect(subject).to be_a_kind_of(ScriptedClient::Resource)
  end

  describe '#html_contents' do
    let(:contents) { ["<p>shall i compare thee to a summer's day</p>"] }
    it 'calls get(:html_contents) and returns the contents' do
      expect(subject).to receive(:get).with(:html_contents).and_return({
        'id' => 'abc123', 'html_contents' => contents
      })
      expect(subject.html_contents).to eq(contents)
    end
  end

end
