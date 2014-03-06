
module Gitit

  module CommandExecutor

    attr_reader :repo

    def execute_command(command)
      gitCommand = ['git', command].join(' ')
      `(cd #{@repo.location} && #{gitCommand} 2>&1)`
    end

  end

end

