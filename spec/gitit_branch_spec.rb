require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

module Gitit

  describe Branch do

    # -------------------------------------------------------------------------
    # -------------------------------------------------------------------------
    describe "#testRepoBranch" do

      before(:each) do
        FileUtils.mkpath TEST_REPO_PATH
        git = Git.new(TEST_REPO_PATH)
        @myRepo = git.repo
        @myRepo.init
        @repoBranch = Gitit::Branch.new(@myRepo, "master")
      end

      it "will tell us if the branch is a valid branch" do
      end

      after(:each) do
        FileUtils.rm_rf TEST_REPO_PATH
      end

    end
  end

end
