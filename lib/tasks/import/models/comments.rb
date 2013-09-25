namespace :import do
  class LegacyComment < SkiWorld
    set_table_name 'Msg'
    set_primary_key 'Id'

    def self.get_by_topic topic_id
      arr = []
      return arr unless topic_id.present?
      items = where("HostNode = #{topic_id}")
      items.each do |item|
        arr.push item unless item.Type == 'dir'
        arr.concat get_by_topic(item.Id)
      end
      arr
    end

  end
end
