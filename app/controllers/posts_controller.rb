class PostsController < ApplicationController
  # GET /posts
  # GET /posts.json
  def index
    @posts = params[:stream] ? Stream.find_by_slug(params[:stream]).posts : Post.all

    respond_to do |format|
      format.html { render layout: 'stream' if params[:stream] }
      format.json { render json: @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    id = params[:id] || params[:post_id]
    @post = Post.find(id)

    if @post.channel
      layout = @post.channel_type.parameterize
      instance_variable_set "@#{layout}", @post.channel
      render layout: layout
      #render template: layout.pluralize + '/show_post'
    else
      respond_to do |format|
        format.html { render layout: 'stream' if params[:stream] }
        format.json { render json: @post }
        format.js
      end
    end
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    @post = Post.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
    respond_to do |format|
      format.html
      format.js
    end
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = find_channel.posts.new(params[:post])
    @post.to_markdown! if params[:to_markdown]

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render json: @post, status: :created, location: @post }
        format.js
      else
        format.html { render action: "new" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
        format.js   { render text: 'Sucks! :(' }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    @post = Post.find(params[:id])
    @post.to_markdown! if params[:to_markdown]

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { head :no_content }
        format.js
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :no_content }
      format.js
    end
  end

  private

  def find_channel
    klass = params[:channel_type].constantize
    klass.find params[:channel_id]
  end

end
