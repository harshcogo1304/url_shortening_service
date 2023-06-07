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

  def redirect_to_long_url
    @url = Url.where(short_url: params[:short_url]).take

    if @url
      render json: { long_url: @url.long_url }
    else
      render json: { error: 'Short URL not found' }, status: :not_found
    end
  end

  def show
    @url = Url.where(short_url: params[:id]).take

    if @url
      render json: { long_url: @url.long_url }
    else
      render json: { error: 'Short URL not found' }, status: :not_found
    end
  end

  private

  def url_params
    params.require(:url).permit(:long_url)
  end
end
