namespace :import do
  class LegacyComment < SkiWorld
    set_table_name 'Msg'
    set_primary_key 'Id'

    def self.get_by_topic topic_id, nested=0
      arr = []

      #puts "#{ '>' * nested } Getting comment thread #{topic_id}, nested: #{nested}"

      if nested>10
        puts "Too big loop"
        puts arr
        return arr
      end

      return arr unless topic_id.present?
      items = where("HostNode = #{topic_id}")
      items.each do |item|
        #puts "#{item.Type} #{item.Title} #{item.Content}"
        arr.push item unless item.Type == 'dir'
        arr.concat get_by_topic(item.Id, nested+1)
      end
      arr
    end

  end
end
