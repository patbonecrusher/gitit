require "gitit/command_executor"

module Gitit

  # ---------------------------------------------------------------------------
  # ---------------------------------------------------------------------------
  class Branches
    include CommandExecutor
    
    # -------------------------------------------------------------------------
    # -------------------------------------------------------------------------
    def initialize(repo)
      @repo = repo
    end

    # -------------------------------------------------------------------------
    # -------------------------------------------------------------------------
    def existsLocally?(name)
      branches = executeCommand("branch --no-color | sed 's/^[* ] //'")
      executeCommand("branch --no-color | sed 's/^[* ] //' | grep #{name}")
      return true if $?.exitstatus == 0
      return false
    end
    
    # -------------------------------------------------------------------------
    # -------------------------------------------------------------------------
    def existsRemotely?(name)
      branches = executeCommand("branch -r --no-color | sed 's/^[* ] //'")
      executeCommand("branch --no-color | sed 's/^[* ] //' | grep #{name}")
      return true if $?.exitstatus == 0
      return false
    end

    # -------------------------------------------------------------------------
    # -------------------------------------------------------------------------
    def updateFromRemote(branchName, remote)

    end
    
  end

end


