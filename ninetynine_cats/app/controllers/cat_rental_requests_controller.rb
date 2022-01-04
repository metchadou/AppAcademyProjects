class CatRentalRequestsController < ApplicationController
  def new
    @cats = Cat.all
    @cat = Cat.find_by(id: params[:cat_id])

    render :new
  end

  def create
    @cat_rental_request = CatRentalRequest.new(cat_rental_request_params)

    if @cat_rental_request.save
      redirect_to cat_url(@cat_rental_request.cat_id)
    else
      redirect_to new_cat_cat_rental_request_url(@cat_rental_request.cat_id)
    end
  end

  def approve
    @request = CatRentalRequest.find_by(id: params[:id])
    @request.approve!
    redirect_to cat_url(@request.cat_id)
  end

  def deny
    @request = CatRentalRequest.find_by(id: params[:id])
    @request.deny!
    redirect_to cat_url(@request.cat_id)
  end

  private

  def cat_rental_request_params
    params.require(:cat_rental_request).permit(:cat_id, :start_date, :end_date)
  end
end