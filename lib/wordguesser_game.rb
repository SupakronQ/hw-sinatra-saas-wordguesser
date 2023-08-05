class WordGuesserGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/wordguesser_game_spec.rb pass.

  # Get a word from remote "random word" service

  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
    @correct_guesses = []
    @all_wrong_guesses = []


    # กรณีปัญหาตัวซ้ำ
    # @word_count = {}
    # @word.each_char do |char|
    #   @word_count[char] ||= 0
    #   @word_count[char] += 1
    # end

  end
  
  # You can test it by installing irb via $ gem install irb
  # and then running $ irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> WordGuesserGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://randomword.saasbook.info/RandomWord')
    Net::HTTP.new('randomword.saasbook.info').start { |http|
      return http.post(uri, "").body
    }
  end

  def word
    @word
  end

  def guesses
    @guesses
  end

  def wrong_guesses
    @wrong_guesses
  end

  def guess(guess_word)

    raise ArgumentError.new("Word is nill.") if guess_word.nil?
    raise ArgumentError.new("Word not in a-z or A-Z.") if !guess_word.match?(/[a-zA-Z]/)

    guess_word.downcase!

    if @word.include?(guess_word) && !@correct_guesses.include?(guess_word)
      @guesses = guess_word
      @correct_guesses << guess_word

    elsif !(@word.include?(guess_word)) && !@all_wrong_guesses.include?(guess_word)
      @wrong_guesses = guess_word
      @all_wrong_guesses << guess_word

    else
      false
      
    end
   
  end

  def word_with_guesses

    display_now = ""
    @word.each_char do |char|

      if @correct_guesses.include?(char)
        display_now << char
      else
        display_now << "-"
      end
    end
    display_now
  end

  def check_win_or_lose

    if word_with_guesses == @word
      :win

    elsif @all_wrong_guesses.length == 7 
      :lose

    else 
      :play
      
    end 

    
  end

end
