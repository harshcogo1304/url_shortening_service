class UrlsController < ApplicationController

  skip_before_action :verify_authenticity_token, only: [:new, :create, :show]

  def new
    @url = Url.new
  end

  def create
    x = url_params

    puts x

    @url = Url.new(url_params)
    @url.save
    #   redirect_to url_path(@url.short_url)
    # else
    #   render :new
    # end
  end

  def show
    @url = Url.find_by(short_url: params[:id])
    redirect_to @url.long_url
  end

  private

  def url_params
    params.require(:url).permit(:long_url)
  end
end
