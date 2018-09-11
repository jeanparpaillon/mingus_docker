use Mix.Config

config :libsniffle, sniffle: {'10.1.1.240', 4210}

config :mingus_docker, listen: [
  {{:local, "/tmp/mingus_docker.sock"}, 0}
]
