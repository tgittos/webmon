class AddSchemeToExistingUrls < ActiveRecord::Migration
  def change
    sites = connection.execute "select * from sites"
    sites.each do |site|
      if site["url"] !~ /https?:\/\//
        connection.execute "update sites set url = 'http://#{site["url"]}' where id = #{site["id"]}"
      end
    end
  end
end
