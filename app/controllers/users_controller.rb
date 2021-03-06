class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
    redirect_to root_url, alert: 'Вы уже залогинены' if current_user.present?
    @user = User.new
  end

  def create
    redirect_to root_url, alert: 'Вы уже залогинены' if current_user.present?
    @user = User.new(user_params)

    if @user.save
      redirect_to root_url, notice: 'Пользователь успешно зарегестрирован!'
    else
      render 'new'
    end
  end

  def edit

  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: 'Данные обновлены'
    else
      render 'edit'
    end
  end

  # def show
  #   @questions = @user.questions.order(created_at: :desc)

  #   @new_question = @user.questions.build
  # end
  def show
    @user = User.find params[:id]
    @questions = @user.questions.order(created_at: :desc)

    @new_question = @user.questions.build
  end

  private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation,
                                 :name, :username, :avatar_url)
  end
end
