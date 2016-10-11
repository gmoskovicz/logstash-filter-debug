# encoding: utf-8
require "logstash/filters/base"
require "logstash/namespace"

# A general tool which stops the pipeline and prints the current event
# for debugging purposes only

class LogStash::Filters::Debug < LogStash::Filters::Base
  config_name "debug"

  # Custom message to print before printing the event.
  # Examples:
  # 1. To get a field from the event #{event.sprintf('%{status}')} 
  # 2. Any string to be added in the message
  # 3. Defaults to Message Coming 
  config :logmessage, :validate => :string, :required => false, :default => "Message coming"

  # Log level to use to log: "WARN", "DEBUG" or "INFO". Default is WARN
  config :loglevel, :validate => :string, :required => false, :default => "WARN"

  def register()
  end

  def filter(event)
    if loglevel == "DEBUG" 
      @logger.debug(logmessage, :event => event.to_hash)
    elsif loglevel == "INFO"
      @logger.info(logmessage, :event => event.to_hash)
    else
      @logger.warn(logmessage, :event => event.to_hash)
    end
    
  end

end