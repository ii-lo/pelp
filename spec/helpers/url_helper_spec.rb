require 'rails_helper'

RSpec.describe UrlHelper, :type => :helper do
  describe '.pretty_rul' do
    context 'http' do
      it 'removes scheme from url' do
        expect(helper.pretty_url("http://google.com")).to eq "google.com"
        expect(helper.pretty_url("http://github.com/rbates")).to eq "github.com/rbates"
        expect(helper.pretty_url("http://marek:marek@google.com")).to eq "marek:marek@google.com"
      end
    end
    context 'https' do
      it 'removes scheme from url' do
        expect(helper.pretty_url("https://google.com")).to eq "google.com"
        expect(helper.pretty_url("https://github.com/rbates")).to eq "github.com/rbates"
        expect(helper.pretty_url("https://marek:marek@google.com")).to eq "marek:marek@google.com"
      end
    end
  end
end
