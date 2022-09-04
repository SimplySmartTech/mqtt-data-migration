require "net/http"
require "net/https"
require "uri"
require "json"
require 'net/http/post/multipart'

module Datonis
class Connection
  
    attr_accessor :site, :headers, :logger, :prefix

    def initialize(site, prefix, headers, ssl=true)
      @site = URI.parse(site)
      @prefix = prefix
      @headers = headers
      @ssl = ssl
      @logger = Rails.logger rescue Logger.new(STDOUT)
      @http = set_connection
    end
    
    def set_connection()
      http = Net::HTTP.new(@site.host, @site.port)
      if @ssl
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      end
      return http
    end
    
    def request(request)
      logger.info '--- ' + request.method.upcase + ' ' + request.path
      @http.request(request)
    end

    def login(url, body)
      r = Net::HTTP::Post.new(url)
      r.body = JSON.dump(body)
      r.set_content_type "application/json" 
      handle_response(request(r))
    end

    def post(url, body, options ={})
      r = Net::HTTP::Post.new(prefix_url(url), headers)
      r.body = JSON.dump(body)
      r.set_content_type "application/json" 
      handle_response(request(r))
    end

    def put(url, body, options ={})
      r = Net::HTTP::Put.new(prefix_url(url), headers)
      r.body = JSON.dump(body)
      r.set_content_type "application/json" 
      handle_response(request(r))
    end

    def get(url, body, options={})
      r = Net::HTTP::Get.new(prefix_url(url), headers)
      r.body = JSON.dump(body)
      r.set_content_type "application/json" 
      handle_response(request(r))
    end

    def get_raw(url, body, options = {})
      r = Net::HTTP::Get.new(prefix_url(url), headers)
      r.body = JSON.dump(body)
      r.set_content_type "application/json" 
      response = request(r)
      return { code: response.code.to_i, body: JSON.parse(response.body, quirks_mode: true)}
    end

    def post_raw(url, body, options = {})
      r = Net::HTTP::Post.new(prefix_url(url), headers)
      r.body = JSON.dump(body)
      r.set_content_type "application/json" 
      response = request(r)
      return { code: response.code.to_i, body: JSON.parse(response.body, quirks_mode: true)}
    end

    def put_raw(url, body, options ={})
      r = Net::HTTP::Put.new(prefix_url(url), headers)
      r.body = JSON.dump(body)
      r.set_content_type "application/json"
      response = request(r)
      return { code: response.code.to_i, body: JSON.parse(response.body, quirks_mode: true)}
    end

    def delete_raw(url, body, options = {})
      r = Net::HTTP::Delete.new(prefix_url(url), headers)
      r.body = JSON.dump(body)
      r.set_content_type "application/json"
      response = request(r)
      return { code: response.code.to_i, body: JSON.parse(response.body, quirks_mode: true)}
    end

    def get_octet_stream(url, body, options={})
      r = Net::HTTP::Get.new(prefix_url(url), headers)
      r.body = JSON.dump(body)
      r.set_content_type "application/json"
      response = request(r)
      return response.body
    end

    def delete(url, body, options={})
      r = Net::HTTP::Delete.new(prefix_url(url), headers)
      r.body = JSON.dump(body)
      r.set_content_type "application/json"
      handle_response(request(r))
    end


    def start(url, body, options ={})
      Rails.logger.info "\n body #{body.inspect}"
      url = prefix_url(url) + '.html'
      headers
      tempfile = "#{body.payload.tempfile.path}"
     req = Net::HTTP::Post::Multipart.new url,
        "payload" => UploadIO.new(File.new(tempfile), "#{body.payload.content_type}", "#{body.payload.original_filename}") ,
        "name" => "#{body.name}",
        "driver_class" => "#{body.driver_class}",
        "description" => "#{body.description}",
        "type" => "#{body.type}"
      req['X-Auth-Token']  = headers['X-Auth-Token']
      res = Net::HTTP.start((@site+'.html').host, @site.port) do |http|
        handle_response(http.request(req))
      end
    end
    
    def start_update(url, body, options ={})
      Rails.logger.info "\n body #{body.inspect}"
      url = prefix_url(url) + '.html'
      headers
      tempfile = "#{body.payload.tempfile.path}"
     req = Net::HTTP::Put::Multipart.new url,
        "payload" => UploadIO.new(File.new(tempfile), "#{body.payload.content_type}", "#{body.payload.original_filename}") ,
        "name" => "#{body.name}",
        "driver_class" => "#{body.driver_class}",
        "description" => "#{body.description}",
        "type" => "#{body.type}",
        "datonis_file_key" => "#{body.datonis_file_key}"
      req['X-Auth-Token']  = headers['X-Auth-Token']
      res = Net::HTTP.start((@site+'.html').host, @site.port) do |http|
        handle_response(http.request(req))
      end
    end

    private

    def handle_response(response)
      case response.code
      when '200'
        if response.content_type == "application/octet-stream"
          return response.body
        else
          decode(response.body)
        end
      when '404'
        logger.info '!'*100
        logger.info response.code
        logger.info response.body
        res, errors = parse_errors(response.body)
        e = DatonisException::NotFoundError.new(res)
        e.errors = errors
        raise e
      when '401'
        logger.info response.code
        logger.info response.body
        res, errors = parse_errors(response.body)
        e = DatonisException::SessionExpired.new(res)
        e.errors = errors
        raise e
      when '400'
        logger.info '!'*100
        logger.info response.code
        logger.info response.body
        res, errors = parse_errors(response.body)
        e = DatonisException::BadRequestError.new(res)
        e.errors = errors
        raise e
      when '403'
        logger.info '!'*100
        logger.info response.code
        logger.info response.body
        res, errors = parse_errors(response.body)
        e = DatonisException::NoAccess.new(res)
        e.errors = errors
        raise e
      when '500'
        logger.info '!'*100
        logger.info response.code
        logger.info response.body
        raise DatonisException::ServerError, "Internal server error. Please contact Altizon support."
      else
      end
    end

    def decode(body)
      res = JSON.parse(body, quirks_mode: true)
      
      if res["warnings"].present?
        warnings = res["warnings"] 
        warning_string = ""
        warnings.each do |w|
          warning_string += w["code"] + ": " + w["message"]  + "\n";      
        end
        result = {}
        result.merge!({res.first[0] => res.first[1]})
        result.merge!({"warnings" => warning_string.truncate(200, :separator => ')')})
        #puts "result: #{result.inspect}"
      end
      
      if result.nil?
        return res
      end  
      result
    end

    def prefix_url(url)
      "#{prefix}#{url}"
    end
    
    def parse_errors(response_body)
      res = JSON.parse response_body
      err_string = ""
      
      if res['errors'].present?
        res["errors"].each do |e|
          err_string += e["code"] + ": " + e["message"] + "\n";      
        end
      elsif res['message'].present?
        err_string = res['message']
      else
        err_string = response_body
      end
      
      return err_string.truncate(200, :separator => ')'), res['errors']
    end
    
end
end
