class ListsController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @list = List.all
  end
  
  def new
    @list = List.new
  end
  
  def show
    @list = List.new
    @list = List.find(params[:id])
  end
  
  def edit
    @list = List.new
    @list = List.find(params[:id])
  end
  
  def create
   @list = List.new(secure_params)
 
   if @list.save
     redirect_to @list
   else
     render 'new'
   end
  end
  
  def update
    @list = List.find(params[:id])
 
    if @list.update(secure_params)
      redirect_to @list
    else
      render 'edit'
    end
  end
  
  def destroy
    @list = List.find(params[:id])
    @list.destroy
 
    redirect_to lists_path
  end
  
  private
  
  def secure_params
    params.require(:list).permit(:item, :quantity)
  end
    
    
end