class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses

  # Get a word from remote "random word" service


  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start { |http|
      return http.post(uri, "").body
    }
  end

  def guess char
    if char =~ /[[:alpha:]]/
      char.downcase!

      if @word.include? char and !@guesses.include? char
        @guesses.concat char
        return true

      elsif !@wrong_guesses.include? char and !@word.include? char
        @wrong_guesses.concat char
        return true

      else return false end

    else
      char = :invalid
      raise ArgumentError
    end
  end

 def check_win_or_lose
    if word_with_guesses == word
      :win
    elsif wrong_guesses.length >= 7
      :lose
    else
      :play
    end
  end


def word_with_guesses
    word.gsub(/./)  { |letter| guesses.include?(letter) ? letter : '-' }
end

end
