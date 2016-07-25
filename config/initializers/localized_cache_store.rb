class LocalizedCacheStore < ActiveSupport::Cache::FileStore
  def namespaced_key(key, options)
    "#{I18n.locale}:#{super}"
  end
end