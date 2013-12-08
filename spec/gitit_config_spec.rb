require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
#require "gitit"

module Gitit

  describe Config do

    # -------------------------------------------------------------------------
    # -------------------------------------------------------------------------
    describe "#Config" do

      KEY_NAME = "mytest.bla"
      KEY_VALUE = "osd aas as dsaadk".force_encoding("UTF-8")

      before(:each) do
        FileUtils.mkpath TEST_REPO_PATH
        @git = Git.new(TEST_REPO_PATH)
        @git.repo.init
        @config = @git.config
      end
    
      it "will set the specified local value successfully" do
        lambda{@config.setValue(KEY_NAME, KEY_VALUE)}.should_not raise_error
      end
      
      it "will retrieve the specified local value successfully" do
        value = ""
        lambda{@config.setValue(KEY_NAME, KEY_VALUE)}.should_not raise_error
        lambda{value = @config.getValue(KEY_NAME)}.should_not raise_error
        value.should eq KEY_VALUE
      end

      it "will set the specified global value successfully" do
        lambda{@config.setGlobalValue(KEY_NAME, KEY_VALUE)}.should_not raise_error
      end
      
      it "will retrieve the specified global value successfully" do
        value = ""
        lambda{@config.setGlobalValue(KEY_NAME, KEY_VALUE)}.should_not raise_error
        lambda{value = @config.getGlobalValue(KEY_NAME)}.should_not raise_error
        value.should eq KEY_VALUE
      end

      after(:each) do
        FileUtils.rm_rf TEST_REPO_PATH
      end

    end
  end
end
