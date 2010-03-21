module SessionsHelper

  def rpx_token_url
    dest = url_for :controller => :sessions, :action => :rpx_return, :only_path => false
    @rpx.signin_url(dest)
  end

  def rpx_embed_url
    dest = url_for :controller => :sessions, :action => :rpx_return, :only_path => false
    "#{rp_url}/openid/embed?token_url=#{CGI.escape(dest)}"
  end

  def rpx_map_url
    dest = url_for :controller => :sessions, :action => :rpx_map_return, :only_path => false
    @rpx.signin_url(dest)
  end

  def rpx_link
    %(<a class="rpxnow" onclick="return false;"
       href="#{rpx_token_url}">
      Use an external Account
    </a>)
  end

  private

  def rp_url
    parts = RPX_BASE_URL.split('://', 2)
    parts = parts.insert(1, '://' + RPX_REALM + '.')
    return parts.join('')
  end

end