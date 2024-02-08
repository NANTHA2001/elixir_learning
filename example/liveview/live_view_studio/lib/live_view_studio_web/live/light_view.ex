defmodule LiveViewStudioWeb.LightLive do
  use LiveViewStudioWeb, :live_view

  alias LiveViewStudioWeb.Posts
  alias LiveViewStudioWeb.Posts.Post

  embed_templates "layouts/*"

  @impl true
  def render(%{loading: true} = assigns) do
    ~H"""
    liveviewstudio is loading ...
    """
  end

  def render(assigns) do
    ~H"""

    <Mycomponent.heading title="Finsta" />


    <Mycomponent.greet />
    <Mycomponent.notification/>

    <.button type="button" phx-click={show_modal("new-post-modal")}>Create Post</.button>



    <div id="feed" phx-update="stream" class="flex flex-col gap-2">
      <div :for={{dom_id, post} <- @streams.posts} id={dom_id} class="w-1/2 mx-auto flex flex-col gap-2 p-4 border rounded">

        <img src={post.image_path} />
        <p class="bg-stone-300 w-1/2"><%= post.user.email %>
        </p>
        <p><%= post.caption %></p>
      </div>
    </div>


    <.modal id="new-post-modal">
      <.simple_form for={@form} phx-change="validate" phx-submit="save-post">

      <div class="container" phx-drop-target={@uploads.image.ref}>
        <.live_file_input upload={@uploads.image} required /></div>
        <.input field={@form[:caption]} type="textarea" label="Caption" phx-debounce="1000" required class=
          "bg-red"/>

          <input type="text" inputmode="numeric" pattern="[0-9]*"/>


        <.button type="submit" phx-disable-with="Saving ...">Create Post</.button>
      </.simple_form>
    </.modal>
    """
  end

  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket) do
      Phoenix.PubSub.subscribe(LiveViewStudio.PubSub, "posts")

      form =
        %Post{}
        |> Post.changeset(%{})
        |> to_form(as: "post")

      socket =
        socket
        |> assign(form: form, loading: false)
        |> allow_upload(:image, accept: ~w(.png .jpg), max_entries: 1)
        |> stream(:posts, Posts.list_posts())

    {:ok, socket}
    else
      {:ok, assign(socket, loading: true)}
    end
  end

  @impl true
  def handle_event("validate", _params, socket) do
    {:noreply, socket}
  end

  def handle_event("save-post", %{"post" => post_params}, socket) do
    %{current_user: user} = socket.assigns

    post_params
    |> Map.put("user_id", user.id)
    |> Map.put("image_path", List.first(consume_files(socket)))
    |> Posts.save()
    |> case do
      {:ok, post} ->
          socket =
            socket
            |> put_flash(:info, "Post created successfully!")
            |> push_navigate(to: ~p"/light")

        Phoenix.PubSub.broadcast(LiveViewStudio.PubSub, "posts", {:new, Map.put(post, :user, user)})

        {:noreply, socket}

      {:error, _changeset} ->
        {:noreply, socket}
    end
  end

  @impl true
  def handle_info({:new, post}, socket) do
    socket =
      socket
      |> put_flash(:info, "#{post.user.email} just posted!")
      |> stream_insert(:posts, post, at: 0)

    {:noreply, socket}
  end

  defp consume_files(socket) do
    consume_uploaded_entries(socket, :image, fn %{path: path}, _entry ->
      dest = Path.join([:code.priv_dir(:live_view_studio), "static", "uploads", Path.basename(path)])
      File.cp!(path, dest)

      {:postpone, ~p"/uploads/#{Path.basename(dest)}"}
    end)
  end




end
