module CurrentCart
  extend ActiveSupport::Concern

  private

    # Rails makes current session look like a hash to the controller, so
    # we'll store the ID of the cart in the session by indexing it w. symbol :cart_id
    # set_cart() gets the :cart_id from the session object & attempts to find cart corresponding to this id
    # Otherwise, it will create a new cart, store the id of the created cart into the session & return the new cart
    def set_cart
      @cart = Cart.find(session[:cart_id])
    rescue ActiveRecord::RecordNotFound
      @cart = Cart.create
      session[:cart_id] = @cart.id
    end

end
