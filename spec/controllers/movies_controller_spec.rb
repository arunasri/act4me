require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe MoviesController do
  include AuthenticationTestHelper

  # This should return the minimal set of attributes required to create a valid
  # Movie. As you add validations to Movie, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    Factory.attributes_for(:movie)
  end

  describe "GET index" do
    it "assigns all movies as @movies" do
      movie = Movie.create! valid_attributes
      Movie.should_receive(:active).and_return(mock(:paginate => [movie]))
      get :index
      assigns(:movies).should eq([movie])
    end
  end

  describe "GET show" do
    it "assigns the requested movie as @movie" do
      movie = Movie.create! valid_attributes
      get :show, :id => movie.to_param
      assigns(:movie).should eq(movie)
    end
  end

  describe "GET new" do
    it "assigns a new movie as @movie" do
      login_as_admin
      get :new
      assigns(:movie).should be_a_new(Movie)
    end
  end

  describe "GET edit" do
    it "assigns the requested movie as @movie" do
      login_as_admin
      movie = Movie.create! valid_attributes
      get :edit, :id => movie.to_param
      assigns(:movie).should eq(movie)
    end
  end

  describe "POST create" do
    before(:each) { login_as_admin }
    describe "with valid params" do

      it "creates a new Movie" do
        expect {
          post :create, :movie => valid_attributes
        }.to change(Movie, :count).by(1)
      end

      it "assigns a newly created movie as @movie" do
        post :create, :movie => valid_attributes
        assigns(:movie).should be_a(Movie)
        assigns(:movie).should be_persisted
      end

      it "redirects to the created movie" do
        post :create, :movie => valid_attributes
        response.should redirect_to(Movie.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved movie as @movie" do
        # Trigger the behavior that occurs when invalid params are submitted
        Movie.any_instance.stub(:save).and_return(false)
        post :create, :movie => {}
        assigns(:movie).should be_a_new(Movie)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Movie.any_instance.stub(:save).and_return(false)
        post :create, :movie => {}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    before(:each) { login_as_admin }
    describe "with valid params" do
      it "updates the requested movie" do
        movie = Movie.create! valid_attributes
        # Assuming there are no other movies in the database, this
        # specifies that the Movie created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Movie.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => movie.to_param, :movie => {'these' => 'params'}
      end

      it "assigns the requested movie as @movie" do
        movie = Movie.create! valid_attributes
        put :update, :id => movie.to_param, :movie => valid_attributes
        assigns(:movie).should eq(movie)
      end

      it "redirects to the movie" do
        movie = Movie.create! valid_attributes
        put :update, :id => movie.to_param, :movie => valid_attributes.except(:name)
        response.should redirect_to(movie)
      end
    end

    describe "with invalid params" do
      it "assigns the movie as @movie" do
        movie = Movie.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Movie.any_instance.stub(:save).and_return(false)
        put :update, :id => movie.to_param, :movie => {}
        assigns(:movie).should eq(movie)
      end

      it "re-renders the 'edit' template" do
        movie = Movie.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Movie.any_instance.stub(:save).and_return(false)
        put :update, :id => movie.to_param, :movie => {}
        response.should render_template("edit")
      end
    end
  end
end
