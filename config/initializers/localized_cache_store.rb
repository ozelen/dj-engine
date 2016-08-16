class LocalizedCacheStore < ActiveSupport::Cache::MemoryStore
  def namespaced_key(key, options)
    "#{I18n.locale}:#{super}"
  end
end