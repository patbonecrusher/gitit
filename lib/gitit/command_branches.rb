require 'gitit/command_executor'

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
    def get_current_branch
      branches = execute_command('branch --no-color')
      branch_match = branches.each_line.select { |b| b.start_with? '* ' }
      branch_match[0].strip.gsub(/\* /, '')
    end

    # -------------------------------------------------------------------------
    # -------------------------------------------------------------------------
    def exists_locally?(name)
      execute_command("branch --no-color | sed 's/^[* ] //' | grep #{name}")
      $?.exitstatus == 0
    end
    
    # -------------------------------------------------------------------------
    # -------------------------------------------------------------------------
    def exists_remotely?(name, remote)
      execute_command("branch -r --no-color | sed 's/^[* ] //' | grep #{remote}/#{name}")
      $?.exitstatus == 0
    end

    # -------------------------------------------------------------------------
    # -------------------------------------------------------------------------
    def create_local_branch(name)
      execute_command("branch --quiet #{name}")
      $?.exitstatus == 0
    end

    # -------------------------------------------------------------------------
    # -------------------------------------------------------------------------
    def push_local_branch_to_remote(name, remote, force)
      execute_command("push --quiet -f #{remote} #{name}") if force
      execute_command("push --quiet #{remote} #{name}") unless force
      $?.exitstatus == 0
    end

    # -------------------------------------------------------------------------
    # -------------------------------------------------------------------------
    #def update_from_remote(branch_name, remote)

    #end
    
  end

end


