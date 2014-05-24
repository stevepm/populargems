module CreateCommentHelper
  def mock_comment(user, popular_gem, body = "this is a comment")
    Comment.create(user: user, popular_gem: popular_gem, body: body)
  end
end