class HangpersonGame
  
  # add the necessary class methods, attributes, etc. here
  attr_accessor   :word
  attr_accessor   :guesses
  attr_accessor   :wrong_guesses
  # to make the tests in spec/hangperson_game_spec.rb pass.
  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  def initialize(word)
    @word = word
    @guesses = ""
    @wrong_guesses = ""
  end

  def guess w
    raise ArgumentError.new('Guess entered was empty . . .') if w.nil?
    w.downcase!
    flag = true
    flag = false if (@guesses.include? w) || (@wrong_guesses.include? w)
  
    # IF GUESSES CORRECTLY
    if (@word.include? w)
      raise ArgumentError.new("Guess entered was empty . . .") if (w.empty? || /[^a-z]/.match(w) || w.nil?)
      @guesses << w unless (@guesses.include? w)
      return flag 
    # IF GUESSES INCORRECTLY
    else 
      raise ArgumentError.new("Guess entered was empty . . .") if (w.empty? || /[^a-z]/.match(w) || w.nil?)
      @wrong_guesses << w unless(@wrong_guesses.include? w)
      return flag
    end
  end
  
  def word_with_guesses

    str = '-' * @word.length
    
    @guesses.split('').each{|v|
        idx = (0 ... @word.length).find_all{|i| @word[i,1] == v}
        idx.each{|j| str[j] = v unless j.nil?}
      }
      
    return str
  end
  
  def check_win_or_lose
    if @wrong_guesses.length < 7
      (word_with_guesses == @word) ? :win : :play
      # puts "in check_win_or_lose"
    else 
      :lose  
      # puts "in else"
    end
  end
  
  
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end

