require 'open-uri'
class GamesController < ApplicationController
  def new
    @letters = ("a".."z").to_a.sample(10)
  end

  def english_word?
    url = "https://wagon-dictionary.herokuapp.com/#{@answer.downcase}"
    dictionary_call = URI.open(url).read
    json = JSON.parse(dictionary_call)
    return json['found']
  end

  def made_of?
    @answer = params[:word]
    split_answer = @answer.split
    split_answer.all? do |letter|
      @letters.include? letter
    end
  end

  def score
    @answer = params[:word]
    @letters = params[:letters]
    if english_word?
      @result = "Congratulations!#{@answer} is a valid English word!"
    else !english_word?
      @result = "Sorry, #{@answer} does not seem to be a valid English word.."
    end

    if made_of?
      @result = "Sorry, #{@answer} can't be build out of #{@letters}"
    end
  end
end
