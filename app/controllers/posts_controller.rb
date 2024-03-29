class PostsController < ApplicationController
  before_filter :is_admin, :except => [:index, :show, :main_search]	
	
	
  # GET /posts
  # GET /posts.xml
  def index
    @posts = Post.find(:all, :order => 'created_at desc', :limit => 2)
    
    @posts.map do |a|
    	    icons = a.content.match(/\<img.*\/\>/).to_s.gsub(/\/content_/, '/large_icon_').gsub(/style=".*"/, '')
    	    a.content = a.content.gsub(/\<img.*\/\>/,'')
    	    a.content = html_truncate(a.content, 200)
    	    a.icon = icons
    end
    
    @companies = User.find(:all, :conditions => ['account_type LIKE ?', 'company'], :order => 'created_at desc') 

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.xml
  def show
    @post = Post.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.xml
  def new
    @post = Post.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
  end

  # POST /posts
  # POST /posts.xml
  def create
    @post = Post.new(params[:post])
    @post.user_id = current_user.id
    
    respond_to do |format|
      if @post.save
        format.html { redirect_to(@post, :notice => 'Post was successfully created.') }
        format.xml  { render :xml => @post, :status => :created, :location => @post }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.xml
  def update
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to(@post, :notice => 'Post was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.xml
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to(posts_url) }
      format.xml  { head :ok }
    end
  end
  
  def main_search
    @search = User.search(params[:search], params[:type]) #.order(sort_column + " " + sort_direction).paginate(:per_page => 5, :page => params[:page])	 
  end
  
end
