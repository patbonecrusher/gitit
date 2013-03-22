require "gitit"

module Gitit

  describe Git do

    # -------------------------------------------------------------------------
    # -------------------------------------------------------------------------
    describe "#initialize" do

      TMP_PATH = "/"
      BAD_PATH = "/adsdsadasdsa"
      TEST_REPO_PATH = "/tmp/test_git"
    
      before(:each) do
      end

      it "will open fine given a valid repo" do
        lambda{Git.new(Dir.pwd)}.should_not raise_error
      end

      it "will throw an error given an invalid repo" do
        lambda{Git.new(BAD_PATH)}.should raise_error
      end

      it "will return true on valid repo" do
        myRepo = Git.new(Dir.pwd)
        myRepo.isAValidRepo?.should eq true 
      end

      it "will return false on invalid repo" do
        myRepo = Git.new(TMP_PATH)
        myRepo.isAValidRepo?.should eq false
      end

    end

    # -------------------------------------------------------------------------
    # -------------------------------------------------------------------------
    describe "#initNewRepo" do

      before(:each) do
        FileUtils.mkpath TEST_REPO_PATH
        @myRepo = Git.new(TEST_REPO_PATH)
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

    # -------------------------------------------------------------------------
    # -------------------------------------------------------------------------
    describe "#configItem" do

      KEY_NAME = "mytest.bla"
      KEY_VALUE = "osd aas as dsaadk".force_encoding("UTF-8")

      before(:each) do
        FileUtils.mkpath TEST_REPO_PATH
        @myRepo = Git.new(TEST_REPO_PATH)
        @myRepo.createNewRepo
      end
    
      describe "while not using encryption" do
        it "will set the specified value successfully" do
          lambda{@myRepo.setConfigValue(KEY_NAME, KEY_VALUE, false)}.should_not raise_error
        end
        
        it "will retrieve the specified value successfully" do
          value = ""
          lambda{@myRepo.setConfigValue(KEY_NAME, KEY_VALUE, false)}.should_not raise_error
          lambda{value = @myRepo.getConfigValue(KEY_NAME, false)}.should_not raise_error
          value.should eq KEY_VALUE
        end
      end

      describe "while using encryption" do
        it "will encrypt and set the specified value successfully" do
          lambda{@myRepo.setConfigValue(KEY_NAME, KEY_VALUE, true)}.should_not raise_error
        end

        it "will store an encrypted value in the config" do
          lambda{@myRepo.setConfigValue(KEY_NAME, KEY_VALUE, true)}.should_not raise_error

          value = ""
          lambda{value = @myRepo.getConfigValue(KEY_NAME, false)}.should_not raise_error
          value.should_not eq KEY_VALUE
        end
        
        it "will retrieve and decrypt the specified value from the config" do
          lambda{@myRepo.setConfigValue(KEY_NAME, KEY_VALUE, true)}.should_not raise_error

          value = ""
          lambda{value = @myRepo.getConfigValue(KEY_NAME, true)}.should_not raise_error
          value.should eq KEY_VALUE
        end
      end
      
      after(:each) do
        FileUtils.rm_rf TEST_REPO_PATH
      end

    end


  end
    
end
