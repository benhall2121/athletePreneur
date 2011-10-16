class FriendshipsController < ApplicationController
  def create
  	  puts 'create'
    @friendship = current_user.friendships.build(:friend_id => params[:friend_id])
    if @friendship.save
      flash[:notice] = "Added friend."
      redirect_to root_url
    else
      flash[:error] = "Unable to add friend."
      redirect_to root_url
    end
  end

  def destroy	  
    
    if params[:friend_id]
      @ff = current_user.friendships.find_by_friend_id(params[:friend_id])	  	  
    else  
      @ff = Friendship.find(params[:id])
    end
    
    if @ff.user_id == current_user.id 
      fid = @ff.friend_id  
      cid = @ff.user_id
    elsif @ff.friend_id == current_user.id
      fid = @ff.user_id
      cid = @ff.friend_id
    else
      flash[:notice] = "You do not have sufficient privileges."
      redirect_to show_user_path(current_user.id)
    end
    
    @friendship = Friendship.find(:first, :conditions => ['(user_id = ? AND friend_id = ?)', cid, fid])
    @friendship2 = Friendship.find(:first, :conditions => ['(user_id = ? AND friend_id = ?)', fid, cid])
    
    @friendship.destroy if !@friendship.nil?
    @friendship2.destroy if !@friendship2.nil?
    
    flash[:notice] = "Removed friendship."
    redirect_to show_user_path(current_user.id)
  end
end
