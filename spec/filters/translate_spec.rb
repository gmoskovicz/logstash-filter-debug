# encoding: utf-8
require "logstash/devutils/rspec/spec_helper"
require "logstash/filters/debug"

describe LogStash::Filters::Debug do

  let(:config) { Hash.new }
  subject { described_class.new(config) }

  before :each do
    allow(subject.logger).to receive(:warn)
  end

  describe "with configuration should" do

    let(:config) do
      {
        "logmessage"  => "some message",
        "loglevel" => "WARN"
      }
    end

    let(:event) { LogStash::Event.new("status" => 200) }

    it "return message and the right loglevel" do
      subject.register
      subject.filter(event)
      expect(subject.logger).to have_received(:warn).with("some message", hash_including(:event => hash_including("status" => 200)))
    end
  end

  describe "with defaults" do
    let(:event) { LogStash::Event.new("status" => 200) }

    it "return message and the right loglevel" do
      subject.register
      subject.filter(event)
      expect(subject.logger).to have_received(:warn).with("Message coming", hash_including(:event => hash_including("status" => 200)))
    end
  end

  describe "with custom message format" do

    let(:config) do    
    {
        "logmessage"  => "#{event.sprintf('%{status}')}"
    }
    end

    let(:event) { LogStash::Event.new("status" => 200) }

    it "return message field value" do
      subject.register
      subject.filter(event)
      expect(subject.logger).to have_received(:warn).with("200", anything)
    
    end
  end
end
