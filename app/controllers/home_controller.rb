class HomeController < ApplicationController
  include Utils::Line
  def index
    @l = Line.new
    sample =@l.get_access_token_response('Nl8DXGUX6BdbxOkXeKq4')
    
  end
  def faq
  end
end
