use Mix.Config

config :libsniffle, sniffle: :mdns

config :mingus_docker, listen: [
  {{:local, "/var/run/mingus_docker.sock"}, 0}
]

