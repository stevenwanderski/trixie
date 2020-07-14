class ProxyRequest
  attr_accessor :params

  def initialize(params)
    @params = params
  end

  def run!
    response = request(target_url, method, body)

    Struct.new(body: response.body, code: repsonse.code)
  end

  private

  def method
    proxy.target_request_type
  end

  def proxy
    @proxy ||= Proxy.find(proxy_id)
  end

  def proxy_id
    params[:id]
  end

  def request(url, method, body)
    # do it here
  end

  def target_url
    proxy.target_url
  end
end
