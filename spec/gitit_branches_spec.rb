require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

module Gitit

  describe Branches do

    # -------------------------------------------------------------------------
    # -------------------------------------------------------------------------
    describe "#testBranchesExistance" do

      before(:each) do
        FileUtils.mkpath TEST_REPO_PATH
        git = Git.new(TEST_REPO_PATH)
        @myRepo = git.repo
        @myRepo.init
        @repoBranches = git.branches

        `(cd #{TEST_REPO_PATH} && git config user.email "you@example.com")`
        `(cd #{TEST_REPO_PATH} && git config user.name "example")`

        File.open("#{TEST_REPO_PATH}/out.txt", "w+") { |file| file.write("boo!") }
        `(cd #{TEST_REPO_PATH} && git add #{TEST_REPO_PATH}/out.txt && git commit -am "wip")`
        
        `(mkdir -p #{TEST_REPO_PATH_BARE} && cd #{TEST_REPO_PATH_BARE} && git init --bare)`
        `(cd #{TEST_REPO_PATH} && git remote add origin #{TEST_REPO_PATH_BARE})`
        `(cd #{TEST_REPO_PATH} && git push origin master --quiet)`

      end

      it "will successfully find a valid local branch" do
        @repoBranches.existsLocally?("master").should eq true
      end

      it "will fail to find an invalid local branch" do
        @repoBranches.existsLocally?("asdasdsad").should eq false
      end

      it "will successfully find a valid remote branch" do
        @repoBranches.existsRemotely?("master", "origin").should eq true
      end

      it "will fail to find an invalid remote branch" do
        @repoBranches.existsRemotely?("asdasdsad", "origin").should eq false
      end

      it "will create a local branch successfully" do
        @repoBranches.createLocalBranch("mybranch").should eq true
        @repoBranches.existsLocally?("mybranch").should eq true
        @repoBranches.existsRemotely?("mybranch", "origin").should eq false
      end

      it "will push a local branch to the remote" do
        @repoBranches.createLocalBranch("mybranch").should eq true
        @repoBranches.existsRemotely?("mybranch", "origin").should eq false
        @repoBranches.pushLocalBranchToRemote("mybranch", "origin").should eq true        
        @repoBranches.existsRemotely?("mybranch", "origin").should eq true
      end

      after(:each) do
        FileUtils.rm_rf TEST_REPO_PATH
        FileUtils.rm_rf TEST_REPO_PATH_BARE
      end

    end

    # -------------------------------------------------------------------------
    # -------------------------------------------------------------------------
    describe "#testBranchCreationLocally" do

      before(:each) do
        FileUtils.mkpath TEST_REPO_PATH
        git = Git.new(TEST_REPO_PATH)
        @myRepo = git.repo
        @myRepo.init
        @repoBranches = git.branches

        File.open("#{TEST_REPO_PATH}/out.txt", "w+") { |file| file.write("boo!") }
        `(cd #{TEST_REPO_PATH} && git add #{TEST_REPO_PATH}/out.txt && git commit -am "wip")`
        
        `(mkdir -p #{TEST_REPO_PATH_BARE} && cd #{TEST_REPO_PATH_BARE} && git init --bare)`
        `(cd #{TEST_REPO_PATH} && git remote add origin #{TEST_REPO_PATH_BARE})`
        `(cd #{TEST_REPO_PATH} && git push origin master --quiet)`

      end
    
      after(:each) do
        FileUtils.rm_rf TEST_REPO_PATH
        FileUtils.rm_rf TEST_REPO_PATH_BARE
      end

    end

    # -------------------------------------------------------------------------
    # -------------------------------------------------------------------------

  end

end

