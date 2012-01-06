require 'spec_helper'

describe RedmineWiki do

  let(:url) { 'http://example.com/redmine/wiki/' }
  let(:wiki) { RedmineWiki.new(url) }

  before do
  end

  subject { wiki }

  it { should be }

  describe "#get" do
    before do
      wiki.stub(:login_unless_logined)
      # mocks
      WebMock.stub_request(:get, "http://example.com/redmine/wiki/Wiki/edit").
        to_return(:status => 200, :body => fixture("wiki"), :headers => {})
    end

    it "returns raw wiki text" do
      pending # FIXME
      wiki.get("Wiki").should == "h1. Wiki\n"
    end

  end

  describe "#update" do
    it "posts wiki text"
  end

end


