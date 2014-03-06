require 'gitit/command_executor'

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
      execute_command('diff --cached --no-ext-diff --ignore-submodules --quiet --exit-code')
      $?.exitstatus == 1
    end
    
  end

end

