class QuestionsController < ApplicationController
  
  before_action :search
  
  def search
    @q = Question.ransack(params[:q])
    # No Ransack::Search object was provided to search_form_for!という
    # ArgumentErrorが出るので分けてbefore_actionに指定
  end
    
  
  def index
    @questions = @q.result(distinct: true)
  end
  
  def solved
    @questions = Question.where(solved: true)
    render :index
  end
  
  def unsolved
    @questions = Question.where(solved: false)
    render :index
  end
  
  def show
    @question = Question.find(params[:id])
  end
  
  def new
    @question = Question.new
  end
  
  def create
    @question = current_user.questions.build(question_params)
    # newでもいいけどアソシエーションある時は慣習的にbuildを使う
    if @question.save
      redirect_to question_path(@question), success: '質問を作成しました'
        # flash[:success] = '質問を作成しました'　でも良い。
        # redirect_toの第二引数にできるflashのキーはデフォルトで決められているので
        # application_controllerにadd_flash_types :success, :info, :warning, :dangerを追加
        # successを使えるようにした
    else
      flash.now[:danger] = '失敗しました'
      render :new
    end
  end
  
  def edit
    @question = current_user.questions.find(params[:id])
    # current_userから引っ張らないと直接リンクを打てば誰でも編集できる
  end
  
  def update
    @question = current_user.questions.find(params[:id])
    if @question.update(question_params)
      redirect_to question_path(@question), success: '質問を更新しました'
    else
      flash.now[:danger] = '失敗しました'
      render :edit
    end
  end
  
  def destroy
    @question = current_user.questions.find(params[:id])
    @question.destroy!
    redirect_to questions_path
  end
  
  def solve 
    @question = current_user.questions.find(params[:id])
    @question.update!(solved: true)
    redirect_to question_path(@question), success: '解決済みにしました'
  end
  
  private
    def question_params
      params.require(:question).permit(:title, :body)
    end
  
end