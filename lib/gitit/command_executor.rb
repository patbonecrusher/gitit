
module Gitit

  module CommandExecutor

    attr_reader :repo

    def executeCommand(command)
      gitCommand = ["git", command].join(" ")
      result = `(cd #{@repo.location} && #{gitCommand} 2>&1)`
      return result
    end

  end

end

