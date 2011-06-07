require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe KeywordsController do

  # This should return the minimal set of attributes required to create a valid
  # Keyword. As you add validations to Keyword, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    @attrs ||= Factory.attributes_for(:keyword)
  end

  describe "POST create" do
    before(:each) { @movie = Factory(:movie) }
    describe "with valid params" do
      it "creates a new Keyword" do
        expect {
          post :create, :movie_id => @movie.id, :keyword => valid_attributes
        }.to change(Keyword, :count).by(1)
      end

      it "assigns a newly created keyword as @keyword" do
        post :create, :movie_id => @movie.id, :keyword => valid_attributes
        assigns(:keyword).should be_a(Keyword)
        assigns(:keyword).should be_persisted
      end

      it "redirects to the created keyword" do
        post :create, :movie_id => @movie.id, :keyword => valid_attributes
        response.should redirect_to(edit_movie_path(@movie))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved keyword as @keyword" do
        # Trigger the behavior that occurs when invalid params are submitted
        Keyword.any_instance.stub(:save).and_return(false)
        post :create, :movie_id => @movie.id, :keyword => {}
        assigns(:keyword).should be_a_new(Keyword)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Keyword.any_instance.stub(:save).and_return(false)
        post :create, :movie_id => @movie.id, :keyword => {}
        response.should redirect_to(edit_movie_path(@movie))
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested keyword" do
      keyword = Keyword.create! valid_attributes
      expect {
        delete :destroy, :id => keyword.id.to_s
      }.to change(Keyword, :count).by(-1)
    end

    it "redirects to the keywords list" do
      keyword = Keyword.create! valid_attributes
      delete :destroy, :id => keyword.id.to_s
      response.should redirect_to(edit_movie_path(keyword.movie))
    end
  end

end
