require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
#require "gitit"

module Gitit

  describe Status do

    # -------------------------------------------------------------------------
    # -------------------------------------------------------------------------
    describe '#testRepoStatus' do

      before(:each) do
        FileUtils.mkpath TEST_REPO_PATH
        git = Git.new(TEST_REPO_PATH)
        @my_repo = git.repo
        @my_repo.init
        @repo_status = git.status

        `(cd #{TEST_REPO_PATH} && git config user.email "you@example.com")`
        `(cd #{TEST_REPO_PATH} && git config user.name "example")`

      end
    
      it 'will tell us that the current branch is clean when nothing has been changed' do
        @repo_status.clean?.should eq true
      end

      it 'will tell us that the current branch is not clean when there are untracked file' do
        File.open("#{TEST_REPO_PATH}/out.txt", 'w+') { |file| file.write('boo!') }
        @repo_status.untracked_files?.should eq true
        @repo_status.unstaged_files?.should eq false
        @repo_status.uncommited_files?.should eq false
        @repo_status.clean?.should eq false
      end

      it 'will tell us that the current branch is not clean when there are unstaged file' do
        File.open("#{TEST_REPO_PATH}/out.txt", 'w+') { |file| file.write('boo!') }
        `(cd #{TEST_REPO_PATH} && git add #{TEST_REPO_PATH}/out.txt)`
        `(cd #{TEST_REPO_PATH} && git commit -am "wip")`
        File.open("#{TEST_REPO_PATH}/out.txt", 'w') { |file| file.write('bdssdsoo!') }
        @repo_status.untracked_files?.should eq false
        @repo_status.unstaged_files?.should eq true
        @repo_status.uncommited_files?.should eq false
        @repo_status.clean?.should eq false
      end

      it 'will tell us that the current branch is not clean when there are uncommited file' do
        File.open("#{TEST_REPO_PATH}/out.txt", 'w+') { |file| file.write('boo!') }
        `(cd #{TEST_REPO_PATH} && git add #{TEST_REPO_PATH}/out.txt)`
        `(cd #{TEST_REPO_PATH} && git commit -am "wip")`
        File.open("#{TEST_REPO_PATH}/out.txt", 'w') { |file| file.write('bdssdsoo!') }
        `(cd #{TEST_REPO_PATH} && git add #{TEST_REPO_PATH}/out.txt)`
        @repo_status.untracked_files?.should eq false
        @repo_status.unstaged_files?.should eq false
        @repo_status.uncommited_files?.should eq true
        @repo_status.clean?.should eq false
      end

      it 'will tell us that there are untracked files after adding a new file' do
        File.open("#{TEST_REPO_PATH}/out.txt", 'w+') { |file| file.write('boo!') }
        @repo_status.untracked_files?.should eq true
      end

      it 'will tell us that there are unstage files after modifying a file' do
        File.open("#{TEST_REPO_PATH}/out.txt", "w+") { |file| file.write('boo!') }
        `(cd #{TEST_REPO_PATH} && git add #{TEST_REPO_PATH}/out.txt)`
        `(cd #{TEST_REPO_PATH} && git commit -am "wip")`
        File.open("#{TEST_REPO_PATH}/out.txt", 'w') { |file| file.write('bdssdsoo!') }
        @repo_status.unstaged_files?.should eq true
      end

      it 'will tell us if there are uncommit files after adding a modified file to staging' do
        File.open("#{TEST_REPO_PATH}/out.txt", 'w+') { |file| file.write('boo!') }
        `(cd #{TEST_REPO_PATH} && git add #{TEST_REPO_PATH}/out.txt)`
        `(cd #{TEST_REPO_PATH} && git commit -am "wip")`
        File.open("#{TEST_REPO_PATH}/out.txt", 'w') { |file| file.write('bdssdsoo!') }
        `(cd #{TEST_REPO_PATH} && git add #{TEST_REPO_PATH}/out.txt)`
        @repo_status.uncommited_files?.should eq true
      end

      after(:each) do
        FileUtils.rm_rf TEST_REPO_PATH
      end

    end
  end
end

