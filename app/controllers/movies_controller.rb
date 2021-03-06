class MoviesController < ApplicationController

  geocode_ip_address

  before_filter :authenticate, :except => [:autocomplete, :index, :show, :positive, :assesed, :negative, :mixed, :closest]

  cache_sweeper :movie_sweeper, :only => [ :update, :create ]

  def closest
    @movie = Movie.find(params[:id].to_i)
    res = Geokit::Geocoders::GoogleGeocoder.reverse_geocode(params.values_at(:lat,:lng))
    @theaters = Scrapper.new(open(MovieFinder.new(@movie.name, res.zip).today)).to_theaters
    render :json => @theaters.to_json
  end


  def autocomplete
    movies = Movie.where(["movies.name like ?","%#{params[:term]}%"]).to_ary
    render :json => movies.inject([]) { |a,m| a << { :label => m.name, :url => movie_path(m) } }
  end

  # GET /movies
  # GET /movies.xml
  def index
    @movies = Movie.active.paginate(:page => params[:page], :per_page => 18)

    respond_to do |format|
      format.mobile
      format.html # index.html.erb
      format.xml  { render :xml => @movies }
    end
  end

  # GET /movies/1
  # GET /movies/1.xml
  def show
    @movie = Movie.find(params[:id].to_i)
    @tweets = @movie.tweets.assesed.paginate(:page => params[:page], :per_page => 21)

    respond_to do |format|
      format.mobile
      format.html # show.html.erb
    end
  end

  # GET /movies/new
  # GET /movies/new.xml
  def new
    @movie = Movie.new

    respond_to do |format|
      format.html { render :layout => 'admin' }
      format.xml  { render :xml => @movie }
    end

  end

  # GET /movies/1/edit
  def edit
    @movie = Movie.find(params[:id].to_i)
    @tweets = @movie.tweets.fresh.paginate(:page => params[:page])
    render :layout => 'admin'
  end

  # GET /movies/1/edit
  def sync
    @movie = Movie.find(params[:id].to_i).tap(&:sync)
    @tweets = @movie.tweets.paginate(:page => params[:page])
    render :json => { :html => 'ok' }
  end

  %w(assesed positive negative mixed fresh terminate external).each do |method|

    define_method(method) do
      @movie = Movie.find(params[:id].to_i)
      @tweets = @movie.tweets.send(method).paginate(:page => params[:page], :per_page => 21)

      respond_to do |format|
        format.mobile { render :action => :show }
        format.html { render :action => :show }
      end
    end

    define_method("edit_#{method}") do
      @movie  = Movie.find(params[:id].to_i)
      @search = @movie.tweets.send(method).search(params[:search])
      @tweets = @search.paginate(:page => params[:page])
      render :action => :admin, :layout => 'admin'
    end
  end


  # POST /movies
  # POST /movies.xml
  def create
    @movie = Movie.new(params[:movie])

    respond_to do |format|
      if @movie.save
        expire_page :action => :index
        format.html { redirect_to(@movie, :notice => 'Movie was successfully created.') }
        format.xml  { render :xml => @movie, :status => :created, :location => @movie }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @movie.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /movies/1
  # PUT /movies/1.xml
  def update
    @movie = Movie.find(params[:id].to_i)
    respond_to do |format|
      if @movie.update_attributes(params[:movie])
        expire_page :action => :index
        format.html { redirect_to(@movie, :notice => 'Movie was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit", :layout => 'admin' }
        format.xml  { render :xml => @movie.errors, :status => :unprocessable_entity }
      end
    end
  end
end
