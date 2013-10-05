#require 'sprockets/directive_processor'
#require 'ruby-bower'
#
#class Bower::DirectiveProcessor < Sprockets::DirectiveProcessor
#  def process_require_bower_dependencies_directive
#    Bower.new.list(sources: true)[".js"].each do |filename|
#      context.require_asset Rails.root.join(filename)
#    end
#  end
#end
