
TMP_PATH = '/tmp/'
BAD_PATH = '/adsdsadasdsa'
TEST_REPO_PATH = '/tmp/test_git'
TEST_REPO_PATH_BARE = '/tmp/test_git_bare'

if ENV['COVERAGE'] == 'yes'
  require 'simplecov'
  SimpleCov.start
end

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'rspec'
require 'gitit'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

RSpec.configure do |config|
  original_stderr = $stderr
  original_stdout = $stdout
  config.before(:all) do 
    # Redirect stderr and stdout
    $stderr = File.new(File.join(File.dirname(__FILE__), 'null.txt'), 'w')
    $stdout = File.new(File.join(File.dirname(__FILE__), 'null.txt'), 'w')
    `git config --global user.email "you@example.com"`
    `git config --global user.name "Your Name"`
  end
  config.after(:all) do 
    $stderr = original_stderr
    $stdout = original_stdout
  end
end

