class CommentsController < ApplicationController
  def index
  end

  def show
  end

  def create
    cl = Object.const_get params[:commentable_type]
    commentable = cl.find params[:commentable_id]
    if commentable
      @comment = Comment.new( commentable: commentable, user_id: current_user.id, body: params[:comment]['body'], title: params[:comment]['title'] )
      respond_to do |format|
        if @comment.save
          format.js
        else
          format.js { render js: 'alert("Something went wrong")' }
        end
      end
    end
  end

  def update
  end

  def destroy
  end
end
