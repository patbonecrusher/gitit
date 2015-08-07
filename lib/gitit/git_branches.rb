require 'gitit/git_executor'

module Gitit

  # ---------------------------------------------------------------------------
  # ---------------------------------------------------------------------------
  class GitBranches
    include GitExecutor
    
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
      branches = execute_command('branch --no-color').gsub(/^[* ] /, '').lines.map(&:chomp).to_a
      branches.include? name
    end
    
    # -------------------------------------------------------------------------
    # -------------------------------------------------------------------------
    def exists_remotely?(name, remote)
      branches = execute_command('branch -r --no-color').gsub(/^[* ] /, '').lines.map(&:chomp).to_a
      branches.include? "#{remote}/#{name}"
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


