class Products::FilteredController < ApplicationController
  def index
    render json: {}, status: :ok
  end
end
