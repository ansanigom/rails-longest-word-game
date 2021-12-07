require 'open-uri'
class GamesController < ApplicationController
  def new
    @letters = ("a".."z").to_a.sample(10)
  end

  def english_word?
    url = "https://wagon-dictionary.herokuapp.com/#{@word.downcase}"
    dictionary_call = URI.open(url).read
    json = JSON.parse(dictionary_call)
    return json['found']
  end

  def made_of?(letters, word)
    word.upcase.chars.all? do |letter|
      word.upcase.count(letter) <= word.count(letter)
    end
  end

  def score
    @word = params[:word]
    @letters = params[:letters]
    unless made_of?(@letters, @word)
      if english_word?
        @result = "Congratulations! #{@word.upcase} is a valid English word!"
      else !english_word?
        @result = "Sorry, #{@word.upcase} does not seem to be a valid English word.."
      end
    else
      @result = "Sorry, #{@word.upcase} can't be built."
    end
  end
end
