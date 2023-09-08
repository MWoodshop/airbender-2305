class SearchController < ApplicationController
  def index
    decoded_nation = CGI.unescape(params[:nation])
    @facade = SearchFacade.new(decoded_nation)
  rescue SearchFacade::ApiError => e
    flash[:error] = e.message
    redirect_to root_path
  end
end
