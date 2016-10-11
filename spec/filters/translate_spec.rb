# encoding: utf-8
require "logstash/devutils/rspec/spec_helper"
require "logstash/filters/translate"

describe LogStash::Filters::Translate do

  let(:config) { Hash.new }
  subject { described_class.new(config) }

  describe "exact translation" do

    let(:config) do
      {
        "message"  => "some message",
        "loglevel" => "INFO"
      }
    end

    let(:event) { LogStash::Event.new("status" => 200) }

    it "return the exact translation" do
    end
  end
end
