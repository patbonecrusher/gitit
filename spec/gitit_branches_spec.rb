require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

module Gitit

  describe GitBranches do

    # -------------------------------------------------------------------------
    # -------------------------------------------------------------------------
    describe '#test_branches_existance' do

      before(:each) do
        @repo_path = Dir.mktmpdir #{|dir| @repo_path = dir }
        @repo_path_bare = Dir.mktmpdir #{|dir| @repo_path_bare = dir }
    
        git = Git.new(@repo_path)
        @my_repo = git.repo
        @my_repo.init
        @repo_branches = git.branches

        `(cd #{@repo_path} && git config user.email "you@example.com")`
        `(cd #{@repo_path} && git config user.name "example")`

        File.open("#{@repo_path}/out.txt", 'w+') { |file| file.write('boo!') }
        `(cd #{@repo_path} && git add #{@repo_path}/out.txt && git commit -am "wip")`
        
        `(cd #{@repo_path_bare} && git init --bare)`
        `(cd #{@repo_path} && git remote add origin #{@repo_path_bare})`
        `(cd #{@repo_path} && git push origin master --quiet)`

      end

      it 'will successfully find a valid local branch' do
        expect(@repo_branches.exists_locally?('master')).to be_truthy
      end

      it 'will fail to find an invalid local branch' do
        expect(@repo_branches.exists_locally?('some_random_name')).to be_falsey
      end

      it 'will successfully find a valid remote branch' do
        expect(@repo_branches.exists_remotely?('master', 'origin')).to be_truthy
      end

      it 'will fail to find an invalid remote branch' do
        expect(@repo_branches.exists_remotely?('some_random_name', 'origin')).to be_falsey
      end

      it 'will successfully return the right branch name' do
        `(cd #{@repo_path} && git checkout master --quiet)`
        expect(@repo_branches.get_current_branch).to eq('master')
      end

      after(:each) do
        FileUtils.rm_rf @repo_path
        FileUtils.rm_rf @repo_path_bare
      end

    end

    # -------------------------------------------------------------------------
    # -------------------------------------------------------------------------
    describe '#testBranchCreationLocally' do

      before(:each) do
        @repo_path = Dir.mktmpdir #{|dir| @repo_path = dir }
        @repo_path_bare = Dir.mktmpdir #{|dir| @repo_path_bare = dir }

        git = Git.new(@repo_path)
        @my_repo = git.repo
        @my_repo.init
        @repo_branches = git.branches

        `(cd #{@repo_path} && git config user.email "you@example.com")`
        `(cd #{@repo_path} && git config user.name "example")`

        File.open("#{@repo_path}/out.txt", 'w+') { |file| file.write('boo!') }
        `(cd #{@repo_path} && git add #{@repo_path}/out.txt && git commit -am "wip")`
        
        `(cd #{@repo_path_bare} && git init --bare)`
        `(cd #{@repo_path} && git remote add origin #{@repo_path_bare})`
        `(cd #{@repo_path} && git push origin master --quiet)`

    
      end
    
      it 'will fail to create a local branch' do
        expect(@repo_branches.create_local_branch('mybranch')).to be_truthy
        expect(@repo_branches.create_local_branch('mybranch')).to be_falsey
      end

      it 'will create a local branch successfully' do
        expect(@repo_branches.create_local_branch('mybranch')).to be_truthy
        expect(@repo_branches.exists_locally?('mybranch')).to be_truthy
        expect(@repo_branches.exists_remotely?('mybranch', 'origin')).to be_falsey
      end

      it 'will fail to push a local branch to an invalid remote' do
        expect(@repo_branches.create_local_branch('mybranch')).to be_truthy
        expect(@repo_branches.exists_remotely?('mybranch', 'origin')).to be_falsey
        expect(@repo_branches.push_local_branch_to_remote('mybranch', 'badorigin', false)).to be_falsey
        expect(@repo_branches.exists_remotely?('mybranch', 'origin')).to be_falsey
      end

      it 'will push a local branch to the remote not forcing it' do
        expect(@repo_branches.create_local_branch('mybranch')).to be_truthy
        expect(@repo_branches.exists_remotely?('mybranch', 'origin')).to be_falsey
        expect(@repo_branches.push_local_branch_to_remote('mybranch', 'origin', false)).to be_truthy
        expect(@repo_branches.exists_remotely?('mybranch', 'origin')).to be_truthy
      end

      it 'will push a local branch to the remote forcing it' do
        expect(@repo_branches.create_local_branch('mybranch')).to be_truthy
        expect(@repo_branches.exists_remotely?('mybranch', 'origin')).to be_falsey
        expect(@repo_branches.push_local_branch_to_remote('mybranch', 'origin', true)).to be_truthy
        expect(@repo_branches.exists_remotely?('mybranch', 'origin')).to be_truthy
      end

      after(:each) do
        FileUtils.rm_rf @repo_path
        FileUtils.rm_rf @repo_path_bare
      end

    end

    # -------------------------------------------------------------------------
    # -------------------------------------------------------------------------

  end

end

