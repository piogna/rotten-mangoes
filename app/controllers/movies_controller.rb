class MoviesController < ApplicationController
  def index
    if params
      params.except!(:utf8, :controller, :action, :commit)
      @movies = Movie.query(params)
    else
      @movies = Movie.all
    end

  end

  def show
    @movie = Movie.find(params[:id])
  end

  def new
    @movie = Movie.new
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def create
    @movie = Movie.new(movie_params)

    if @movie.save
      redirect_to movies_path, notice: "#{@movie.title} was submitted sucessfully!"
    else
      render :new
    end
  end

  def update
    @movie = Movie.find(params[:id])

    if movie.update_attributes(movie_params)
      redirect_to movie_path(@movie)
    else
      render :edit
    end
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    redirect_to movies_path
  end

  def search
    @select_options = [["Select from list", 0], ["Under 90 minutes", 1], ["Between 90 and 120 minutes", 2], ["Over 120 minutes", 3]]
  end

  def query
    params.except!(:utf8, :controller, :action, :commit)
    @movies = Movie.query(params)
  end

  protected

  def movie_params
    params.require(:movie).permit(
      :title, :release_date, :director, :runtime_in_minutes, :poster,
      :description
    )
  end
end
