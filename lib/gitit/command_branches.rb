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
      executeCommand("branch --no-color | sed 's/^[* ] //' | grep #{name}")
      return true if $?.exitstatus == 0
      return false
    end
    
    # -------------------------------------------------------------------------
    # -------------------------------------------------------------------------
    def existsRemotely?(name, remote)
      executeCommand("branch -r --no-color | sed 's/^[* ] //' | grep #{remote}/#{name}")
      return true if $?.exitstatus == 0
      return false
    end

    # -------------------------------------------------------------------------
    # -------------------------------------------------------------------------
    def createLocalBranch(name)
      executeCommand("branch --quiet #{name}")
      return true if $?.exitstatus == 0
      return false
    end

    # -------------------------------------------------------------------------
    # -------------------------------------------------------------------------
    def pushLocalBranchToRemote(name, remote, force)
      executeCommand("push --quiet -f #{remote} #{name}") if force
      executeCommand("push --quiet #{remote} #{name}") unless force
      return true if $?.exitstatus == 0
      return false
    end

    # -------------------------------------------------------------------------
    # -------------------------------------------------------------------------
    def updateFromRemote(branchName, remote)

    end
    
  end

end


