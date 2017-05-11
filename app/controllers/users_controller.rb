class UsersController < ApplicationController
  def index
    @users = [
      User.new(
        id: 1,
        name: 'Vadim',
        username: 'installero',
        avatar_url: 'https://secure.gravatar.com/avatar/' \
          '71269686e0f757ddb4f73614f43ae445?s=100'
      ),
      User.new(id: 2, name: 'Misha', username: 'aristofun')
    ]
  end

  def new
  end

  def edit
  end

  def show
    @user = User.new(
      name: 'Vadim',
      username: 'vadim',
      avatar_url: "data:image/jpeg;base64,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"
    )

    @questions = [
      Question.new(text: 'Как дела?', created_at: Date.parse('27.03.2016')),
      Question.new(text: 'В чем смысл жизни?', created_at: Date.parse('27.03.2016')),
      ]

    @new_question = Question.new
  end
end
