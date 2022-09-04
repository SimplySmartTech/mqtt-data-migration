module Datonis
	class User < Base

    attr_accessor :email, :role, :organisation, :auth_token, :time_zone, :user_key,:sign_in_count, :first_name, :last_name, :address, :city, :country, :phone, :datonis_role_key, :datonis_role
    APISET = ['invite']
    @@urlname='users'
    
    class << self
      def urlname
        @@urlname
      end
    end

		def initialize(attrs)
			super
			@organisation = Datonis::Organisation.new(@organisation) unless @organisation.nil?
		  if @datonis_role.present?
        permissions = {}
        @datonis_role["permissions"].each do |p|
          lookup_str = p["class"]
          lookup_str = lookup_str + '.' + p["operation"] if !p["operation"].nil?
          permissions.merge!({lookup_str => true})
        end
        @datonis_role["permissions"] = permissions
			end
		end

    def attributes=(args)
      self.first_name = args[:first_name]
      self.last_name = args[:last_name]
      self.address = args[:address]
      self.city = args[:city]
      self.phone = args[:phone]
      self.country = args[:country]
      self.email = args[:email]
      self.datonis_role_key = args[:datonis_role_key]
    end

    def can?(clazz, operation=nil)
      if @datonis_role["permissions"].try(:[],"datonis_admin") or @datonis_role["permissions"].try(:[],"account_admin")
        return true
      end   
      if operation.nil?
        if @datonis_role["permissions"].try(:[],clazz)
          return true
        end  
        return false
      end  
      look_up = clazz+"."+operation if !clazz.nil?
      @datonis_role["permissions"].try(:[],look_up) || false
    end

    def key
      @user_key
    end

    def has_analytics_engine?
      @datonis_role['has_analytics_engines']
    end

    def datonis_admin?
      @datonis_role['datonis_admin']
    end

    def account_admin?
      @datonis_role["account_admin"]
    end

		def super_admin?
      role == 'super_admin'
    end

    def admin?
      role == 'admin'
    end

    def normal_user?
      role == 'normal'
    end

    def self.invite(connection, params)
      connection.post(custom_collection_url('invite'), params)
    end

    def change_password(connection, params)
      if params.kind_of? (Array)
        query = {user: {password: params[0]}}
      else
        query = {user: {password: params}}
      end
      response = connection.put("/users/#{self.key}/change_password", query, nil)
      if response.keys.include?('errors')
        self.errors = response['errors']
        return false
      else
        return true
      end
    end

	end
end