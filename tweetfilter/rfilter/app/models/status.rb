#TODO:kawashima initializer
module Net
  class HTTPResponse
    def each_line(rs = "\n")
      stream_check
      while line = @socket.readuntil(rs)
        yield line
      end
      self
    end
  end
end

class Status < ActiveRecord::Base

  OAUTHTOKEN=   ''
  OAUTHSECRET=  ''
  ACCESSTOKEN=  ''
  ACCESSSECRET= ''
  STREAM_URL =  'http://stream.twitter.com/1/statuses/filter.json'

  FILTER_KEYWORD = YAML.load_file(File.join(Rails.root.to_s, 'config', 'keyword.yml'))

  def self.search
    require 'nokogiri'
    nglist = []
    ng.each do |w|
      nglist << "-#{w}"
    end
    ngword = nglist.join(' ')
    ok.each do |tag|
      r = nil
      begin
      Net::HTTP.start('search.twitter.com', 80) do |http|
        query = "#{tag} #{ngword}"
        r = http.get("/search.atom?lang=ja&rpp=100&q=#{URI.escape(query)}")
      end
      rescue
        logger.info("Net::HTTP Error")
      end
      next unless r
      html = Nokogiri(r.body)
      (html/"entry").each do |content|
        entry = (content/"content").text.rstrip

        data = {}
        data[:status_id] = (content/"id").text.split(':').last.to_i

        at = DateTime.parse((content/"published").text)
        data[:published_at] = at.advance(:hours => 9)
                                         
        author = (content/"author/name").text
        user_name = author.split(' ')

        data[:entry] = entry
        data[:screen_name]  = user_name.first
        #data[:user_name] = user_name[1..-1].to_s.gsub(/[\(\)]/,'')
        data[:source]   = (content/"source").text

        data[:image_url] = (content/"link")[1]["href"]

        s = find_or_initialize_by_status_id(data[:status_id])
        next unless s.new_record?
        s.status_id = data[:status_id]
        #s.status_user_id = nil
        s.published_at = data[:published_at]
        s.screen_name = data[:screen_name]
        s.via = data[:image_url]
        s.source = data[:source]
        s.entry = data[:entry]
        s.save

      end
      sleep 1
    end
  end

  def self.track
    params = {'track' => ok.join(",")}
    stream(params) do |status|
      next unless status['text']
      user = status['user']
      s = find_or_initialize_by_status_id(status['id'])
      next unless s.new_record?
      params = {
        :screen_name => user['screen_name'],
        :source => status['source'],
        :status_id => status['id'],
        :entry => status['text'],
        :published_at => status['created_at']
      }
      s.attributes = params
      s.save
    end
  end

  def self.filter
  end

  private
  def self.oauth_consumer
    OAuth::Consumer.new(OAUTHTOKEN, OAUTHSECRET, :site => "http://twitter.com")
  end

  def self.oauth_access
    OAuth::Token.new(ACCESSTOKEN, ACCESSSECRET)
  end

  def self.stream(params)
    consumer = self.oauth_consumer
    access = self.oauth_access
    uri = URI.parse(STREAM_URL) #filter
    http = Net::HTTP.start(uri.host, uri.port)
    request = Net::HTTP::Post.new(uri.request_uri)
    request.set_form_data(params)
    request.oauth!(http, consumer, access)

    begin
      http.request(request) do |response|
        response.each_line("\r\n") do |line|
          status = JSON.parse(line) rescue next
          yield status
        end
      end
    ensure
      logger.debug "ensuer"
      http.finish
    end
  end

  def self.ok
    FILTER_KEYWORD['ok']
  end

  def self.ng
    FILTER_KEYWORD['ng']
  end

end
