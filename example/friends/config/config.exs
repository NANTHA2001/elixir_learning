import Config

config :friends, Friends.Repo,

  database: "friend_repo",
  username: "postgres",
  password: "GNanthu$2001",
  hostname: "localhost"

config :friends, ecto_repos: [Friends.Repo]

