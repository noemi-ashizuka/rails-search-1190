class MoviesController < ApplicationController
  def index
    # Plain active Record
    # if params[:query].present?
    #   @movies = Movie.where(title: params[:query])
    # else
    #   @movies = Movie.all
    # end

    # ILIKE
    # if params[:query].present?
    #   @movies = Movie.where("title ILIKE ?", "%#{params[:query]}%")
    # else
    #   @movies = Movie.all
    # end

    # Search multiple columns
    # if params[:query].present?
    #   query = "title ILIKE :query OR synopsis ILIKE :query"
    #   @movies = Movie.where(query, query: "%#{params[:query]}%")
    # else
    #   @movies = Movie.all
    # end

    # Searching with associations (.joins)
    # if params[:query].present?
    #   query = <<~SQL
    #   movies.title ILIKE :query
    #   OR movies.synopsis ILIKE :query
    #   OR directors.first_name ILIKE :query
    #   OR directors.last_name ILIKE :query
    # SQL
    #   @movies = Movie.joins(:director).where(query, query: "%#{params[:query]}%")
    # else
    #   @movies = Movie.all
    # end

    # Multiple terms search @@
    # if params[:query].present?
    #   query = <<~SQL
    #   movies.title @@ :query
    #   OR movies.synopsis @@ :query
    #   OR directors.first_name @@ :query
    #   OR directors.last_name @@ :query
    # SQL
    #   @movies = Movie.joins(:director).where(query, query: "%#{params[:query]}%")
    # else
    #   @movies = Movie.all
    # end

    # PG Search
    
    if params[:query].present?
      # single model
      # @movies = Movie.search_by_title_and_synopsis(params[:query])
      # associated models
      @movies = Movie.global_search(params[:query])
    else
      @movies = Movie.all
    end
  end
end
