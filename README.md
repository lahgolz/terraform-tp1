# TP1 — DevOps

Simple Node.js/Express API deployed with Docker and managed with Terraform.

## Environment variables

| Variable | Description |
|----------|-------------|
| `PORT` | Port the API listens on (default: `3000`) |
| `APP_ENV` | Application environment (e.g. `development`) |
| `DATABASE_URL` | PostgreSQL connection string |

## Run with Terraform

```sh
cd terraform
terraform init
terraform plan
terraform apply
```

### Outputs

```sh
terraform output api_url       # http://localhost:<api_port>
terraform output adminer_url   # http://localhost:<adminer_port>
terraform output db_dsn        # PostgreSQL DSN (sensitive)
```
