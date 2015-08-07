require 'gitit/git_executor'

module Gitit

  # ---------------------------------------------------------------------------
  # ---------------------------------------------------------------------------
  class GitStatus
    include GitExecutor
    
    # -------------------------------------------------------------------------
    # -------------------------------------------------------------------------
    def initialize(repo)
      @repo = repo
    end
    
    # -------------------------------------------------------------------------
    # -------------------------------------------------------------------------
    def clean?
      !unstaged_files? && !uncommited_files? && !untracked_files?
    end
    
    # -------------------------------------------------------------------------
    # -------------------------------------------------------------------------
    def unstaged_files?
      execute_command('diff-files --name-status --diff-filter=M --exit-code')
      $?.exitstatus == 1
    end
    
    # -------------------------------------------------------------------------
    # -------------------------------------------------------------------------
    def uncommited_files?
      execute_command('diff --cached --no-ext-diff --ignore-submodules --quiet --exit-code')
      $?.exitstatus == 1
    end
    
    # -------------------------------------------------------------------------
    # -------------------------------------------------------------------------
    def untracked_files?
      # execute_command('status --porcelain | grep ??')
      # $?.exitstatus == 0

      result = execute_command('status --porcelain')
      match = result.each_line.select { |b| b.start_with? '?? ' }
      match.length > 0
    end
    
  end

end


