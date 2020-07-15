url = 'https://jsonplaceholder.typicode.com/posts/1'

response = HTTP.get(url)

ap JSON.parse(response.to_s)
