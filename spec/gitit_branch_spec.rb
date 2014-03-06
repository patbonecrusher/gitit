require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

module Gitit

  describe Branch do

    # -------------------------------------------------------------------------
    # -------------------------------------------------------------------------
    describe '#test_repo_branch' do

      before(:each) do
        FileUtils.mkpath TEST_REPO_PATH
        git = Git.new(TEST_REPO_PATH)
        @my_repo = git.repo
        @my_repo.init
        @repoBranch = Gitit::Branch.new(@my_repo, 'master')
      end

      it 'will tell us if the branch is a valid branch' do
      end

      after(:each) do
        FileUtils.rm_rf TEST_REPO_PATH
      end

    end
  end

end
