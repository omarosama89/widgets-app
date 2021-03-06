module ShowoffApiWrapper
  REMOTE_URL = APP_CONFIG['external_api_url']
  CLIENT_ID = APP_CONFIG['client_id']
  CLIENT_SECRET = APP_CONFIG['client_secret']

  def self.get(path, headers, params={})
    begin
      res = RestClient.get("#{REMOTE_URL}#{path}", headers.merge({params: {client_id: CLIENT_ID, client_secret: CLIENT_SECRET}.merge(params.to_hash)}))
    rescue RestClient::ExceptionWithResponse => e
      res = e.response
    end
    JSON.parse(res)
  end

  def self.post(path, payload, headers)
    begin
      res = RestClient.post("#{REMOTE_URL}#{path}", payload.merge({client_id: CLIENT_ID, client_secret: CLIENT_SECRET,}).to_json, headers)
    rescue RestClient::ExceptionWithResponse => e
      res = e.response
    end
    JSON.parse(res)
  end

  def self.put(path, payload, headers)
    begin
      res = RestClient.put("#{REMOTE_URL}#{path}", payload.to_json, headers)
    rescue RestClient::ExceptionWithResponse => e
      res = e.response
    end
    JSON.parse(res)
  end

  def self.delete(path, headers)
    begin
      res = RestClient.delete("#{REMOTE_URL}#{path}", headers)
    rescue RestClient::ExceptionWithResponse => e
      res = e.response
    end
    JSON.parse(res)
  end
end