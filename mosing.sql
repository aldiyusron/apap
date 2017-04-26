CREATE TABLE IF NOT EXISTS USER
(
	id_user INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
	username VARCHAR(30) NOT NULL UNIQUE KEY,
	password VARCHAR(20) NOT NULL,
	email	VARCHAR(30) NOT NULL,
	role VARCHAR(15) NOT NULL,
	enabled TINYINT(1) NOT NULL
);

CREATE TABLE IF NOT EXISTS FAKULTAS
(
	id_fakultas INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
	fakultas VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS PEGAWAI
(
	id_user INTEGER NOT NULL PRIMARY KEY,
	nip CHAR(20) NOT NULL,
	nama VARCHAR(50) NOT NULL,
	jabatan VARCHAR(50) NOT NULL,
	id_fakultas INTEGER,
	FOREIGN KEY(id_user) REFERENCES USER (id_user) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY(id_fakultas) REFERENCES FAKULTAS (id_fakultas) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS NEGARA
(
	id_negara INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
	nama_negara VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS PROVINSI
(
	id_provinsi INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
	id_negara INTEGER NOT NULL,
	nama_provinsi VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS KOTA
(
	id_kota INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
	id_provinsi INTEGER NOT NULL,
	nama_kota VARCHAR(50) NOT NULL,
	FOREIGN KEY(id_provinsi) REFERENCES PROVINSI (id_provinsi) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS LEMBAGA_PENDIDIKAN_TERAKHIR
(
	id_user INTEGER NOT NULL PRIMARY KEY,
	nama_lembaga VARCHAR(50) NOT NULL,
	nama_provinsi VARCHAR(50) NOT NULL,
	nama_kota VARCHAR(50) NOT NULL,
	FOREIGN KEY(id_user) REFERENCES USER (id_user) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS PENDAFTAR
(
	id_user INTEGER,
	no_id VARCHAR(20) NOT NULL,
	nama_id VARCHAR(50) NOT NULL,
	nama_ijazah VARCHAR(50) NOT NULL,
	foto VARCHAR(100),
	no_hp VARCHAR(14),
	no_telp VARCHAR(14),
	nama_negara VARCHAR(50),
	kewarganegaraan VARCHAR(3),
	alamat_tetap VARCHAR(100),
	jenis_id VARCHAR(20),
	alamat_sekarang VARCHAR(100),
	tgl_lahir DATE,
	nama_provinsi VARCHAR(50),
	nama_kota VARCHAR(50),
	jenis_kelamin TINYINT(1),
	nama_lembaga VARCHAR(50),
	jurusan VARCHAR(50),
	no_daftar INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
	FOREIGN KEY(id_user) REFERENCES USER (id_user) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS LOKASI
(
	id_lokasi INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
	alamat VARCHAR(100) NOT NULL,
	no_telp VARCHAR(14) NOT NULL,
	nama_lokasi VARCHAR(50) NOT NULL,
	nama_provinsi VARCHAR(50) NOT NULL,
	nama_kota VARCHAR(50) NOT NULL,
	kuota_peng INTEGER NOT NULL,
	kuota_pendaftar INTEGER NOT NULL,
	flag_aktif TINYINT(1) NOT NULL
);

CREATE TABLE IF NOT EXISTS PENGAWAS_UJIAN
(
	id_user INTEGER NOT NULL PRIMARY KEY,
	status TINYINT(1) NOT NULL,
	jabatan VARCHAR(50) NOT NULL,
	nama VARCHAR(50) NOT NULL,
	id_lokasi INTEGER NOT NULL,
	FOREIGN KEY(id_user) REFERENCES USER (id_user) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY(id_lokasi) REFERENCES LOKASI (id_lokasi) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS JALUR_MASUK
(
	id_jalur INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
	nama VARCHAR(30) NOT NULL,
	tanggal_buka DATE NOT NULL,
	tanggal_tutup DATE NOT NULL,
	status TINYINT(1) NOT NULL,
	nama_jenjang VARCHAR(20) NOT NULL,
	nama_program VARCHAR (20),
	jenis_jalur TINYINT(1) NOT NULL,
	persyaratan VARCHAR(200) NOT NULL,
	waktu_ujian DATETIME NOT NULL,
	flag_aktif TINYINT(1) NOT NULL
);

CREATE TABLE IF NOT EXISTS PRODI_TERSEDIA
(
	id_prodi INTEGER NOT NULL AUTO_INCREMENT,
	nama_prodi VARCHAR(100) NOT NULL,
	daya_tampung INTEGER NOT NULL,
	nama_fakultas VARCHAR(50) NOT NULL,
	id_jalur INTEGER NOT NULL,
	PRIMARY KEY (id_prodi, id_jalur),
	FOREIGN KEY(id_jalur) REFERENCES JALUR_MASUK (id_jalur) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS DAFTAR_PILIHAN
(
	no_daftar INTEGER NOT NULL,
	jenjang VARCHAR(15) NOT NULL,
	nama_program VARCHAR(20),
	id_prodi INTEGER NOT NULL,
	pilihan INTEGER NOT NULL,
	PRIMARY KEY (no_daftar, jenjang, id_prodi),
	FOREIGN KEY(no_daftar) REFERENCES PENDAFTAR (no_daftar) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY(id_prodi) REFERENCES PRODI_TERSEDIA (id_prodi) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS DETAIL_UJIAN
(
	no_daftar INTEGER NOT NULL,
	no_ujian CHAR(10) NOT NULL,
	id_jalur INTEGER NOT NULL,
	id_lokasi INTEGER NOT NULL,
	waktu_ujian DATETIME NOT NULL,
	PRIMARY KEY (no_daftar, no_ujian),
	FOREIGN KEY(no_daftar) REFERENCES DAFTAR_PILIHAN (no_daftar) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY(id_jalur) REFERENCES JALUR_MASUK (id_jalur) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY(id_lokasi) REFERENCES LOKASI (id_lokasi) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS RIWAYAT_PENDAFTARAN
(
	no_pendaftaran INTEGER NOT NULL,
	tahun CHAR(4) NOT NULL,
	id_jalur INTEGER NOT NULL,
	nama_jenjang VARCHAR(20) NOT NULL,
	nama_program VARCHAR(20),
	PRIMARY KEY(no_pendaftaran, id_jalur, nama_jenjang, nama_program, tahun),
	FOREIGN KEY(no_pendaftaran) REFERENCES PENDAFTAR (no_daftar) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY(id_jalur) REFERENCES JALUR_MASUK (id_jalur) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS PENYELEKSIAN
(
	no_daftar INTEGER NOT NULL PRIMARY KEY,
	status TINYINT(1) NOT NULL,
	id_jalur INTEGER NOT NULL,
	berkas VARCHAR(100),
	FOREIGN KEY(no_daftar) REFERENCES PENDAFTAR (no_daftar) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY(id_jalur) REFERENCES JALUR_MASUK (id_jalur) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS NILAI_UJIAN
(
	no_daftar INTEGER NOT NULL PRIMARY KEY,
	tpa INTEGER,
	mtk_dasar INTEGER,
	mtk INTEGER,
	kimia INTEGER,
	fisika INTEGER,
	biologi INTEGER,
	sejarah INTEGER,
	geografi INTEGER,
	ekonomi INTEGER,
	bindo INTEGER,
	bing INTEGER,
	FOREIGN KEY(no_daftar) REFERENCES PENYELEKSIAN(no_daftar) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS NILAI_RAPOR
(
	no_daftar INTEGER NOT NULL,
	kkm_mtk INTEGER,
	kkm_kimia INTEGER,
	kkm_fisika INTEGER,
	kkm_biologi INTEGER,
	kkm_sejarah INTEGER,
	kkm_geografi INTEGER,
	kkm_ekonomi INTEGER,
	kkm_bindo INTEGER,
	kkm_bing INTEGER,
	mtk INTEGER,
	kimia INTEGER,
	fisika INTEGER,
	biologi INTEGER,
	sejarah INTEGER,
	geografi INTEGER,
	ekonomi INTEGER,
	bindo INTEGER,
	bing INTEGER,
	semester INTEGER NOT NULL,
	PRIMARY KEY (no_daftar, semester),
	FOREIGN KEY(no_daftar) REFERENCES PENYELEKSIAN(no_daftar) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS CALON_MAHASISWA
(
	no_daftar INTEGER NOT NULL,
	npm CHAR(10) NOT NULL,
	id_prodi INTEGER NOT NULL,
	id_jalur INTEGER NOT NULL,
	jenjang VARCHAR(20) NOT NULL,
	PRIMARY KEY (no_daftar, npm, id_jalur),
	FOREIGN KEY(no_daftar) REFERENCES PENDAFTAR (no_daftar) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY(id_prodi) REFERENCES PRODI_TERSEDIA (id_prodi) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY(id_jalur) REFERENCES JALUR_MASUK (id_jalur) ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO USER (username,password,email,role,enabled) VALUES ('KPMB1','password1','kpmb@ui.ac.id','ROLE_KPMB', true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PEMU2','password2','pemu@ui.ac.id','ROLE_PEM_U', true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PEMF3','password3','pemf@ui.ac.id','ROLE_PEM_F', true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PEND4','password4','pend4@ui.ac.id','ROLE_PEND', true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('LPT5','password5','lpt@ui.ac.id','ROLE_LPT', true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PENGU6','password6','pengu6@ui.ac.id','ROLE_PENG_U', true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PEND7','password7','pend7@ui.ac.id','ROLE_PEND', true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PEND8','password8','pend8@ui.ac.id','ROLE_PEND', true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PEND9','password9','pend9@ui.ac.id','ROLE_PEND', true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PEND10','password10','pend10@ui.ac.id','ROLE_PEND', true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PENGU11','password11','pengu11@ui.ac.id','ROLE_PENG_U', true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PENGU12','password12','pengu12@ui.ac.id','ROLE_PENG_U', true);

INSERT INTO FAKULTAS (fakultas) VALUES ('Fakultas Kedokteran');
INSERT INTO FAKULTAS (fakultas) VALUES ('Fakultas Kedokteran Gigi');
INSERT INTO FAKULTAS (fakultas) VALUES ('Fakultas Kesehatan Masyarakat');
INSERT INTO FAKULTAS (fakultas) VALUES ('Fakultas Ilmu Keperawatan');
INSERT INTO FAKULTAS (fakultas) VALUES ('Fakultas Farmasi');
INSERT INTO FAKULTAS (fakultas) VALUES ('Fakultas Matematika & Ilmu Pengetahuan Alam');
INSERT INTO FAKULTAS (fakultas) VALUES ('Fakultas Teknik');
INSERT INTO FAKULTAS (fakultas) VALUES ('Fakultas Ilmu Komputer');
INSERT INTO FAKULTAS (fakultas) VALUES ('Fakultas Hukum');
INSERT INTO FAKULTAS (fakultas) VALUES ('Fakultas Ekonomi & Bisnis');
INSERT INTO FAKULTAS (fakultas) VALUES ('Fakultas Ilmu Pengetahuan Budaya');
INSERT INTO FAKULTAS (fakultas) VALUES ('Fakultas Psikologi');
INSERT INTO FAKULTAS (fakultas) VALUES ('Fakultas Ilmu Sosial & Ilmu Politik');
INSERT INTO FAKULTAS (fakultas) VALUES ('Fakultas Ilmu Administrasi');

INSERT INTO PEGAWAI (id_user,nip,nama,jabatan,id_fakultas) VALUES (1,'1000000101','Bambang Pamungkas','Kepala KPMB',null);
INSERT INTO PEGAWAI (id_user,nip,nama,jabatan,id_fakultas) VALUES (2,'1000000001','Jaka Widodo','Pemimpin UI',null);
INSERT INTO PEGAWAI (id_user,nip,nama,jabatan,id_fakultas) VALUES (3,'1000000002','Baskoro','Pemimpin Fakultas',8);

INSERT INTO NEGARA (nama_negara) VALUES ('Indonesia');
INSERT INTO NEGARA (nama_negara) VALUES ('Malaysia');
INSERT INTO NEGARA (nama_negara) VALUES ('Singapura');

INSERT INTO `provinsi` (`id_provinsi`, `id_negara`, `nama_provinsi`) VALUES
(1, 1, 'Aceh'),
(2, 1, 'Bali'),
(3, 1, 'Banten'),
(4, 1, 'Bengkulu'),
(5, 1, 'Gorontalo'),
(6, 1, 'Jakarta'),
(7, 1, 'Jambi'),
(8, 1, 'Jawa Barat'),
(9, 1, 'Jawa Tengah'),
(10, 1, 'Jawa Timur'),
(11, 1, 'Kalimantan Barat'),
(12, 1, 'Kalimantan Selatan'),
(13, 1, 'Kalimantan Tengah'),
(14, 1, 'Kalimantang Timur'),
(15, 1, 'Kalimantan Utara'),
(16, 1, 'Kepulauan Bangka Belitung'),
(17, 1, 'Kepulauan Riau'),
(18, 1, 'Lampung'),
(19, 1, 'Maluku'),
(20, 1, 'Maluku Utara'),
(21, 1, 'Nusa Tenggara Barat'),
(22, 1, 'Nusa Tenggara TImur'),
(23, 1, 'Papua'),
(24, 1, 'Papua Barat'),
(25, 1, 'Riau'),
(26, 1, 'Sulawesi Barat'),
(27, 1, 'Sulawesi Selatan'),
(28, 1, 'Sulawesi Tengah'),
(29, 1, 'Sulawesi Tenggara'),
(30, 1, 'Sulawesi Utara'),
(31, 1, 'Sumatera Barat'),
(32, 1, 'Sumatera Selatan'),
(33, 1, 'Sumatera Utara'),
(34, 1, 'Yogyakarta');

INSERT INTO `kota` (`id_kota`, `id_provinsi`, `nama_kota`) VALUES
(1, 1, 'Banda Aceh'),
(2, 1, 'Langsa'),
(3, 1, 'Lhokseumawe'),
(4, 1, 'Meulaboh'),
(5, 1, 'Sabang'),
(6, 1, 'Subulussalam'),
(7, 2, 'Denpasar'),
(8, 16, 'Pangkalpinang'),
(9, 3, 'Cilegon'),
(10, 3, 'Serang'),
(11, 3, 'Tangerang'),
(12, 3, 'Tangerang Selatan'),
(13, 4, 'Bengkulu'),
(14, 5, 'Gorontalo'),
(15, 6, 'Jakarta Barat'),
(16, 6, 'Jakarta Pusat'),
(17, 6, 'Jakarta Selatan'),
(18, 6, 'Jakarta TImur'),
(19, 6, 'Jakarta Utara'),
(20, 7, 'Sungai Penuh'),
(21, 7, 'Jambi'),
(22, 8, 'Bandung'),
(23, 8, 'Bekasi'),
(24, 8, 'Bogor'),
(25, 8, 'Cimahi'),
(26, 8, 'Cirebon'),
(27, 8, 'Depok'),
(28, 8, 'Sukabumi'),
(29, 8, 'Tasikmalaya'),
(30, 8, 'Banjar'),
(31, 9, 'Magelang'),
(32, 9, 'Pekalongan'),
(33, 9, 'Purwokerto'),
(34, 9, 'Salatiga'),
(35, 9, 'Semarang'),
(36, 9, 'Surakarta'),
(37, 9, 'Tegal'),
(38, 10, 'Batu'),
(39, 10, 'Blitar'),
(40, 10, 'Kediri'),
(41, 10, 'Madiun'),
(42, 10, 'Malang'),
(43, 10, 'Mojokerto'),
(44, 10, 'Pasuruan'),
(45, 10, 'Probolinggo'),
(46, 10, 'Surabaya'),
(47, 11, 'Pontianak'),
(48, 11, 'Singkawang'),
(49, 12, 'Banjarbatu'),
(50, 12, 'Banjarmasin'),
(51, 13, 'Palangkaraya'),
(52, 14, 'Balikpapan'),
(53, 14, 'Bontang'),
(54, 14, 'Samarinda'),
(55, 15, 'Tarakan'),
(56, 17, 'Batam'),
(57, 17, 'Tanjungpinang'),
(58, 18, 'Bandar Lampung'),
(59, 18, 'Metro'),
(60, 20, 'Ternate'),
(61, 20, 'Tidore Kepulauan'),
(62, 19, 'Ambon'),
(63, 19, 'Tual'),
(64, 21, 'Bima'),
(65, 21, 'Mataram'),
(66, 22, 'Kupang'),
(67, 23, 'Jayapura'),
(68, 24, 'Sorong'),
(69, 25, 'Dumai'),
(70, 25, 'Pekanbaru'),
(71, 27, 'Makassar'),
(72, 27, 'Palopo'),
(73, 27, 'Parepare'),
(74, 28, 'Palu'),
(75, 29, 'Bau-bau'),
(76, 29, 'Kendari'),
(77, 30, 'Bitung'),
(78, 30, 'Kotamobago'),
(79, 30, 'Manado'),
(80, 30, 'Tomohon'),
(81, 31, 'Bukittinggi'),
(82, 31, 'Padang'),
(83, 31, 'Padangpanjang'),
(84, 31, 'Pariaman'),
(85, 31, 'Payakumbuh'),
(86, 31, 'Sawahlunto'),
(87, 31, 'Solok'),
(88, 32, 'Lubuklinggau'),
(89, 32, 'Pagaralam'),
(90, 32, 'Palembang'),
(91, 32, 'Prabumulih'),
(92, 33, 'Binjai'),
(93, 33, 'Medan'),
(94, 33, 'Padang Sidempuan'),
(95, 33, 'Pematangsiantar'),
(96, 33, 'Sibolga'),
(97, 33, 'Tanjungbalai'),
(98, 33, 'Tebingtinggi'),
(99, 34, 'Yogyakarta');

INSERT INTO LEMBAGA_PENDIDIKAN_TERAKHIR (id_user,nama_lembaga,nama_provinsi,nama_kota) VALUES (5,'MTS Pramudito','DKI Jakarta','Jakarta Timur');

INSERT INTO PENDAFTAR (id_user,no_id,nama_id,nama_ijazah,foto,no_hp,no_telp,nama_negara,kewarganegaraan,alamat_tetap,jenis_id,alamat_sekarang,tgl_lahir,nama_provinsi,nama_kota,jenis_kelamin,jurusan,nama_lembaga) VALUES (4,'1706520000','Pendaftar1','Pendaftar1i','foto1.jpg','82124360370','7987325','Indonesia','WNI','Jl. Juragan Sinda','KTP','Jl. Padepokan Timur','1999-07-24','Jawa Barat','Depok','1','IPA',null);
INSERT INTO PENDAFTAR (id_user,no_id,nama_id,nama_ijazah,foto,no_hp,no_telp,nama_negara,kewarganegaraan,alamat_tetap,jenis_id,alamat_sekarang,tgl_lahir,nama_provinsi,nama_kota,jenis_kelamin,jurusan,nama_lembaga) VALUES (7,'1706521090','Pendaftar2','Pendaftar2i','foto2.png','82124360371','7987326','Malaysia','WNA','Jl. Zimbabwe','SIM','Jl. Mangga Besar','2000-08-29','Dan lain-lain','Dan lain-lain','1',null,null);
INSERT INTO PENDAFTAR (id_user,no_id,nama_id,nama_ijazah,foto,no_hp,no_telp,nama_negara,kewarganegaraan,alamat_tetap,jenis_id,alamat_sekarang,tgl_lahir,nama_provinsi,nama_kota,jenis_kelamin,jurusan,nama_lembaga) VALUES (8,'8906528000','Pendaftar3','Pendaftar3i','foto3.jpeg','82124360372','7987327','Indonesia','WNI','Jl. In Aja Dulu','KTP','Jl. Indah','2000-04-03','DKI Jakarta','Jakarta Selatan','0',null,null);
INSERT INTO PENDAFTAR (id_user,no_id,nama_id,nama_ijazah,foto,no_hp,no_telp,nama_negara,kewarganegaraan,alamat_tetap,jenis_id,alamat_sekarang,tgl_lahir,nama_provinsi,nama_kota,jenis_kelamin,jurusan,nama_lembaga) VALUES (9,'81706520110','Pendaftar4','Pendaftar4i','foto4.png','82124360373','7987328','Indonesia','WNI','Jl. Kebenaran','KTP','Jl. Besar','1999-01-19','Banten','Tangerang','0',null,null);
INSERT INTO PENDAFTAR (id_user,no_id,nama_id,nama_ijazah,foto,no_hp,no_telp,nama_negara,kewarganegaraan,alamat_tetap,jenis_id,alamat_sekarang,tgl_lahir,nama_provinsi,nama_kota,jenis_kelamin,jurusan,nama_lembaga) VALUES (10,'71896520001','Pendaftar5','Pendaftar5i','foto5.jpg','82124360374','7987329','Singapura','WNA','Jl. Lurus','KTP','Jl. Kecil','1999-11-11','Dan lain-lain','Dan lain-lain','1',null,null);

INSERT INTO LOKASI (alamat,no_telp,nama_lokasi,nama_provinsi,nama_kota,kuota_peng,kuota_pendaftar) VALUES ('Jl. Lengkeng','8886677','SMAN 1000','Jawa Barat','Depok',12,120);
INSERT INTO LOKASI (alamat,no_telp,nama_lokasi,nama_provinsi,nama_kota,kuota_peng,kuota_pendaftar) VALUES ('Jl. Mangga','7779933','SMAN 1001','DKI Jakarta','Jakarta Utara',10,150);
INSERT INTO LOKASI (alamat,no_telp,nama_lokasi,nama_provinsi,nama_kota,kuota_peng,kuota_pendaftar) VALUES ('Jl. Semangka','9894212','SMAN 1002','DKI Jakarta','Jakarta Selatan',20,200);

INSERT INTO PENGAWAS_UJIAN (id_user,status,jabatan,nama,id_lokasi) VALUES (6,true,'Pegawai UI','Aqua',1);
INSERT INTO PENGAWAS_UJIAN (id_user,status,jabatan,nama,id_lokasi) VALUES (11,true,'Mahasiswa','Prima',2);
INSERT INTO PENGAWAS_UJIAN (id_user,status,jabatan,nama,id_lokasi) VALUES (12,true,'Mahasiswa','Ades',3);

INSERT INTO JALUR_MASUK (nama,tanggal_buka,tanggal_tutup,status,nama_jenjang,nama_program,jenis_jalur,persyaratan,waktu_ujian,flag_aktif) VALUES ('SIMAK UI','2017-05-11','2017-08-11',1,'S1','Reguler',1,'Pendaftar merupakan mahasiswa teladan','2017-07-07 09:00:00.000000',1);
INSERT INTO JALUR_MASUK (nama,tanggal_buka,tanggal_tutup,status,nama_jenjang,nama_program,jenis_jalur,persyaratan,waktu_ujian,flag_aktif) VALUES ('SIMAK UI','2017-03-10','2017-06-10',1,'S2',null,1,'Pendaftar merupakan lulusan terdaftar univ tertentu','2017-10-08 09:00:00.000000',1);
INSERT INTO JALUR_MASUK (nama,tanggal_buka,tanggal_tutup,status,nama_jenjang,nama_program,jenis_jalur,persyaratan,waktu_ujian,flag_aktif) VALUES ('MASUK UI KUY','2018-05-11','2018-08-11',0,'S1','Paralel',0,'Pendaftar harus punya SIM dan STNK','2017-08-10 09:00:00.000000',1);

INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,nama_fakultas,id_jalur) VALUES ('Sistem Informasi',100,'Fasilkom',1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,nama_fakultas,id_jalur) VALUES ('Ilmu Komputer',100,'Fasilkom',1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,nama_fakultas,id_jalur) VALUES ('Magister Sistem Informasi',100,'Fasilkom',1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,nama_fakultas,id_jalur) VALUES ('Matematika',100,'FMIPA',3);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,nama_fakultas,id_jalur) VALUES ('Fisika',200,'Fasilkom',3);

INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (1,'S1','Reguler',1,1);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (1,'S1','Reguler',2,2);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (2,'S1','Reguler',1,1);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (2,'S1','Reguler',2,2);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (3,'S1','Reguler',1,1);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (4,'S1','Reguler',2,1);

INSERT INTO DETAIL_UJIAN (no_daftar,no_ujian,id_jalur,id_lokasi,waktu_ujian) VALUES (1,'0000000001',1,1,'2017-07-07 09:00:00.000000');

INSERT INTO RIWAYAT_PENDAFTARAN (no_pendaftaran,tahun,id_jalur,nama_jenjang,nama_program) VALUES (1, '2017', 1, 'S1', 'Reguler');
INSERT INTO RIWAYAT_PENDAFTARAN (no_pendaftaran,tahun,id_jalur,nama_jenjang,nama_program) VALUES (2, '2016', 1, 'S1', 'Reguler');
INSERT INTO RIWAYAT_PENDAFTARAN (no_pendaftaran,tahun,id_jalur,nama_jenjang,nama_program) VALUES (2, '2017', 3, 'S1', 'Reguler');

INSERT INTO PENYELEKSIAN (no_daftar,status,id_jalur,berkas) VALUES (1,1,1,null);
INSERT INTO PENYELEKSIAN (no_daftar,status,id_jalur,berkas) VALUES (2,0,3,null);

INSERT INTO NILAI_UJIAN (no_daftar,tpa,mtk_dasar,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,bindo,bing) VALUES (1,80,78,68,56,78,75,null,null,null,80,90);

INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,bindo,bing,semester) VALUES (2,78,78,78,78,null,null,null,78,78,80,82,78,88,null,null,null,80,90,1);

INSERT INTO CALON_MAHASISWA (no_daftar, npm, id_prodi, id_jalur, jenjang) VALUES (1,'1708888889',1,1,'S1');