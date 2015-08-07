require 'gitit'
#require 'gitit/git_repo'

Dir[File.dirname(__FILE__) + '/git_*.rb'].each do |file|
  # noinspection RubyResolve
  require file
end

module Gitit
  
  # ---------------------------------------------------------------------------
  # ---------------------------------------------------------------------------
  class Git
    attr_reader :repo
    attr_reader :config
    attr_reader :status
    attr_reader :branches

    # -------------------------------------------------------------------------
    # -------------------------------------------------------------------------
    def initialize(location)
      @repo = GitRepo.new(location)
      @config = GitConfig.new(repo)
      @status = GitStatus.new(repo)
      @branches = GitBranches.new(repo)
    end
  end

end

  
