resource "exoscale_nlb" "my_nlb" {
  zone = "ch-gva-2"
  name = "my-nlb"
}

resource "exoscale_nlb_service" "my_nlb_service_1" {
  nlb_id = exoscale_nlb.my_nlb.id
  zone   = exoscale_nlb.my_nlb.zone
  name   = "my-nlb-service-1"

  instance_pool_id = exoscale_instance_pool.my_instance_pool.id
  protocol         = "tcp"
  port             = 80
  target_port      = 8080
  strategy         = "round-robin"

  healthcheck {
    mode     = "https"
    port     = 8080
    uri      = "/healthz"
    tls_sni  = "example.net"
    interval = 5
    timeout  = 3
    retries  = 1
  }
}
resource "exoscale_nlb_service" "my_nlb_service_2" {
  nlb_id = exoscale_nlb.my_nlb.id
  zone   = exoscale_nlb.my_nlb.zone
  name   = "my-nlb-service-2"

  instance_pool_id = exoscale_instance_pool.my_instance_pool.id
  protocol         = "tcp"
  port             = 443
  target_port      = 8443
  strategy         = "round-robin"

  healthcheck {
    mode     = "https"
    port     = 8443
    uri      = "/healthz"
    tls_sni  = "example.net"
    interval = 5
    timeout  = 3
    retries  = 1
  }
}
