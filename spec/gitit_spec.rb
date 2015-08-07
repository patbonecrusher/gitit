require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

module Gitit

  describe GitRepo do

    # -------------------------------------------------------------------------
    # -------------------------------------------------------------------------
    describe '#initialize' do

      before(:each) do
      end

      it 'will open fine given a valid repo' do
        expect { Git.new(Dir.pwd) }.to_not raise_exception
      end

      it 'will throw an error given an invalid repo' do
        expect { Git.new(BAD_PATH) }.to raise_exception
      end

      it 'will return true on valid repo' do
        my_repo = Git.new(Dir.pwd).repo
        expect(my_repo.valid?).to be_truthy
      end

      it 'will return false on invalid repo' do
        my_repo = Git.new(TMP_PATH).repo
        expect(my_repo.valid?).to be_falsey
      end

    end

    # -------------------------------------------------------------------------
    # -------------------------------------------------------------------------
    describe '#initNewRepo' do

      before(:each) do
        @repo_path = Dir.mktmpdir #{|dir| @repo_path = dir }

        git = Git.new(@repo_path)
        @my_repo = git.repo
      end
    
      it 'will initialize a new repo on an existing folder' do
        expect(@my_repo.valid?).to be_falsey
        expect { @my_repo.init }.to_not raise_exception
      end

      it 'will fail to initialize a new repo on an existing folder already initialized' do
        expect(@my_repo.valid?).to be_falsey
        expect { @my_repo.init }.to_not raise_exception
        expect(@my_repo.valid?).to be_truthy
        expect { @my_repo.init }.to raise_exception
      end

      after(:each) do
        FileUtils.rm_rf @repo_path
      end

    end

  end
    
end
