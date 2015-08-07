require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
#require "gitit"

module Gitit

  describe GitStatus do

    # -------------------------------------------------------------------------
    # -------------------------------------------------------------------------
    describe '#testRepoStatus' do

      before(:each) do
        @repo_path = Dir.mktmpdir #{|dir| @repo_path = dir }

        git = Git.new(@repo_path)
        @my_repo = git.repo
        @my_repo.init
        @repo_status = git.status

        `(cd #{@repo_path} && git config user.email "you@example.com")`
        `(cd #{@repo_path} && git config user.name "example")`

      end
    
      it 'will tell us that the current branch is clean when nothing has been changed' do
        expect(@repo_status.clean?).to be_truthy
      end

      it 'will tell us that the current branch is not clean when there are untracked file' do
        File.open("#{@repo_path}/out.txt", 'w+') { |file| file.write('boo!') }
        expect(@repo_status.untracked_files?).to be_truthy
        expect(@repo_status.unstaged_files?).to be_falsey
        expect(@repo_status.uncommited_files?).to be_falsey
        expect(@repo_status.clean?).to be_falsey
      end

      it 'will tell us that the current branch is not clean when there are unstaged file' do
        File.open("#{@repo_path}/out.txt", 'w+') { |file| file.write('boo!') }
        `(cd #{@repo_path} && git add #{@repo_path}/out.txt)`
        `(cd #{@repo_path} && git commit -am "wip")`
        File.open("#{@repo_path}/out.txt", 'w') { |file| file.write('bdssdsoo!') }
        expect(@repo_status.untracked_files?).to be_falsey
        expect(@repo_status.unstaged_files?).to be_truthy
        expect(@repo_status.uncommited_files?).to be_falsey
        expect(@repo_status.clean?).to be_falsey
      end

      it 'will tell us that the current branch is not clean when there are uncommited file' do
        File.open("#{@repo_path}/out.txt", 'w+') { |file| file.write('boo!') }
        `(cd #{@repo_path} && git add #{@repo_path}/out.txt)`
        `(cd #{@repo_path} && git commit -am "wip")`
        File.open("#{@repo_path}/out.txt", 'w') { |file| file.write('bdssdsoo!') }
        `(cd #{@repo_path} && git add #{@repo_path}/out.txt)`
        expect(@repo_status.untracked_files?).to be_falsey
        expect(@repo_status.unstaged_files?).to be_falsey
        expect(@repo_status.uncommited_files?).to be_truthy
        expect(@repo_status.clean?).to be_falsey
      end

      it 'will tell us that there are untracked files after adding a new file' do
        File.open("#{@repo_path}/out.txt", 'w+') { |file| file.write('boo!') }
        expect(@repo_status.untracked_files?).to be_truthy
      end

      it 'will tell us that there are unstage files after modifying a file' do
        File.open("#{@repo_path}/out.txt", 'w+') { |file| file.write('boo!') }
        `(cd #{@repo_path} && git add #{@repo_path}/out.txt)`
        `(cd #{@repo_path} && git commit -am "wip")`
        File.open("#{@repo_path}/out.txt", 'w') { |file| file.write('bdssdsoo!') }
        expect(@repo_status.unstaged_files?).to be_truthy
      end

      it 'will tell us if there are uncommit files after adding a modified file to staging' do
        File.open("#{@repo_path}/out.txt", 'w+') { |file| file.write('boo!') }
        `(cd #{@repo_path} && git add #{@repo_path}/out.txt)`
        `(cd #{@repo_path} && git commit -am "wip")`
        File.open("#{@repo_path}/out.txt", 'w') { |file| file.write('bdssdsoo!') }
        `(cd #{@repo_path} && git add #{@repo_path}/out.txt)`
        expect(@repo_status.uncommited_files?).to be_truthy
      end

      after(:each) do
        FileUtils.rm_rf @repo_path
      end

    end
  end
end

