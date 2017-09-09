class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  def initialize(word)
    @word = word
    @guesses = ""
    @wrong_guesses = ""
  end
  
  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses
  
  def guess (letters)
    raise ArgumentError if letters.nil?
    raise ArgumentError if letters == ""
    raise ArgumentError if !letters.match(/[A-Za-z]/)
    
    letters.downcase!
    if (@guesses.include? letters) or (@wrong_guesses.include? letters)
      return false
    end
    
    if @word.include? letters
      @guesses << letters
    else
      @wrong_guesses << letters
    end
  end
  
  
  def word_with_guesses
    return @word.gsub(/[^ #{@guesses}]/, "-")
  end 
  
  def check_win_or_lose
    if @wrong_guesses.length == 7
      return :lose
    elsif !word_with_guesses.include?("-")
      return :win
    else
      return :play
    end
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

end
