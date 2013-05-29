require "gitit"

module Gitit

  describe Git do

    # -------------------------------------------------------------------------
    # -------------------------------------------------------------------------
    describe "#Config" do

      KEY_NAME = "mytest.bla"
      KEY_VALUE = "osd aas as dsaadk".force_encoding("UTF-8")

      before(:each) do
        FileUtils.mkpath TEST_REPO_PATH
        @myRepo = Git.new(TEST_REPO_PATH)
        @myRepo.createNewRepo
        @config = @myRepo.config
      end
    
      describe "while not using encryption" do
        it "will set the specified value successfully" do
          lambda{@config.setValue(KEY_NAME, KEY_VALUE, false)}.should_not raise_error
        end
        
        it "will retrieve the specified value successfully" do
          value = ""
          lambda{@config.setValue(KEY_NAME, KEY_VALUE, false)}.should_not raise_error
          lambda{value = @config.getValue(KEY_NAME, false)}.should_not raise_error
          value.should eq KEY_VALUE
        end
      end

      describe "while using encryption" do
        it "will encrypt and set the specified value successfully" do
          lambda{@config.setValue(KEY_NAME, KEY_VALUE, true)}.should_not raise_error
        end

        it "will store an encrypted value in the config" do
          lambda{@config.setValue(KEY_NAME, KEY_VALUE, true)}.should_not raise_error

          value = ""
          lambda{value = @config.getValue(KEY_NAME, false)}.should_not raise_error
          value.should_not eq KEY_VALUE
        end
        
        it "will retrieve and decrypt the specified value from the config" do
          lambda{@config.setValue(KEY_NAME, KEY_VALUE, true)}.should_not raise_error

          value = ""
          lambda{value = @config.getValue(KEY_NAME, true)}.should_not raise_error
          value.should eq KEY_VALUE
        end
      end
      
      after(:each) do
        FileUtils.rm_rf TEST_REPO_PATH
      end

    end


  end
    
end
