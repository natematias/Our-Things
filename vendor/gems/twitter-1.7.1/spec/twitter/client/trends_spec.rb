require 'helper'

describe Twitter::Client do
  %w(json xml).each do |format|
    context ".new(:format => '#{format}')" do
      before do
        @client = Twitter::Client.new(:format => format)
      end

      describe ".trends" do

        before do
          stub_get("1/trends.json").
            to_return(:body => fixture("trends.json"), :headers => {:content_type => "application/json; charset=utf-8"})
        end

        it "should get the correct resource" do
          @client.trends
          a_get("1/trends.json").
            should have_been_made
        end

        it "should return the top ten topics that are currently trending on Twitter" do
          trends = @client.trends
          trends.first.name.should == "Isaacs"
        end

      end

      describe ".trends_current" do

        before do
          stub_get("1/trends/current.json").
            to_return(:body => fixture("trends_current.json"), :headers => {:content_type => "application/json; charset=utf-8"})
        end

        it "should get the correct resource" do
          @client.trends_current
          a_get("1/trends/current.json").
            should have_been_made
        end

        it "should return the current top 10 trending topics on Twitter" do
          trends = @client.trends_current
          trends["2010-10-25 16:00:00"].first.name.should == "Isaacs"
        end

      end

      describe ".trends_daily" do

        before do
          stub_get("1/trends/daily.json").
            with(:query => {:date => "2010-10-24"}).
            to_return(:body => fixture("trends_daily.json"), :headers => {:content_type => "application/json; charset=utf-8"})
        end

        it "should get the correct resource" do
          @client.trends_daily(Date.parse("2010-10-24"))
          a_get("1/trends/daily.json").
            with(:query => {:date => "2010-10-24"}).
            should have_been_made
        end

        it "should return the top 20 trending topics for each hour in a given day" do
          trends = @client.trends_daily(Date.parse("2010-10-24"))
          trends["2010-10-24 17:00"].first.name.should == "#bigbangcomeback"
        end

      end

      describe ".trends_weekly" do

        before do
          stub_get("1/trends/weekly.json").
            with(:query => {:date => "2010-10-24"}).
            to_return(:body => fixture("trends_weekly.json"), :headers => {:content_type => "application/json; charset=utf-8"})
        end

        it "should get the correct resource" do
          @client.trends_weekly(Date.parse("2010-10-24"))
          a_get("1/trends/weekly.json").
            with(:query => {:date => "2010-10-24"}).
            should have_been_made
        end

        it "should return the top 30 trending topics for each day in a given week" do
          trends = @client.trends_weekly(Date.parse("2010-10-24"))
          trends["2010-10-23"].first.name.should == "#unfollowmeif"
        end
      end
    end
  end
end
