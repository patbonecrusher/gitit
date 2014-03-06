require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

module Gitit

  describe Config do

    # -----------------------------------------------------------------------------
    # -----------------------------------------------------------------------------
    ['--local', '--global', '--file /tmp/foo'].each { |mode|

      # ---------------------------------------------------------------------------
      # ---------------------------------------------------------------------------
      %w(mytestkey mytestkey.withsub).each {|key_section|
      
        # -------------------------------------------------------------------------
        # -------------------------------------------------------------------------
        describe "#TestConfig #{mode} with key_section #{key_section}" do

          before(:each) do
            FileUtils.mkpath TEST_REPO_PATH
            @git = Git.new(TEST_REPO_PATH)
            @git.repo.init
            @config = Config.new(@git.repo, mode)

            @key_name = 'bla'
            @key = key_section + '.' + @key_name
            @key_value = 'osd aas as dsaadk'.force_encoding('UTF-8')

          end
        
          it 'will set the specified key to the specified value successfully' do
            lambda{@config.set_value(@key, @key_value)}.should_not raise_error

            `(git config #{mode} --unset #{@key})`
            `(cd #{TEST_REPO_PATH} && git config #{mode} --remove-section #{key_section})`
          end
          
          it 'will retrieve the specified value successfully' do
            value = ''
            lambda{@config.set_value(@key, @key_value)}.should_not raise_error
            lambda{value = @config.get_value(@key)}.should_not raise_error
            value.should eq @key_value

            `(git config #{mode} --unset #{@key})`
            `(cd #{TEST_REPO_PATH} && git config #{mode} --remove-section #{key_section})`
          end

          it 'will unset the specified key successfully' do
            lambda{@config.set_value(@key, @key_value)}.should_not raise_error
            lambda{@config.unset_value(@key)}.should_not raise_error
            lambda{@config.get_value(@key)}.should raise_error

            `(cd #{TEST_REPO_PATH} && git config #{mode} --remove-section #{key_section})`
          end
          
          it 'will remove the specified section successfully' do
            lambda{@config.set_value(@key, @key_value)}.should_not raise_error
            lambda{@config.unset_value(@key)}.should_not raise_error
            lambda{@config.remove_section(key_section)}.should_not raise_error
            lambda{@config.get_value(@key)}.should raise_error
          end
          
          after(:each) do
            FileUtils.rm_rf TEST_REPO_PATH
          end

        end

      }
    }

  end
end
