module ImproveVocabulary
  class LessonLoader
    def initialize(path, parser = nil)
      @path = path
      @parser = parser || default_parser
    end

    def fetch_data
      parser.call(path).dup.freeze
    end

    private

    attr_reader :path, :parser

    def default_parser
      -> (path) { require 'yaml'; YAML.load_file(path) }
    end
  end
end
