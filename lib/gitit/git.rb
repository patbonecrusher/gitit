require "bundler/setup"
require "gitit"
require "gitit/repo"
require "gitit/command_config"

Bundler.require(:default)

module Gitit
  
  # ---------------------------------------------------------------------------
  # ---------------------------------------------------------------------------
  class Git
    attr_reader :repo;
    attr_reader :config;

    # -------------------------------------------------------------------------
    # -------------------------------------------------------------------------
    def initialize(location)
      @repo = Repo.new(location)
      @config = Config.new(repo)
    end
  end

end

  
