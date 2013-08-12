require "bundler/setup"
require "gitit"
require "gitit/repo"

Dir[File.dirname(__FILE__) + "/command_*.rb"].each do |file|
  require file
end

Bundler.require(:default)

module Gitit
  
  # ---------------------------------------------------------------------------
  # ---------------------------------------------------------------------------
  class Git
    attr_reader :repo;
    attr_reader :config;
    attr_reader :status;
    attr_reader :branches;

    # -------------------------------------------------------------------------
    # -------------------------------------------------------------------------
    def initialize(location)
      @repo = Repo.new(location)
      @config = Config.new(repo)
      @status = Status.new(repo)
      @branches = Branches.new(repo)
    end
  end

end

  
