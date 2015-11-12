module ImproveVocabulary
  class Lesson
    def initialize(
      repeat_quantity = 5, data = {}
    )
      @repeat_quantity = repeat_quantity
      @fetcher = WordFetcher.new(repeat_quantity, data)
    end

    def learn
      while !(words = fetcher.give_me).empty?
        system("clear") or system("cls")
        words.each(&execute)
        puts 'Press RETURN to continue...'
        STDIN.gets.chomp.downcase
      end
      puts "Finished lesson"
    end

    private

    attr_reader :repeat_quantity, :fetcher

    def execute
      lambda do |word|
        puts "Translation of \"#{word.fetch(:word)}\""
        answer = read_answer
        correct_answer = word.fetch(:translate)

        puts "The correct answers are \"#{correct_answer}\""
        check_answer.call(answer, word)

        puts "-" * 40
      end
    end

    def check_answer
      lambda do |answer, word|
        answer_without_accent = remove_accent(answer)
        correct_answers = Array(
          word.fetch(:translate)
        ).each(&:downcase).map(&method(:remove_accent))

        if correct_answers.any? { |correct_answer| answer_without_accent == correct_answer }
          puts "Your answer is \e[32mCORRECT!\e[0m"
          update_fetcher.call(word)

          if word.fetch(:times) >= repeat_quantity
            puts "\e[34mYou've just learned \"#{word.fetch(:word)}\"\e[0m"
          end
        else
          puts "Your answer is \e[31mINCORRECT!\e[0m"
        end
      end
    end

    def update_fetcher
      lambda do |word|
        fetcher.update([word])
      end
    end

    def read_answer
      STDIN.gets.chomp.downcase
    end

    def remove_accent(word)
      word.tr(
        "ÀÁÂÃÄÅàáâãäåĀāĂăĄąÇçĆćĈĉĊċČčÐðĎďĐđÈÉÊËèéêëĒēĔĕĖėĘęĚěĜĝĞğĠġĢģĤĥĦħÌÍÎÏìíîïĨĩĪīĬĭĮįİıĴĵĶķĸĹĺĻļĽľĿŀŁłÑñŃńŅņŇňŉŊŋÒÓÔÕÖØòóôõöøŌōŎŏŐőŔŕŖŗŘřŚśŜŝŞşŠšſŢţŤťŦŧÙÚÛÜùúûüŨũŪūŬŭŮůŰűŲųŴŵÝýÿŶŷŸŹźŻżŽž",
        "AAAAAAaaaaaaAaAaAaCcCcCcCcCcDdDdDdEEEEeeeeEeEeEeEeEeGgGgGgGgHhHhIIIIiiiiIiIiIiIiIiJjKkkLlLlLlLlLlNnNnNnNnnNnOOOOOOooooooOoOoOoRrRrRrSsSsSsSssTtTtTtUUUUuuuuUuUuUuUuUuUuWwYyyYyYZzZzZz"
      )
    end
  end
end
