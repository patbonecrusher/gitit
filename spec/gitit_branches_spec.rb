require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

module Gitit

  describe Branches do

    # -------------------------------------------------------------------------
    # -------------------------------------------------------------------------
    describe '#test_branches_existance' do

      before(:each) do
        FileUtils.mkpath TEST_REPO_PATH
        git = Git.new(TEST_REPO_PATH)
        @my_repo = git.repo
        @my_repo.init
        @repoBranches = git.branches

        `(cd #{TEST_REPO_PATH} && git config user.email "you@example.com")`
        `(cd #{TEST_REPO_PATH} && git config user.name "example")`

        File.open("#{TEST_REPO_PATH}/out.txt", "w+") { |file| file.write("boo!") }
        `(cd #{TEST_REPO_PATH} && git add #{TEST_REPO_PATH}/out.txt && git commit -am "wip")`
        
        `(mkdir -p #{TEST_REPO_PATH_BARE} && cd #{TEST_REPO_PATH_BARE} && git init --bare)`
        `(cd #{TEST_REPO_PATH} && git remote add origin #{TEST_REPO_PATH_BARE})`
        `(cd #{TEST_REPO_PATH} && git push origin master --quiet)`

      end

      it 'will successfully find a valid local branch' do
        @repoBranches.exists_locally?('master').should eq true
      end

      it 'will fail to find an invalid local branch' do
        @repoBranches.exists_locally?('some_random_name').should eq false
      end

      it 'will successfully find a valid remote branch' do
        @repoBranches.exists_remotely?('master', 'origin').should eq true
      end

      it 'will fail to find an invalid remote branch' do
        @repoBranches.exists_remotely?('some_random_name', 'origin').should eq false
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
        @my_repo = git.repo
        @my_repo.init
        @repoBranches = git.branches

        File.open("#{TEST_REPO_PATH}/out.txt", "w+") { |file| file.write("boo!") }
        `(cd #{TEST_REPO_PATH} && git add #{TEST_REPO_PATH}/out.txt && git commit -am "wip")`
        
        `(mkdir -p #{TEST_REPO_PATH_BARE} && cd #{TEST_REPO_PATH_BARE} && git init --bare)`
        `(cd #{TEST_REPO_PATH} && git remote add origin #{TEST_REPO_PATH_BARE})`
        `(cd #{TEST_REPO_PATH} && git push origin master --quiet)`

      end
    
      it 'will fail to create a local branch' do
        @repoBranches.create_local_branch('mybranch').should eq true
        @repoBranches.create_local_branch('mybranch').should eq false
      end

      it 'will create a local branch successfully' do
        @repoBranches.create_local_branch('mybranch').should eq true
        @repoBranches.exists_locally?('mybranch').should eq true
        @repoBranches.exists_remotely?('mybranch', 'origin').should eq false
      end

      it 'will fail to push a local branch to an invalid remote' do
        @repoBranches.create_local_branch('mybranch').should eq true
        @repoBranches.exists_remotely?('mybranch', 'origin').should eq false
        @repoBranches.push_local_branch_to_remote('mybranch', 'badorigin', false).should eq false
        @repoBranches.exists_remotely?('mybranch', 'origin').should eq false
      end

      it 'will push a local branch to the remote not forcing it' do
        @repoBranches.create_local_branch('mybranch').should eq true
        @repoBranches.exists_remotely?('mybranch', 'origin').should eq false
        @repoBranches.push_local_branch_to_remote('mybranch', 'origin', false).should eq true
        @repoBranches.exists_remotely?('mybranch', 'origin').should eq true
      end

      it 'will push a local branch to the remote forcing it' do
        @repoBranches.create_local_branch('mybranch').should eq true
        @repoBranches.exists_remotely?('mybranch', 'origin').should eq false
        @repoBranches.push_local_branch_to_remote('mybranch', 'origin', true).should eq true
        @repoBranches.exists_remotely?('mybranch', 'origin').should eq true
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

