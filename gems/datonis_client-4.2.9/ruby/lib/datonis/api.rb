module Datonis
  class ApiBase
    attr_accessor :site, :prefix

    def initialize(site='https://api.datonis.io', prefix='/api/v3')
      @site = site
      @prefix = prefix
    end

    def method_missing(sym, *args, &block)
      identify_standard_apis(sym, *args, &block)
    end

    def load_configuration(type)
      map = connection.get('/licenses/configuration', {:configuration_type => type})
    end

    def generic_get(url, args)
      connection.get_raw(url, args)
    end

    def generic_post(url, args)
      connection.post_raw(url, args)
    end

    def generic_put(url, args)
      connection.put_raw(url, args)
    end

    def generic_delete(url, args)
      connection.delete_raw(url, args)
    end

    def generic_download(url, args)
      connection.get_octet_stream(url, args)
    end

    def headers()
      {}
    end

    def valid?
      false
    end

    private

    def connection
      ssl = true
      ssl = false unless @site.starts_with?("https://")
      Connection.new(@site, @prefix, headers, ssl)
    end

    def execute_instance_method(sym, instance, *args)
      instance.send(sym, connection, args)
    end

    def execute_class_method(klass, method, *args)
       klass.send(method, connection, *args)
    end

    def klass_of(sym)
      klass_name = 'Datonis::' + sym.to_s.split("_")[1..-1].collect {|x| x.camelize}.join("").singularize
      klass = eval(klass_name)
    end

    def identify_standard_apis(sym, *args, &block)
      case sym.to_s.split('_').first
      when 'get'
        execute_class_method(klass_of(sym), 'read', *args)
      when 'all'
        execute_class_method(klass_of(sym), 'list', *args)
      when 'create'
        execute_class_method(klass_of(sym), 'create', *args)
      when 'save', 'tag', 'untag', 'destroy'
        execute_instance_method(sym, args[0])
      else
        identify_special_apis(sym, *args, &block)
      end
    end

    def identify_special_apis(sym, *args, &block)
      case sym.to_s
      when 'group_sensors'
        execute_instance_method(sym, *args)
      when 'change_password'
        execute_instance_method(sym, *args)
      when *Datonis::Thing::APISET
        execute_instance_method(sym,*args)
      when *Datonis::Things::APISET
        execute_class_method(Datonis::Things, sym, *args)
      when *Datonis::AnalyticsEngine::APISET
        execute_instance_method(sym,*args)
      when *Datonis::DatonisFile::APISET
        execute_class_method(Datonis::DatonisFile, sym, *args)
      when *Datonis::AnalyticsEngineTask::APISET
        execute_instance_method(sym,*args)
      when 'execute_instruction'
        execute_instance_method(sym,*args)
      when 'download_debug_log'
        execute_instance_method(sym,*args)
      when *Datonis::Alert::APISET
        execute_class_method(Datonis::Alert, sym, *args)
      when *Datonis::Organisation::APISET
        execute_class_method(Datonis::Organisation, sym, *args)
      when *Datonis::DatonisQuery::APISET
        execute_class_method(Datonis::DatonisQuery, sym, *args)
      when *Datonis::License::APISET
        execute_class_method(Datonis::License, sym, *args)
      when *Datonis::User::APISET
        execute_class_method(Datonis::User, sym, *args)
      else
        raise NoMethodError, "undefined method #{sym.to_s}"
      end
    end
  end

  class Api < ApiBase
    attr_accessor :site, :user, :prefix, :auth_token

    def initialize(email=nil, password=nil, organisation_key=nil,version="v1", site="http://api.datonis.io", oauth_details=nil)
      super(site, "/api/#{version}")
      if email.present? && password.present?
        @email = email
        @password = password
        @user = sign_in(@email,@password,organisation_key)
        @auth_token = @user.auth_token
      elsif oauth_details.present?
        @user = oauth_sign_in(oauth_details[:client_id], oauth_details[:code], oauth_details[:oauth_type])
        @email = @user.email
        @auth_token = @user.auth_token
      end
    end

    def sso_login(api_response, organisation_key = nil, version="v1", site="http://api.datonis.io")
      @email = api_response['email']
      @site = site
      @prefix = "/api/#{version}"
      @auth_token = api_response['auth_token']
      @user = Datonis::User.new(api_response)
    end

    def headers
      { 'X-Auth-Token' => @auth_token }
    end

    def valid?
      !@auth_token.nil?
    end

    def sign_in(email, password, organisation_key = nil)
      retval = nil
      map = {email: email, password: password}
      map.merge!({organisation_key: organisation_key}) if organisation_key.present?
      retmap = connection.login('/api_sign_in', map)
      return Datonis::User.new(retmap)
    end

    def oauth_sign_in(client_id, code, oauth_type)
      retval = nil
      map = {:oauth_type => oauth_type, :code => code, :client_id => client_id}
      retmap = connection.login('/oauth_api_sign_in', map)
      return Datonis::User.new(retmap)
    end

    def reload_user
      map = {email: @email, password: @password}
      retmap = connection.login('/api_sign_in', map)
      @user = Datonis::User.new(retmap)
      @auth_token = @user.auth_token
    end
  end

  class KeyBasedApi < ApiBase
    attr_accessor :access_key

    def initialize(access_key = nil, version="v1", site="http://api.datonis.io")
      super(site, "/api/#{version}")
      @access_key = access_key
    end

    def headers
      { 'X-Access-Key' => @access_key}
    end

    def valid?
      @access_key.present?
    end
  end
end
