require "bundler/setup"

Bundler.require(:default)

module Gitit

  module CommandExecutor

    attr_reader :repo

    def executeCommand(command)
      gitCommand = ["git", command].join(" ")
      result = `(cd #{@repo.location} && #{gitCommand})`
      return result unless $?.exitstatus != 0
      raise "failure running command"
    end

  end

end

