class GamesController < ApplicationController
  def new
    @grid = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    require 'open-uri'
    require 'json'

    # def run_game(attempt, grid, start_time, end_time)
    #   result = { time: end_time - start_time }

    #   score_and_message = score_and_message(attempt, grid, result[:time])
    #   result[:score] = score_and_message.first
    #   result[:message] = score_and_message.last

    #   result
    # end

    def display
      params[:score]
    end

    def score_and_message
      response = open("https://wagon-dictionary.herokuapp.com/#{params[:suggestion]}")
      json = JSON.parse(response.read)

      time_taken = 10.0

      if guess.chars.all? { |letter| params[:suggestion].upcase.count(letter) <= @grid.count(letter) }
        if json['found']
          if time_taken > 60.0
            params[:score] = 0
          else
            score = params[:suggestion].size * (1.0 - time_taken / 60.0)
            params[:score] = score
          end
        else
          params[:score] = 0
        end
      else
        params[:score] = 0
      end
    end
  end
end
