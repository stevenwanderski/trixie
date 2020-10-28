class ProxyRequest
  def initialize(proxy:, body:)
    @body = body
    @proxy = proxy
  end

  def run!
    url = @proxy.target_url
    method = @proxy.target_request_type
    body = @body

    request(url, method, body)
  end

  private

  def headers
    @proxy.proxy_headers.map do |header|
      [header.name, header.value]
    end.to_h
  end

  def request(url, method, body)
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
end
