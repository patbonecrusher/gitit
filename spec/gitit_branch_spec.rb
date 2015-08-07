require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

module Gitit

  describe 'GitBranchSpec' do

    # -------------------------------------------------------------------------
    # -------------------------------------------------------------------------
    describe '#test_repo_branch' do

      before(:each) do
        @repo_path = Dir.mktmpdir #{|dir| @repo_path = dir }
        @repo_path_bare = Dir.mktmpdir #{|dir| @repo_path_bare = dir }

        git = Git.new(@repo_path)
        @my_repo = git.repo
        @my_repo.init
        @repo_branches = git.branches
      end

      it 'will tell us if the branch is a valid branch' do
      end

      after(:each) do
        FileUtils.rm_rf @repo_path
      end

    end
  end

end
