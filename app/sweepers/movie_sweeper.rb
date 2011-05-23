class MovieSweeper < ActionController::Caching::Sweeper
  observe Movie # This sweeper is going to keep an eye on the Product model

  # If our sweeper detects that a Product was created call this
  def after_create(movie)
    expire_cache_for(movie)
  end

  # If our sweeper detects that a Product was updated call this
  def after_update(movie)
    expire_cache_for(movie)
  end

  # If our sweeper detects that a Product was deleted call this
  def after_destroy(movie)
    expire_cache_for(movie)
  end

  private

  def expire_cache_for(movie)
    expire_fragment(/movie/)
  end
end
