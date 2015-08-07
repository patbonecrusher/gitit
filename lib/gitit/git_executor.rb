
module Gitit

  module GitExecutor

    attr_reader :repo

    def self.repo
      @repo
    end

    def execute_command(command)
      git_command = ['git', command].join(' ')
      `(cd #{@repo.location} && #{git_command} 2>&1)`
    end

  end

end

