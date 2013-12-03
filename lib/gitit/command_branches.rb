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
      raise "a branch with that name already exists" if existsLocally?(name)
      executeCommand("branch #{name}")
      return true if $?.exitstatus == 0
      return false
    end

    # -------------------------------------------------------------------------
    # -------------------------------------------------------------------------
    def pushLocalBranchToRemote(name, remote)
      raise "a branch with that name does not exists" unless existsLocally?(name)
      executeCommand("push #{remote} #{name}")
      return true if $?.exitstatus == 0
      return false
    end

    # -------------------------------------------------------------------------
    # -------------------------------------------------------------------------
    def updateFromRemote(branchName, remote)

    end
    
  end

end


