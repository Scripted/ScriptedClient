require 'spec_helper'

describe ScriptedClient do

  subject { described_class }

  describe '.access_token' do
    context 'when nil' do
      it 'raises an exception' do
        expect {
          subject.access_token
        }.to raise_error 'You must set ScriptedClient.access_token'
      end
    end
    context 'when set' do
      before { subject.access_token = 'cats' }
      it 'returns the token' do
        expect(subject.access_token).to eq('cats')
      end
    end
  end

  describe '.access_token' do
    context 'when nil' do
      it 'raises an exception' do
        expect {
          subject.organization_key
        }.to raise_error 'You must set ScriptedClient.organization_key'
      end
    end
    context 'when set' do
      before { subject.organization_key = 'dogs' }
      it 'returns the token' do
        expect(subject.organization_key).to eq('dogs')
      end
    end
  end

  describe '.env' do
    context 'when not set' do
      it 'defaults to sandbox' do
        expect(subject.env).to eq(:sandbox)
      end
    end
    context 'when setting something invalorganization_key' do
      it 'raises an exception' do
        expect {
          subject.env = :bangladesh
        }.to raise_error 'ScriptedClient.env must be either :sandbox or :production'
      end
    end
    context 'when set' do
      before { subject.env = :production }
      it 'returns the token' do
        expect(subject.env).to eq(:production)
      end
    end
  end

  describe 'resetting the resource site and prefix' do
    context 'when organization_key and access_token have been set' do
      before do
        subject.organization_key = 'dogs'
        subject.access_token = 'cats'
        subject.env = :production
      end
      it 'sets the site, prefix and headers on ScriptedClient::Resource' do
        expect(ScriptedClient::Resource.site).to eq(URI.parse('https://api.scripted.com'))
        expect(ScriptedClient::Resource.prefix).to eq('/dogs/v1/')
        expect(ScriptedClient::Resource.headers['Authorization']).to eq('Bearer cats')
      end
    end
  end
end
