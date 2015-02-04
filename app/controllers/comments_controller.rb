class CommentsController < ApplicationController
	#before_action :load_commentable
  def index
=begin
  	@comments = @commentable.comments
    if @comments
      respond_to do |format|
        format.js { render @comments, status: :ok }
      end
    end
=end
  end

  def new
  	@comment = @commentable.comments.new
  end

  def create
  	user = User.find(params[:user_id])
    sp = Serviceprovider.find(params[:sp])

    if user.comments.create(commentor: params[:commentor], content: params[:comment], serviceprovider: sp)
      response = { notice: 'Comment Created' }
      respond_to do |format|
        format.js { render json: response, status: :created }
      end
    end

  end

  def all
     sp = Serviceprovider.find(params[:sp])
    if sp
      comments = sp.comments
      respond_to do |format|
        format.js { render json: comments, status: :ok }
      end
    end
  end

  def vote
    value = params[:type] == "up" ? 1 : -1
    @serviceprovider = Serviceprovider.find(params[:id])
    @serviceprovider.add_update_evaluation(:votes, value, current_user)
    redirect_to user_path(@serviceprovider), notice: "Thank you for voting!"
  end

  private

  def comment_param
  	params.require(:comment).permit(:content)
  end

  def load_commentable
  	resource, id = request.path.split('/')[1,2]
  	resource = "Serviceprovider"
  	@id = id
  	@commentable = resource.singularize.classify.constantize.find(id)
  end
end
