class UrlsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:new, :create, :show]

  def new
    @url = Url.new
  end

  def create
    @url = Url.find_or_initialize_by(url_params)

    unless @url.new_record?
      render json: { message: "short url for this corresponding long url already exists", url: @url }, status: :ok
      return
    end

    short_url = @url.generate_short_url(6)

    @url.assign_attributes(short_url: short_url)

    if @url.save
      render json: { message: "URL created successfully", url: @url }, status: :created
    else
      render json: { error: "Failed to create URL" }, status: :internal_server_error
    end
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
