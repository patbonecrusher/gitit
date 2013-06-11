require "bundler/setup"
require "gitit/command_executor"

Bundler.require(:default)

module Gitit

  # ---------------------------------------------------------------------------
  # ---------------------------------------------------------------------------
  class Status
    include CommandExecutor
    
    # -------------------------------------------------------------------------
    # -------------------------------------------------------------------------
    def initialize(repo)
      @repo = repo
    end
    
    # -------------------------------------------------------------------------
    # -------------------------------------------------------------------------
    def clean?
      return !unstagedFiles? && !uncommitedFiles? && !untrackedFiles?
    end
    
    # -------------------------------------------------------------------------
    # -------------------------------------------------------------------------
    def unstagedFiles?
      executeCommand("diff-files --name-status --diff-filter=M --exit-code")
      return true if $?.exitstatus == 1
      return false
    end
    
    # -------------------------------------------------------------------------
    # -------------------------------------------------------------------------
    def uncommitedFiles?
      executeCommand("diff --cached --no-ext-diff --ignore-submodules --quiet --exit-code")
      return true if $?.exitstatus == 1
      return false
    end
    
    # -------------------------------------------------------------------------
    # -------------------------------------------------------------------------
    def untrackedFiles?
      gitRes = executeCommand("status --porcelain | grep ??")
      return true if $?.exitstatus == 0
      return false
    end
    
  end


end

