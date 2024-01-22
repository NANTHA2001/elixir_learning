defmodule LiveViewStudioWeb.Posts do
  alias LiveViewStudio.Repo
  alias LiveViewStudio.Posts.Post
  def save(post_params) do
    %Post{}
    |> Post.changeset(post_params)
    |> IO.inspect()
    |> Repo.insert()
  end
end
