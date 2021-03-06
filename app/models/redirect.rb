class Redirect < ActiveRecord::Base
  attr_accessible :new_path, :old_domain, :old_path

  def self.find_by_uri(request)
    locale_reg = /^\/(ru|ua)/   # possible locales in legacy data
    old_path = request.fullpath.gsub(locale_reg, '')
    old_path = old_path == '' ? '/' : old_path
    redirect = Redirect.where(old_path: old_path, old_domain: request.host)[0] # looking for existing redirect on the path in DB (locale should be undefined!)
    locale = locale_reg.match(request.fullpath).to_s.gsub('ua', 'uk') # find out the locale and substitute ua with uk identifier
    locale = '' if locale == '/ru' # no specified locale if default
    "http://skiworld.org.ua#{locale}#{redirect.new_path}" if redirect

  end

end
