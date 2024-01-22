defmodule LiveViewStudioWeb.LightLive do
  use LiveViewStudioWeb, :live_view

  # alias LiveViewStudio.Posts
  alias LiveViewStudio.Posts.Post

  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket), do: :timer.send_interval(1000, self(), :tick)
    form =
      %Post{}#instance of post
      |> Post.changeset(%{}) #changeset the post struct for data store in database
      |> to_form(as: "post") #to_form is custom function transforms the changeset into a form

    socket =
      socket
    |> assign(form: form)
    |> allow_upload(:image, accept: ~w(.png .jpg), max_entries: 1)
    |> assign(date: :calendar.local_time())
    {:ok, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <h1 class="text-2xl text-red-500"> home </h1>

    <.button type="submit" phx-click={show_modal("new_post_modal")}>Create post</.button>
    <.modal id="new_post_modal">
    <.simple_form for={@form} phx-change="validate" phx-submit="save-post">
      <.live_file_input upload ={@uploads.image} required />
      <.input field={@form[:caption]} type="text" label="caption" required/>
      <.button type="submit" phx-disabled-with="Saving..." > Create Post </.button>
    </.simple_form>
    </.modal>

    """
  end

  @impl true
  def handle_event("validate", _params, socket)do
    {:noreply, socket}
  end


  @impl true
  def handle_event("save-post", %{"post" => post_params}, socket) do
    IO.inspect(post_params, label: "Received params in save_post")
    %{current_user: user} = socket.assigns

    case consume_files(socket) do
      {:noreply, updated_socket} ->
        # Extract the image_path from the updated socket
        image_path = Map.get(updated_socket.assigns, :uploaded_files, nil)
        IO.inspect(image_path, label: "Path before join iamage_path")
        post_params =
          post_params
          |> Map.put("user_id", user.id)
          |> Map.put("image_path", image_path)
          IO.inspect(post_params, label: "post_params")


          case LiveViewStudioWeb.Posts.save(post_params) do
            {:ok, _post} ->
              updated_socket
              |> put_flash(:info, "Post created successfully")
              |> push_navigate(to: ~p"/light/")
              {:noreply, updated_socket}
            {:error, changeset} ->
              IO.inspect(changeset.errors, label: "Changeset errors")
              updated_socket
              |> put_flash(:error, "Error creating post")
              {:noreply, updated_socket}
          end

      _ ->
        # Handle other cases as needed
        {:noreply, socket}
    end
  end


  @impl true
  def handle_info(:tick, socket) do
    {:noreply, assign(socket, date: :calendar.local_time())}
  end

  defp consume_files(socket) do
    uploaded_files = consume_uploaded_entries(socket, :image, fn %{path: path}, _entry ->
      IO.inspect(path, label: "Path before join")
      priv_dir = Application.app_dir(:live_view_studio, "priv")
      IO.inspect(priv_dir, label: "Priv dir")
      dest = Path.join([priv_dir, "static", "uploads", Path.basename(path)])
      IO.inspect(dest, label: "Final destination")
      File.cp!(path, dest)

      {:ok, ~s(/uploads/#{Path.basename(dest)})}
    end)
    {:noreply, assign(socket, uploaded_files: uploaded_files)}
  end


end
