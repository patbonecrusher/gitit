require "bundler/setup"

Bundler.require(:default)

module Gitit

  module CommandExecutor

    attr_reader :repo

    def executeCommand(command)
      gitCommand = ["git", command].join(" ")
      result = `(cd #{@repo.location} && #{gitCommand})`
      raise "failure running command" if $?.exitstatus != 0
      return result
    end

  end

end

