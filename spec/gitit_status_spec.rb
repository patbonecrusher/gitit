require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
#require "gitit"

module Gitit

  describe Repo do

    # -------------------------------------------------------------------------
    # -------------------------------------------------------------------------
    describe "#testRepoStatus" do

      before(:each) do
        FileUtils.mkpath TEST_REPO_PATH
        git = Git.new(TEST_REPO_PATH)
        @myRepo = git.repo
        @myRepo.init
        @repoStatus = git.status
      end
    
      it "will tell us that the current branch is clean when nothing has been changed" do
        @repoStatus.clean?.should eq true
      end

      it "will tell us that the current branch is not clean when there are untracked file" do
        File.open("#{TEST_REPO_PATH}/out.txt", "w+") { |file| file.write("boo!") }
        @repoStatus.untrackedFiles?.should eq true
        @repoStatus.unstagedFiles?.should eq false
        @repoStatus.uncommitedFiles?.should eq false
        @repoStatus.clean?.should eq false
      end

      it "will tell us that the current branch is not clean when there are unstaged file" do
        File.open("#{TEST_REPO_PATH}/out.txt", "w+") { |file| file.write("boo!") }
        `(cd #{TEST_REPO_PATH} && git add #{TEST_REPO_PATH}/out.txt)`
        `(cd #{TEST_REPO_PATH} && git commit -am "wip")`
        File.open("#{TEST_REPO_PATH}/out.txt", "w") { |file| file.write("bdssdsoo!") }
        @repoStatus.untrackedFiles?.should eq false
        @repoStatus.unstagedFiles?.should eq true
        @repoStatus.uncommitedFiles?.should eq false
        @repoStatus.clean?.should eq false
      end

      it "will tell us that the current branch is not clean when there are uncommited file" do
        File.open("#{TEST_REPO_PATH}/out.txt", "w+") { |file| file.write("boo!") }
        `(cd #{TEST_REPO_PATH} && git add #{TEST_REPO_PATH}/out.txt)`
        `(cd #{TEST_REPO_PATH} && git commit -am "wip")`
        File.open("#{TEST_REPO_PATH}/out.txt", "w") { |file| file.write("bdssdsoo!") }
        `(cd #{TEST_REPO_PATH} && git add #{TEST_REPO_PATH}/out.txt)`
        @repoStatus.untrackedFiles?.should eq false
        @repoStatus.unstagedFiles?.should eq false
        @repoStatus.uncommitedFiles?.should eq true
        @repoStatus.clean?.should eq false
      end

      it "will tell us that there are untracked files after adding a new file" do
        File.open("#{TEST_REPO_PATH}/out.txt", "w+") { |file| file.write("boo!") }
        @repoStatus.untrackedFiles?.should eq true
      end

      it "will tell us that there are unstage files after modifying a file" do
        File.open("#{TEST_REPO_PATH}/out.txt", "w+") { |file| file.write("boo!") }
        `(cd #{TEST_REPO_PATH} && git add #{TEST_REPO_PATH}/out.txt)`
        `(cd #{TEST_REPO_PATH} && git commit -am "wip")`
        File.open("#{TEST_REPO_PATH}/out.txt", "w") { |file| file.write("bdssdsoo!") }
        @repoStatus.unstagedFiles?.should eq true
      end

      it "will tell us if there are uncommit files after adding a modifiled file to staging" do
        File.open("#{TEST_REPO_PATH}/out.txt", "w+") { |file| file.write("boo!") }
        `(cd #{TEST_REPO_PATH} && git add #{TEST_REPO_PATH}/out.txt)`
        `(cd #{TEST_REPO_PATH} && git commit -am "wip")`
        File.open("#{TEST_REPO_PATH}/out.txt", "w") { |file| file.write("bdssdsoo!") }
        `(cd #{TEST_REPO_PATH} && git add #{TEST_REPO_PATH}/out.txt)`
        @repoStatus.uncommitedFiles?.should eq true
      end

      after(:each) do
        FileUtils.rm_rf TEST_REPO_PATH
      end

    end
  end
end

