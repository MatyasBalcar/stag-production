class SearchController < ApplicationController
  def index
    if params[:search] == '1705'
      render 'home/quiz_test'
    else
      @lecture_results = Lecture.where('lectures.predmet_name ILIKE :search  OR lectures.room ILIKE :search OR lectures.day ILIKE :search', search: "%#{params[:search]}%")
      @predmet_results = Predmet.where('name ILIKE :search OR adbreviation ILIKE :search OR teacher ILIKE :search', search: "%#{params[:search]}%")
    end
  end
end