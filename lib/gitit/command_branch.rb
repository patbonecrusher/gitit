require "bundler/setup"
require "gitit/command_executor"

Bundler.require(:default)

module Gitit

  # ---------------------------------------------------------------------------
  # ---------------------------------------------------------------------------
  class Branch
    include CommandExecutor

    attr_reader :name;
    
    # -------------------------------------------------------------------------
    # -------------------------------------------------------------------------
    def initialize(repo, name)
      @repo = repo
      @name = name
    end

    # -------------------------------------------------------------------------
    # -------------------------------------------------------------------------
    def valid?
      executeCommand("diff --cached --no-ext-diff --ignore-submodules --quiet --exit-code")
      return true if $?.exitstatus == 1
      return false
    end
    
  end

end

