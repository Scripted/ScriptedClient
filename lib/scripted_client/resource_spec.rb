require 'spec_helper'

describe ScriptedClient::Resource do

  subject { described_class }

  describe '.collection_parser' do
    it 'is ScriptedClient::Collection' do
      expect(subject.collection_parser).to eq(ScriptedClient::Collection)
    end
  end

  describe '.define_filter_methods' do
    before { subject.define_filter_methods('some_filter') }
    it 'defines a filter method' do
      expect(subject).to receive(:all).with(params: { filter: 'some_filter' })
      subject.some_filter
    end
  end

end
