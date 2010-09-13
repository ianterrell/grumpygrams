class GramSweeper < ActionController::Caching::Sweeper
  observe Gram 

  def after_create(gram)
    expire_cache_for(gram)
  end

  def after_update(gram)
    expire_cache_for(gram)
  end

  def after_destroy(gram)
    expire_cache_for(gram)
  end

private
  def expire_cache_for(gram)
    expire_page '/'
  end
end