require "gitit"

module Gitit

  describe Gitit do

    # -------------------------------------------------------------------------
    # -------------------------------------------------------------------------
    describe "#initialize" do

      TMP_PATH = "/"
      BAD_PATH = "/adsdsadasdsa"
      TEST_REPO_PATH = "/tmp/test_git"
    
      before(:each) do
      end

      it "will open fine given a valid repo" do
        lambda{GitIt.new(Dir.pwd)}.should_not raise_error
      end

      it "will throw an error given an invalid repo" do
        lambda{GitIt.new(BAD_PATH)}.should raise_error
      end

      it "will return true on valid repo" do
        myRepo = GitIt.new(Dir.pwd)
        myRepo.isAValidRepo?.should eq true 
      end

      it "will return false on invalid repo" do
        myRepo = GitIt.new(TMP_PATH)
        myRepo.isAValidRepo?.should eq false
      end

    end

    # -------------------------------------------------------------------------
    # -------------------------------------------------------------------------
    describe "#initNewRepo" do

      before(:each) do
        FileUtils.mkpath TEST_REPO_PATH
        @myRepo = GitIt.new(TEST_REPO_PATH)
      end
    
      it "will initialize a new repo on an existing folder" do
        @myRepo.isAValidRepo?.should eq false
        lambda{@myRepo.createNewRepo}.should_not raise_error
      end

      it "will fail to initialize a new repo on an existing folder already initialized" do
        @myRepo.isAValidRepo?.should eq false
        lambda{@myRepo.createNewRepo}.should_not raise_error
        @myRepo.isAValidRepo?.should eq true
        lambda{@myRepo.createNewRepo}.should raise_error
      end

      after(:each) do
        FileUtils.rm_rf TEST_REPO_PATH
      end

    end

  end
    
end
