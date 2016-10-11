# encoding: utf-8
require "logstash/filters/base"
require "logstash/namespace"

# A general tool which stops the pipeline and prints the current event
# for debugging purposes only

class LogStash::Filters::Debug < LogStash::Filters::Base
  config_name "debug"

  # Custom message to print before printing the event.
  config :message, :validate => :string, :required => false, :default => "Message coming"

  # Log level to use to log: "WARN", "DEBUG" or "INFO"
  config :loglevel, :validate => :string, :required => false, :default => "WARN"

  def register()
  end

  def filter(event)
    if loglevel == "WARN" 
      @logger.warn("#{message}", :event => event.to_hash)
    elsif loglevel == "DEBUG" 
      @logger.debug("#{message}", :event => event.to_hash)
    elsif loglevel == "INFO"
      @logger.info("#{message}", :event => event.to_hash)
    else
      @logger.warn("#{message}", :event => event.to_hash)
    end
    
  end

end