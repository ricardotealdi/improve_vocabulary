module ImproveVocabulary
  class WordFetcher
    def initialize(repeat_times = 5, data = {})
      @repeat_times = repeat_times
      @data = data
      @words = map_words
    end

    def give_me(quantity = 5)
      take(quantity)
    end

    def update(words_to_update)
      increment_tries = lambda do |row|
        words.detect { |it| it.fetch(:word) == row.fetch(:word) }[:times] += 1
      end

      words_to_update.each(&increment_tries)
    end

    private

    attr_reader :repeat_times, :data, :words

    def take(quantity)
      words.dup.
        delete_if(&only_less_than_max_tries).
        shuffle.
        sort(&sort_by_tries).
        take(quantity).
        shuffle
    end

    def only_less_than_max_tries
      ->(row) { row.fetch(:times) >= repeat_times }
    end

    def sort_by_tries
      ->(a,b) { b.fetch(:times) <=> a.fetch(:times) }
    end

    def map_words
      data.inject([]) do |acc, (k, v)|
        acc << { word: k, translate: v , times: 0 }
        acc
      end
    end
  end
end
