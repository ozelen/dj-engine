namespace :import do
  ### Classification

  class ClassLink < SkiWorld
    set_table_name 'ClassLinks'
    def key
      SwPage.find(self.ClassKey) rescue nil
    end
    def value
      SwPage.find(self.ClassValue) rescue nil
    end
    def name
      self.value.data.title('ru') || 'noname'
    end
  end

  ###
end