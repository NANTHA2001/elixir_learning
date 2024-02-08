defmodule Mycomponent do
   use Phoenix.Component

  attr :title, :string, required: true

  def heading(assigns) do
    ~H"""
    <h1 class="text-2xl"><%= @title %></h1>
    """
  end



  attr :name, :string, default: "Nantha"
  # attr :email, :string, default: "nanthakumarg2001@gmail.com"

   def greet(assigns) do
    ~H"""
    <p>Hello, <%= @name %> create your post</p>
    """
   end


  attr :message, :string, default: "nanthakumarg2001@gmail.com"
  attr :rest, :global, default: %{class: "bg-blue-200"}

    def notification(assigns) do
      ~H"""
      <span {@rest}><%= @message %></span>
      """
    end


    slot :inner_block, required: true

    attr :entries, :list, default: []

    def unordered_list(assigns) do
      ~H"""
      <ul>
        <%= for entry <- @entries do %>
          <li><%= render_slot(@inner_block, entry) %></li>
        <% end %>
      </ul>
      """
    end
end
