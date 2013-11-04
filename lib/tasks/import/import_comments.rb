namespace :import do
  def import_comments(topic, new_object)
    puts "Getting comments of thread #{topic}"
    comments = LegacyComment.get_by_topic(topic)
    puts "Importing comments (#{comments.count})"
    comments.each do |comment|
      puts "#{comment.Title}\n#{comment.Content}\n---"
      user = nil
      commenter_email   = comment.Email
      commenter_name    = comment.Username
      commenter_email ||= find_email(comment.Content)[0] rescue nil
      commenter_name  ||= username_from_email(commenter_email) rescue nil
      if commenter_email.present?
        user   = User.find_by_email(commenter_email)
        user ||= User.new(email: commenter_email, username: commenter_name)
        if user.valid?
          user.save
        else
          user = nil
        end
      end
      user_id = user.present? ? user.id : nil
      puts "commenter: #{commenter_name} user: #{user_id} email: #{commenter_email}"
      new_comment = Comment.new( commentable: new_object, title: comment.Title, body: comment.Content, created_at: comment.Created)

      if user.present?
        new_comment.user_id = user.id
      elsif commenter_name.present?
        new_comment.username = commenter_name
      else
        new_comment.username = 'Anonymous'
      end

      new_comment.save if new_comment.valid?

    end
  end
end