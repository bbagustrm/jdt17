CREATE TABLE penjual (
    penjual_id SERIAL PRIMARY KEY,
    kode_penjual VARCHAR(20) NOT NULL,
    nama_penjual VARCHAR(20) NOT NULL
);
CREATE TABLE pembeli (
    pembeli_id SERIAL PRIMARY KEY,
    kode_pembeli VARCHAR(20)NOT NULL,
    nama_pembeli VARCHAR(20) NOT NULL
);

CREATE TABLE alamat (
    alamat_id SERIAL PRIMARY KEY,
    kode_alamat VARCHAR(20) NOT NULL,
    nama_penerima VARCHAR(20) NOT NULL,
    nama_jalan VARCHAR(20),
    nama_provinsi VARCHAR(20),
    nama_kota VARCHAR(20),
    nama_negara VARCHAR(20),
    kode_pos INT
);

CREATE TABLE pembayaran (
    pembayaran_id SERIAL PRIMARY KEY,
    kode_pembayaran VARCHAR(20) NOT NULL,
    jenis_pembayaran VARCHAR(20) NOT NULL
);

CREATE TABLE kurir (
    kurir_id SERIAL PRIMARY KEY,
    kode_kurir VARCHAR(20) NOT NULL,
    nama_kurir VARCHAR(20) NOT NULL
);


CREATE TABLE produk (
    produk_id VARCHAR(10) PRIMARY KEY,
    kode_produk VARCHAR(20) NOT NULL,
    nama_produk VARCHAR(20) NOT NULL,
    berat INT,
    harga NUMERIC(15,2)
);



CREATE TABLE pesan (
    pesan_id BIGINT PRIMARY KEY,
    penjual_id INT REFERENCES penjual(penjual_id),
    pembeli INT REFERENCES pembeli(pembeli_id),
    alamat_id INT REFERENCES alamat(alamat_id),
    pembayaran_id INT REFERENCES pembayaran(pembayaran_id),
    kurir_id INT REFERENCES kurir(kurir_id),
    tanggal DATE NOT NULL,
    total NUMERIC(15,2),
    ongkos NUMERIC(15,2),
    berat_total INT,
    jumlah_belanja NUMERIC(15,2),
    total_jasa NUMERIC(15,2),
    total_keseluruhan NUMERIC(15,2)
);


CREATE TABLE detail_order (
    pesan_id BIGINT REFERENCES pesan(pesan_id),
    produk_id VARCHAR(10) REFERENCES produk(produk_id),
    jumlah INT NOT NULL,
    total_produk NUMERIC(15,2),
    PRIMARY KEY (pesan_id, produk_id)
);


