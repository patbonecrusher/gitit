require "bundler/setup"
require "gitit"

Bundler.require(:default)

module Gitit

  # ---------------------------------------------------------------------------
  # ---------------------------------------------------------------------------
  class ConfigElement
    attr_reader :info;
    attr_accessor :value;
    attr_reader :hideinput; 
    
    def initialize (info, hideinput, default)
      @info = info;
      @hideinput = hideinput;
      @value = default;
    end
  end

end
