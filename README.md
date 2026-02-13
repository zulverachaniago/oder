# oder

Aplikasi menu & order by Zarba Kitchen.

## Setup

* Ruby version: lihat `.ruby-version`
* Database: `rails db:create db:migrate`
* Jalankan: `rails server`

## Production: upload gambar "size too large"

Kalau di production upload gambar gagal dengan error size/413, batasi ukuran body di reverse proxy (Nginx/Traefik). Lihat **docs/PRODUCTION_UPLOAD_SIZE.md**.
