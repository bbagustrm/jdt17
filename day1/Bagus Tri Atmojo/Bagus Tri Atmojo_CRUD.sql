-- CREATE

CREATE TABLE penjual(
    kode    VARCHAR(10) PRIMARY KEY,
    name    VARCHAR(100) NOT NULL
);

CREATE TABLE metode_pembayaran (
    kode    VARCHAR(10) PRIMARY KEY,
    metode  VARCHAR(100) NOT NULL
);

CREATE TABLE kurir (
    kode    VARCHAR(10) PRIMARY KEY,
    nama    VARCHAR(100) NOT NULL
);

CREATE TABLE pembeli (
    kode    VARCHAR(10) PRIMARY KEY,
    nama    VARCHAR(100) NOT NULL
);

CREATE TABLE alamat (
    kode          VARCHAR(10) PRIMARY KEY,
    kode_pembeli  VARCHAR(10) NOT NULL REFERENCES pembeli(kode) ON DELETE CASCADE,
    nama          VARCHAR(100) NOT NULL,
    jalan         TEXT NOT NULL,
    provinsi      VARCHAR(100) NOT NULL,
    kota          VARCHAR(100) NOT NULL,
    negara        VARCHAR(100) NOT NULL DEFAULT 'ID',
    kodepos       VARCHAR(10) NOT NULL
);

CREATE TABLE products (
    kode          VARCHAR(10)   PRIMARY KEY,
    kode_penjual  VARCHAR(10)   NOT NULL REFERENCES penjual(kode) ON DELETE RESTRICT,
    nama          VARCHAR(255)  NOT NULL,
    berat         INTEGER       CHECK (berat > 0), -- dalam gram
    harga         NUMERIC(15,2) NOT NULL CHECK (harga >= 0)
);

CREATE TABLE orders (
    id               VARCHAR(20)   PRIMARY KEY,
    kode_pembeli     VARCHAR(10)   NOT NULL REFERENCES pembeli(kode) ON DELETE RESTRICT,
    kode_alamat      VARCHAR(10)   REFERENCES alamat(kode) ON DELETE SET NULL,
    kode_pembayaran  VARCHAR(10)   NOT NULL REFERENCES metode_pembayaran(kode) ON DELETE RESTRICT,
    kode_kurir       VARCHAR(10)   NOT NULL REFERENCES kurir(kode) ON DELETE RESTRICT,
    tanggal          TIMESTAMPTZ   NOT NULL DEFAULT NOW(),
    produk_total     NUMERIC(15,2) NOT NULL DEFAULT 0 CHECK ( produk_total > 0 ),
    total_harga      NUMERIC(15,2) NOT NULL DEFAULT 0 CHECK ( total_harga> 0 ),
    total_ongkos     NUMERIC(15,2) NOT NULL DEFAULT 0 CHECK ( total_ongkos > 0 ),
    total_belanja    NUMERIC(15,2) NOT NULL DEFAULT 0 CHECK ( total_belanja > 0 ),
    biaya_jasa       NUMERIC(15,2) NOT NULL DEFAULT 0 CHECK ( biaya_jasa > 0 ),
    total_tagihan    NUMERIC(15,2) NOT NULL DEFAULT 0 CHECK ( total_tagihan > 0 ),
    total_berat      INTEGER       NOT NULL DEFAULT 0 CHECK ( total_berat > 0 )
);

CREATE TABLE order_items (
    id           SERIAL        PRIMARY KEY,
    order_id     VARCHAR(20)   NOT NULL REFERENCES orders(id)   ON DELETE RESTRICT,
    kode_produk  VARCHAR(10)   NOT NULL REFERENCES products(kode) ON DELETE RESTRICT,
    jumlah       INTEGER       NOT NULL CHECK (jumlah > 0),
    total        NUMERIC(15,2) NOT NULL CHECK (total >= 0)
);



-- INSERT

INSERT INTO penjual (kode, name) VALUES ('GO', 'Galeri Olahraga'), ('HS', 'Hello Store');

INSERT INTO metode_pembayaran (kode, metode) VALUES ('DO', 'Debit Online'), ('CC', 'Credit Card');

INSERT INTO kurir (kode, nama) VALUES ('SG', 'Sicepat - Gokil'), ('JN', 'JNE');

INSERT INTO pembeli (kode, nama) VALUES ('JM', 'Joko Morro'), ('EK', 'Eko Kurniawan');

INSERT INTO alamat (kode, kode_pembeli, nama, jalan, provinsi, kota, negara, kodepos) VALUES
    ('BN', 'JM', 'Budi Nugraha', 'Jalan raya xxx',  'DKI Jakarta', 'Jakarta', 'Indonesia', '433333'),
    ('RL', 'EK', 'Rully',        'Jalan raya baru', 'Jawa Barat',  'Bandung', 'Indonesia', '432434');

INSERT INTO products (kode, kode_penjual, nama, berat, harga) VALUES
    ('P0001', 'GO', 'Bola Basket Size 7',  2300, 177900.00),
    ('P0002', 'GO', 'Bola Basket Size 5',   500,  98900.00),
    ('P0003', 'GO', 'Pentil Pompa Bola',     54,   9900.00),
    ('P0004', 'HS', 'Pompa Bola',           198,  43900.00),
    ('P0005', 'HS', 'Apple iPhone Pro Max', 1000, 25000000.00),
    ('P0006', 'HS', 'Apple Watch 8',        2000,  8000000.00);

INSERT INTO orders (id, kode_pembeli, kode_alamat, kode_pembayaran, kode_kurir, tanggal, produk_total, total_harga, total_ongkos, total_belanja, biaya_jasa, total_tagihan, total_berat) VALUES
    ('12345', 'JM', 'BN', 'DO', 'SG', '2023-04-10',  508500.00,  508500.00, 240000.00, 2274000.00, 4000.00, 3026500.00, 5360),
    ('22222', 'EK', 'RL', 'CC', 'JN', '2023-04-11', 33000000.00, 33000000.00, 200000.00, 66200000.00, 2000.00, 99402000.00, 2000),
    ('11111', 'JM', 'BN', 'DO', 'SG', '2023-04-12',  355800.00,  355800.00,  60000.00,  415800.00, 1000.00,  832600.00, 2300);

INSERT INTO order_items (id, order_id, kode_produk, jumlah, total) VALUES
    (1, '12345', 'P0001', 2, 355800.00),
    (2, '22222', 'P0001', 2, 355800.00),
    (3, '12345', 'P0002', 1,  98900.00),
    (4, '12345', 'P0003', 1,   9900.00),
    (5, '12345', 'P0004', 1,  43900.00),
    (6, '11111', 'P0005', 1, 25000000.00),
    (7, '11111', 'P0006', 1,  8000000.00);