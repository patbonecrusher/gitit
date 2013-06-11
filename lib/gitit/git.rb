require "bundler/setup"
require "gitit"
require "gitit/repo"
require "gitit/command_config"
require "gitit/command_status"

Bundler.require(:default)

module Gitit
  
  # ---------------------------------------------------------------------------
  # ---------------------------------------------------------------------------
  class Git
    attr_reader :repo;
    attr_reader :config;
    attr_reader :status;

    # -------------------------------------------------------------------------
    # -------------------------------------------------------------------------
    def initialize(location)
      @repo = Repo.new(location)
      @config = Config.new(repo)
      @status = Status.new(repo)
    end
  end

end

  
