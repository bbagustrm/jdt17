CREATE TABLE penjual (
    kode_penjual VARCHAR(10) PRIMARY KEY,
    nama_penjual VARCHAR(100) NOT NULL
);

CREATE TABLE produk (
    kode_produk VARCHAR(10) PRIMARY KEY,
    nama_produk VARCHAR(150) NOT NULL,
    produk_berat INT, -- dalam gram
    produk_harga NUMERIC(12, 2),
    kode_penjual VARCHAR(10) REFERENCES penjual(kode_penjual)
);

CREATE TABLE pembeli (
    kode_pembeli VARCHAR(10) PRIMARY KEY,
    nama_pembeli VARCHAR(100) NOT NULL
);

CREATE TABLE alamat (
    kode_alamat VARCHAR(10) PRIMARY KEY,
    kode_pembeli VARCHAR(10) REFERENCES pembeli(kode_pembeli),
    alamat_nama VARCHAR(100),
    alamat_jalan TEXT,
    alamat_provinsi VARCHAR(100),
    alamat_kota VARCHAR(100),
    alamat_negara VARCHAR(100),
    alamat_kodepos VARCHAR(10)
);

CREATE TABLE metode_pembayaran (
    kode_pembayaran VARCHAR(10) PRIMARY KEY,
    nama_metode VARCHAR(50) NOT NULL
);

CREATE TABLE kurir (
    kode_kurir VARCHAR(10) PRIMARY KEY,
    nama_kurir VARCHAR(50) NOT NULL
);

CREATE TABLE pesanan (
    id_order VARCHAR(20) PRIMARY KEY,
    tanggal DATE NOT NULL,
    kode_alamat VARCHAR(10) REFERENCES alamat(kode_alamat),
    total_ongkos NUMERIC(12, 2),
    biaya_jasa NUMERIC(12, 2),
    kode_pembayaran VARCHAR(10) REFERENCES metode_pembayaran(kode_pembayaran),
    kode_kurir VARCHAR(10) REFERENCES kurir(kode_kurir)
);

CREATE TABLE detail_pesanan (
    id_order VARCHAR(20) REFERENCES pesanan(id_order),
    kode_produk VARCHAR(10) REFERENCES produk(kode_produk),
    produk_jumlah INT NOT NULL,
    PRIMARY KEY (id_order, kode_produk)
);

INSERT INTO penjual VALUES 
('GO', 'Galeri Olahraga'),
('HS', 'Hello Store');

INSERT INTO produk VALUES 
('P0001', 'Bola Basket Size 7', 2300, 177900, 'GO'),
('P0002', 'Bola Basket Size 5', 500, 98900, 'GO'),
('P0003', 'Pentil Pompa Bola', 54, 9900, 'GO'),
('P0004', 'Pompa Bola', 198, 43900, 'GO'),
('P0005', 'Apple iPhone Pro Max', 1000, 25000000, 'HS'),
('P0006', 'Apple Watch 8', 2000, 8000000, 'HS');

INSERT INTO pembeli VALUES 
('JM', 'Joko Morro'),
('EK', 'Eko Kurniawan');

INSERT INTO alamat VALUES 
('BN', 'JM', 'Budi Nugraha', 'Jalan raya xxx', 'DKI Jakarta', 'Jakarta', 'Indonesia', '433333'),
('RL', 'EK', 'Rully', 'Jalan raya baru', 'Jawa Barat', 'Bandung', 'Indonesia', '432434');

INSERT INTO metode_pembayaran VALUES 
('DO', 'Debit Online'),
('CC', 'Credit Card');

INSERT INTO kurir VALUES 
('SG', 'Sicepat - Gokil'),
('JN', 'JNE');

INSERT INTO pesanan VALUES 
('12345', '2023-04-11', 'BN', 60000, 1000, 'DO', 'SG'),
('11111', '2023-04-12', 'RL', 100000, 1000, 'CC', 'JN'),
('22222', '2023-04-13', 'BN', 60000, 1000, 'DO', 'SG');

INSERT INTO detail_pesanan VALUES 
('12345', 'P0001', 2),
('12345', 'P0002', 1),
('12345', 'P0003', 1),
('12345', 'P0004', 1),
('11111', 'P0005', 1),
('11111', 'P0006', 1),
('22222', 'P0001', 2);