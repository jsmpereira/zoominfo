require 'httparty'

module ZoomInfo
  
  class Base
    include HTTParty
    base_uri "http://api.zoominfo.com/PartnerAPI/XmlOutput.aspx?"
    format :xml
    
    def initialize(apikey = nil)
      key = apikey ||= ENV['ZOOMINFO_API_KEY']
      raise ArgumentError, 'You must provide an API Key' if key.blank?
      self.class.default_params :pc => key
    end
  end
  
  class Company < ZoomInfo::Base
    
    # Returns search result of companies based on input criteria.
    # Available search inputs and returned output is restricted by access rights for public accounts.
    #
    # See: http://developer.zoominfo.com/documentation#5.1
    #
    def search(options = {})
      options.merge!({:query_type => 'company_search_query'})
      self.class.get("/", :query => options)
    end
    
    # Returns a wide array of company specific information for each company unique identifier passed.
    # Data returned is limited to access rights set for public accounts.
    #
    # See: http://developer.zoominfo.com/documentation#5.2
    #
    def detail(options = {})
      options.merge!({:query_type => 'company_detail'})
      self.class.get("/", :query => options)
    end
    
    # Returns a list of competitor companies for each company unique identifier passed.
    #
    # See: http://developer.zoominfo.com/documentation#5.3
    #
    def competitors(options = {})
      options.merge!({:query_type => 'company_competitors'})
      self.class.get("/", :query => options)
    end
  end
  
  class People < ZoomInfo::Base
    
    # Returns search result of people based on criteria of various search inputs.
    #
    # See: http://developer.zoominfo.com/documentation#4.1
    #
    def search(options = {})
      options.merge!({:query_type => 'people_search_query'})
      self.class.get("/", :query => options)
    end
    
  end
end