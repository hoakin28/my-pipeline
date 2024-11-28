resource "random_password" "mysql_password" {
  length  = 16
  special = true
}

resource "google_sql_database_instance" "mysql_instance" {
  name             = "myapp-db"
  database_version = "MYSQL_8_0"
  region           = "asia-northeast1"

  settings {
    tier = "db-f1-micro"
  }
}

resource "google_sql_user" "myapp_sql" {
  name     = "myapp_user"
  instance = google_sql_database_instance.mysql_instance.name
  password = random_password.mysql_password.result
}

resource "google_secret_manager_secret" "mysql_config" {
  secret_id = "mysql-config"
  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_version" "mysql_config_version" {
  secret = google_secret_manager_secret.mysql_config.id
  secret_data = jsonencode({
    db_host     = google_sql_database_instance.mysql_instance.public_ip_address
    db_password = random_password.mysql_password.result
  })
}

output "mysql_instance_connection_name" {
  value = google_sql_database_instance.mysql_instance.connection_name
}
