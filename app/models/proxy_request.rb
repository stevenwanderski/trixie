class ProxyRequest
  attr_accessor :params

  def initialize(params)
    @params = params
  end

  def run!
    request(url, method)
  end

  private

  def body
    hash = proxy.proxy_params.map do |proxy_param|
      value = params[proxy_param.param_from]
      [proxy_param.param_to, value]
    end.to_h

    if proxy.body_format == 'json'
      hash = hash.to_json
    end

    hash
  end

  def method
    proxy.target_request_type
  end

  def headers
    proxy.proxy_headers.map do |header|
      [header.name, header.value]
    end.to_h
  end

  def proxy
    @proxy ||= Proxy.find(proxy_id)
  end

  def proxy_id
    params[:id]
  end

  def request(url, method)
    case method
    when 'get'
      HTTParty.get(url, {
        query: body,
        headers: headers
      })

    when 'post'
      HTTParty.post(url, {
        body: body,
        headers: headers
      })

    when 'put'
      HTTParty.put(url, {
        body: body,
        headers: headers
      })

    when 'patch'
      HTTParty.patch(url, {
        body: body,
        headers: headers
      })
      
    when 'delete'
      HTTParty.delete(url, options)
    end
  end

  def url
    proxy.target_url
  end
end
