class Admin::ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def new
  end

  def create
  end

  def destroy
  end
end
