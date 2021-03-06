$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'simplecov'
SimpleCov.start do
  add_filter '/spec/'
end


require 'rspec'
require 'chromaprint'
require 'webmock/rspec'
require 'pry'

require 'audio_glue'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}


FIXTURES_PATH          = File.expand_path('../fixtures/', __FILE__)
SOUND_FIXTURES_PATH    = File.join(FIXTURES_PATH, 'sounds')
TEMPLATE_FIXTURES_PATH = File.join(FIXTURES_PATH, 'templates')

RSpec.configure do |config|
  # Generate the filename for a temporary file.
  #
  # @param ext [String] file extension
  #
  # @return [String] filename
  def gen_tmp_filename(ext = 'mp3')
    Dir::Tmpname.make_tmpname ['/tmp/audio-glue-test-', ".#{ext}"], nil
  end

  # Get the absolute path to a fixture file by its filename.
  #
  # @param filename [String]
  #
  # @return [String] path
  def fixture(filename)
    File.join(FIXTURES_PATH, filename)
  end

  def template_fixture(filename)
    File.join(TEMPLATE_FIXTURES_PATH, filename)
  end
end
