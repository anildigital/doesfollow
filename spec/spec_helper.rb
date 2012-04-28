$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib', 'strategies'))


require 'doesfollow'
require 'doesfollow-default'
require 'doesfollow-console'
require 'rspec'
