require "high_level_browse/version"
require 'high_level_browse/db'
require 'high_level_browse/errors'
require 'httpclient'
require 'stringio'



module HighLevelBrowse

  SOURCE_URL = ENV['HLB_XML_ENDPOINT'] || 'https://www.lib.umich.edu/browse/categories/xml.php'

  # Fetch (and optionally store) a new version of the file
  def self.fetch
    res = HTTPClient.get(SOURCE_URL, :follow_redirect => false)
    raise "Could not fetch xml from '#{SOURCE_URL}' (status code #{res.status})" unless res.status == 200

    return DB.new_from_raw(res.content)
  end


  def self.fetch_and_save(dir='.')
    self.fetch.save(dir)
  end

  # Load from disk
  def self.load(dir='.')
    DB.load(dir)
  end


end
