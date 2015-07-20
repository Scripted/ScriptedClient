require 'spec_helper'

describe ScriptedClient::Collection do

  let(:args) do
    { 'paging' => { 'has_next' => true, 'next_cursor' => 'where-my-jobs-at' },
      'data' => [ { 'id' => 'bob-the-builder', 'name' => 'Bob' } ] }
  end
  subject { described_class.new(args) }

  context 'if there is a next page' do
    describe '#next_page' do
      it 'equals the cursor' do
        expect(subject.next_page).to eq('where-my-jobs-at')
      end
    end
    describe '#has_next?' do
      it 'is true' do
        expect(subject.has_next?).to eq(true)
      end
    end
    describe '#next' do
      before do
        subject.original_params = { hello: 'world' }
        subject.resource_class = ScriptedClient::Job
      end
      it 'merges the next_cursor into the params on the resource_class' do
        expect(ScriptedClient::Job).to receive(:all).with(
          params: { hello: 'world', next_cursor: 'where-my-jobs-at' }
        )
        subject.next
      end
    end
  end
  context 'if there is a next page' do
    before { args['paging']['has_next'] = false }
    describe '#next_page' do
      it 'is nil' do
        expect(subject.next_page).to eq(nil)
      end
    end
    describe '#has_next?' do
      it 'is false' do
        expect(subject.has_next?).to eq(false)
      end
    end
    describe '#next' do
      it 'raises an exception' do
        expect { subject.next }.to raise_error 'No more pages'
      end
    end
  end
end
