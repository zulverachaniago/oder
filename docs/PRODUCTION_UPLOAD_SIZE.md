# Upload "Size Too Large" di Production

Di local upload gambar berhasil, di production muncul error **413 Request Entity Too Large** atau **size too large** karena **reverse proxy** membatasi ukuran body request (biasanya default 1MB). Gambar > 1MB akan ditolak sebelum sampai ke Rails.

## Solusi

### 1. Nginx (VPS / server pakai Nginx)

Edit konfigurasi Nginx (mis. `/etc/nginx/nginx.conf` atau `/etc/nginx/sites-available/your-site`):

```nginx
http {
  client_max_body_size 20M;   # sesuaikan (mis. 20MB untuk upload gambar)
}
```

Atau hanya untuk server/location tertentu:

```nginx
server {
  client_max_body_size 20M;
  # ...
}
```

Lalu reload Nginx:

```bash
sudo nginx -t && sudo systemctl reload nginx
```

### 2. Kamal + Traefik (proxy SSL di deploy.yml)

Saat mengaktifkan `proxy:` di `config/deploy.yml`, tambahkan opsi Traefik untuk buffering agar upload besar diperbolehkan. Contoh (pastikan ada bagian `proxy:`):

```yaml
proxy:
  ssl: true
  host: app.example.com
  # Izinkan request body sampai 20MB (untuk upload gambar)
  options:
    max_request_body_bytes: 20971520   # 20MB
```

Jika Kamal versi Anda mendukung custom Traefik args, sesuaikan dengan [dokumentasi Kamal Traefik](https://kamal-deploy.org/docs/configuration/traefik).

### 3. Cek batasan lain

- **Load balancer / CDN** (Cloudflare, AWS ALB, dll.): cek batas upload di panel masing-masing.
- **Rails**: tidak membatasi ukuran body; batasan ada di proxy/load balancer.

## Rekomendasi

- Set limit wajar (mis. **10–20MB**) agar upload gambar produk bisa, tanpa membuka pintu untuk abuse.
- Untuk validasi di aplikasi (opsional), bisa batasi ukuran file di model/controller dan tampilkan pesan error yang jelas.
