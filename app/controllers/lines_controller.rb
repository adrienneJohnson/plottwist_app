class LinesController <ApplicationController
  
  def index
    @story = Story.find(params[:story_id])
    @lines = @story.lines.all
  end

  def new
    @line = Line.new
  end

  def create
    @user = current_user
    @story = Story.find(params[:story_id])
    @line = @story.lines.build(line_params)
    if @line.save
      redirect_to user_path(@user)
    end
  end
end
  
private

def line_params
  params.require(:line).permit(:body, :user_id, :story_id)
end
