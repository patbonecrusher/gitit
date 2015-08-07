require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

module Gitit

  describe GitConfig do

    # -----------------------------------------------------------------------------
    # -----------------------------------------------------------------------------
    ['--local', '--global'].each { |mode| #, '--file /tmp/foo'

      # ---------------------------------------------------------------------------
      # ---------------------------------------------------------------------------
      %w(mytestkey mytestkey.withsub).each {|key_section|

        # -------------------------------------------------------------------------
        # -------------------------------------------------------------------------
        describe "#TestConfig #{mode} with key_section #{key_section}" do

          before(:each) do
            @repo_path = Dir.mktmpdir #{|dir| @repo_path = dir }

            @git = Git.new(@repo_path)
            @git.repo.init
            @config = GitConfig.new(@git.repo, location: mode)

            @key_name = 'bla'
            @key = key_section + '.' + @key_name
            @key_value = 'osd aas as dsaadk'.force_encoding('UTF-8')

          end

          it 'will set the specified key to the specified value successfully' do
            expect{@config.set_value(@key, @key_value)}.to_not raise_error

            `(cd #{@repo_path} && git config #{mode} --unset #{@key})`
            `(cd #{@repo_path} && git config #{mode} --remove-section #{key_section})`
          end

          it 'will retrieve the specified value successfully' do
            value = ''
            expect{@config.set_value(@key, @key_value)}.to_not raise_error
            expect{value = @config.get_value(@key)}.to_not raise_error
            expect(value).to eq(@key_value)

            `(cd #{@repo_path} && git config #{mode} --unset #{@key})`
            `(cd #{@repo_path} && git config #{mode} --remove-section #{key_section})`
          end

          it 'will unset the specified key successfully' do
            expect{@config.set_value(@key, @key_value)}.to_not raise_error
            expect{@config.unset_value(@key)}.to_not raise_error
            expect{@config.get_value(@key)}.to raise_error

            `(cd #{@repo_path} && git config #{mode} --remove-section #{key_section})`
          end

          it 'will remove the specified section successfully' do
            expect{@config.set_value(@key, @key_value)}.to_not raise_error
            expect{@config.unset_value(@key)}.to_not raise_error
            expect{@config.remove_section(key_section)}.to_not raise_error
            expect{@config.get_value(@key)}.to raise_error
          end

          after(:each) do
            FileUtils.rm_rf @repo_path
          end

        end

      }
    }

  end
end
