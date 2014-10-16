class ArticlesController < ApplicationController

  def index
   @articles = Article.all
  end
  
  def new
   @article = Article.new
  end
  
  def create
   @article = Article.new(params[:article])
  
   if @article.save
    redirect_to @article
   else
    render 'new'
   end
   
   #how to see posted data
   #render plain: params[:article].inspect
   #@article = params.inspect
  end
  
  def show
   @article = Article.find(params[:id])
  end
  
  def edit
   @article = Article.find(params[:id])
  end
  
  def update
   @article = Article.find(params[:id])
   if @article.update_attributes(params[:article])
    redirect_to @article
   else
    render 'edit'
   end
  end # def update
  
  def destroy
   @article = Article.find(params[:id])
   @article.destroy
   
   redirect_to articles_path
  end
  
private
  def article_params
    params.require(:article).permit(:title, :text)
  end
  
end
