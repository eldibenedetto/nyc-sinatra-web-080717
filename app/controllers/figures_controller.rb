require 'pry'
class FiguresController < ApplicationController

 get'/figures' do
    @figures = Figure.all
    erb :'/figures/index'
  end
  get '/figures/new' do
    erb :'/figures/new'
  end

 get '/figures/:id/edit' do
    @figure = Figure.find(params[:id])
    erb :'/figures/edit'
  end

 post '/figures/:id' do
    @figure = Figure.find(params[:id])
    @figure.update(params[:figure])
    if params[:figure].has_key?(:title_ids)
    @figure.titles = params[:figure][:title_ids].collect do |title_id|
      Title.find(title_id)
      end
    end
    if !(params[:new_landmark][:name].empty? && params[:new_landmark][:year_completed].empty?)
      @figure.landmarks << Landmark.create(params[:new_landmark])
    end
    if !params[:new_title][:name].empty?
      @figure.titles << Title.create(params[:new_title])
    end
    @figure.save
    redirect "/figures/#{@figure.id}"
  end


 get '/figures/:id' do
    @figure = Figure.find(params[:id])

   erb :'/figures/show'
  end

 post '/figures' do

   @figure = Figure.create(params[:figure])
    # @figure.landmarks = params[:figure][:landmark_ids].collect do |landmark_id|
    #   Landmark.find(landmark_id)
    # end
    if params[:figure].has_key?(:title_ids)
    @figure.titles = params[:figure][:title_ids].collect do |title_id|
      Title.find(title_id)
      end
    end
    if !(params[:new_landmark][:name].empty? && params[:new_landmark][:year_completed].empty?)
      @figure.landmarks << Landmark.create(params[:new_landmark])
    end
    if !params[:new_title][:name].empty?
      @figure.titles << Title.create(params[:new_title])
    end

   redirect "/figures/#{@figure.id}"


 end
end
