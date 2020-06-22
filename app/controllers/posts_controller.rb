class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @post = Post.new
    timeline_posts
  end

  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      redirect_to posts_path, notice: 'Post was successfully created.'
    else
      timeline_posts
      render :index, alert: 'Post was not created.'
    end
  end

  private

  def timeline_posts
    us = current_user.friends.map(&:id)
    us << current_user.id
    us = us.join(',')
    first_part = "SELECT * FROM posts WHERE user_id IN"
    @timeline_posts = Post.find_by_sql("#{first_part} (SELECT id FROM users WHERE id IN(#{us})) ORDER BY created_at")
  end

  def post_params
    params.require(:post).permit(:content)
  end
end
