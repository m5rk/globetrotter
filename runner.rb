$LOAD_PATH.unshift('lib')

require 'runner'

if __FILE__ == $0
  Runner.main(ARGV)
end
