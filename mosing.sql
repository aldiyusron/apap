CREATE TABLE IF NOT EXISTS USER
(
	id_user INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
	username VARCHAR(30) NOT NULL UNIQUE KEY,
	password VARCHAR(20) NOT NULL,
	email	VARCHAR(30),
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
	waktu_ujian DATETIME,
	flag_aktif TINYINT(1) NOT NULL
);

CREATE TABLE IF NOT EXISTS LOKASI
(
	id_lokasi INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
	id_jalur INTEGER NOT NULL,
	alamat VARCHAR(100) NOT NULL,
	no_telp VARCHAR(14) NOT NULL,
	nama_lokasi VARCHAR(50) NOT NULL,
	nama_provinsi VARCHAR(50) NOT NULL,
	nama_kota VARCHAR(50) NOT NULL,
	kuota_peng INTEGER NOT NULL,
	kuota_pendaftar INTEGER NOT NULL,
	flag_aktif TINYINT(1) NOT NULL,
	FOREIGN KEY(id_jalur) REFERENCES JALUR_MASUK (id_jalur) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS PENGAWAS_UJIAN
(
	id_user INTEGER NOT NULL PRIMARY KEY,
	status TINYINT(1) NOT NULL,
	jabatan VARCHAR(50) NOT NULL,
	nama VARCHAR(50) NOT NULL,
	no_hp VARCHAR(20) NOT NULL,
	id_lokasi INTEGER NOT NULL,
	pindah_bool TINYINT(1) NOT NULL,
	flag_aktif TINYINT(1) NOT NULL,
	FOREIGN KEY(id_user) REFERENCES USER (id_user) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY(id_lokasi) REFERENCES LOKASI (id_lokasi) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS PRODI_TERSEDIA
(
	id_prodi INTEGER NOT NULL AUTO_INCREMENT,
	nama_prodi VARCHAR(100) NOT NULL,
	daya_tampung INTEGER NOT NULL,
	id_fakultas INTEGER NOT NULL,
	id_jalur INTEGER NOT NULL,
	flag_aktif TINYINT(1) NOT NULL,
	PRIMARY KEY (id_prodi, id_jalur),
	FOREIGN KEY(id_jalur) REFERENCES JALUR_MASUK (id_jalur) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY(id_fakultas) REFERENCES FAKULTAS (id_fakultas) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS DAFTAR_PILIHAN
(
	no_daftar INTEGER NOT NULL,
	jenjang VARCHAR(15) NOT NULL,
	nama_program VARCHAR(20),
	id_prodi INTEGER NOT NULL,
	pilihan INTEGER NOT NULL,
	flag_aktif TINYINT(1) NOT NULL,
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
	status_rekomen TINYINT(1) NOT NULL,
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
	sosiologi INTEGER,
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
	kkm_sosiologi INTEGER,
	kkm_bindo INTEGER,
	kkm_bing INTEGER,
	mtk INTEGER,
	kimia INTEGER,
	fisika INTEGER,
	biologi INTEGER,
	sejarah INTEGER,
	geografi INTEGER,
	ekonomi INTEGER,
	sosiologi INTEGER,
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
INSERT INTO USER (username,password,email,role,enabled) VALUES ('LPT13','password13','lpt13@ui.ac.id','ROLE_LPT', true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('LPT14','password14','lpt14@ui.ac.id','ROLE_LPT', true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('LPT15','password15','lpt15@ui.ac.id','ROLE_LPT', true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('LPT16','password16','lpt16@ui.ac.id','ROLE_LPT', true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('LPT17','password17','lpt17@ui.ac.id','ROLE_LPT', true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('LPT18','password18','lpt18@ui.ac.id','ROLE_LPT', true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('LPT19','password19','lpt19@ui.ac.id','ROLE_LPT', true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('LPT20','password20','lpt20@ui.ac.id','ROLE_LPT', true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('LPT21','password21','lpt21@ui.ac.id','ROLE_LPT', true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PEND22','password22','pend22@ui.ac.id','ROLE_PEND', true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PEND23','password23','pend23@ui.ac.id','ROLE_PEND', true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PEND24','password24','pend24@ui.ac.id','ROLE_PEND', true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PEND25','password25','pend25@ui.ac.id','ROLE_PEND', true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PEND26','password26','pend26@ui.ac.id','ROLE_PEND', true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PEND27','password27','pend27@ui.ac.id','ROLE_PEND', true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PEND28','password28','pend28@ui.ac.id','ROLE_PEND', true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PEND29','password29','pend29@ui.ac.id','ROLE_PEND', true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PEND30','password30','pend30@ui.ac.id','ROLE_PEND', true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PEND31','password31','pend31@ui.ac.id','ROLE_PEND', true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PEND32','password32','pend32@ui.ac.id','ROLE_PEND', true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PEND33','password33','pend33@ui.ac.id','ROLE_PEND', true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PEND34','password34','pend34@ui.ac.id','ROLE_PEND', true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PEND35','password35','pend35@ui.ac.id','ROLE_PEND', true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PEND36','password36','pend36@ui.ac.id','ROLE_PEND', true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PEND37','password37','pend37@ui.ac.id','ROLE_PEND', true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PEND38','password38','pend38@ui.ac.id','ROLE_PEND', true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PEND39','password39','pend39@ui.ac.id','ROLE_PEND', true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PEND40','password40','pend40@ui.ac.id','ROLE_PEND', true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PEND41','password41','pend41@ui.ac.id','ROLE_PEND', true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PEND42','password42','pend42@ui.ac.id','ROLE_PEND', true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PEND43','password43','pend43@ui.ac.id','ROLE_PEND', true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PEND44','password44','pend44@ui.ac.id','ROLE_PEND', true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PEND45','password45','pend45@ui.ac.id','ROLE_PEND', true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PEND46','password46','pend46@ui.ac.id','ROLE_PEND', true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PEND47','password47','pend47@ui.ac.id','ROLE_PEND', true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PEND48','password48','pend48@ui.ac.id','ROLE_PEND', true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PEND49','password49','pend49@ui.ac.id','ROLE_PEND', true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PEND50','password50','pend50@ui.ac.id','ROLE_PEND', true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PEND51','password51','pend51@ui.ac.id','ROLE_PEND', true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PEND52','password52','pend52@ui.ac.id','ROLE_PEND', true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PEND53','password53','pend53@ui.ac.id','ROLE_PEND', true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PEND54','password54','pend54@ui.ac.id','ROLE_PEND', true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PEND55','password55','pend55@ui.ac.id','ROLE_PEND', true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PEND56','password56','pend56@ui.ac.id','ROLE_PEND', true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PEND57','password57','pend57@ui.ac.id','ROLE_PEND', true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PEND58','password58','pend58@ui.ac.id','ROLE_PEND', true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PEND59','password59','pend59@ui.ac.id','ROLE_PEND', true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PEND60','password60','pend60@ui.ac.id','ROLE_PEND', true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PEND61','password61','pend61@ui.ac.id','ROLE_PEND', true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PEND62','password62','pend62@ui.ac.id','ROLE_PEND', true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PEND63','password63','pend63@ui.ac.id','ROLE_PEND', true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PEND64','password64','pend64@ui.ac.id','ROLE_PEND', true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PEND65','password65','pend65@ui.ac.id','ROLE_PEND', true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PEND66','password66','pend66@ui.ac.id','ROLE_PEND', true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PEND67','password67','pend67@ui.ac.id','ROLE_PEND', true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PEND68','password68','pend68@ui.ac.id','ROLE_PEND', true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PEND69','password69','pend69@ui.ac.id','ROLE_PEND', true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PEND70','password70','pend70@ui.ac.id','ROLE_PEND', true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PEND71','password71','pend71@ui.ac.id','ROLE_PEND', true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PEND72','password72','pend72@ui.ac.id','ROLE_PEND', true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PEND73','password73','pend73@ui.ac.id','ROLE_PEND', true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PEND74','password74','pend74@ui.ac.id','ROLE_PEND', true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PEND75','password75','pend75@ui.ac.id','ROLE_PEND', true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PEND76','password76','pend76@ui.ac.id','ROLE_PEND', true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PEND77','password77','pend77@ui.ac.id','ROLE_PEND', true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PEND78','password78','pend78@ui.ac.id','ROLE_PEND', true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PEND79','password79','pend79@ui.ac.id','ROLE_PEND', true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PEND80','password80','pend80@ui.ac.id','ROLE_PEND', true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PENGU81','password81','pengu81@ui.ac.id','ROLE_PENG_U',true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PENGU82','password82','pengu82@ui.ac.id','ROLE_PENG_U',true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PENGU83','password83','pengu83@ui.ac.id','ROLE_PENG_U',true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PENGU84','password84','pengu84@ui.ac.id','ROLE_PENG_U',true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PENGU85','password85','pengu85@ui.ac.id','ROLE_PENG_U',true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PENGU86','password86','pengu86@ui.ac.id','ROLE_PENG_U',true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PENGU87','password87','pengu87@ui.ac.id','ROLE_PENG_U',true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PENGU88','password88','pengu88@ui.ac.id','ROLE_PENG_U',true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PENGU89','password89','pengu89@ui.ac.id','ROLE_PENG_U',true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PENGU90','password90','pengu90@ui.ac.id','ROLE_PENG_U',true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PENGU91','password91','pengu91@ui.ac.id','ROLE_PENG_U',true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PENGU92','password92','pengu92@ui.ac.id','ROLE_PENG_U',true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PENGU93','password93','pengu93@ui.ac.id','ROLE_PENG_U',true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PENGU94','password94','pengu94@ui.ac.id','ROLE_PENG_U',true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PENGU95','password95','pengu95@ui.ac.id','ROLE_PENG_U',true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PENGU96','password96','pengu96@ui.ac.id','ROLE_PENG_U',true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PENGU97','password97','pengu97@ui.ac.id','ROLE_PENG_U',true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PENGU98','password98','pengu98@ui.ac.id','ROLE_PENG_U',true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PENGU99','password99','pengu99@ui.ac.id','ROLE_PENG_U',true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PENGU100','password100','pengu100@ui.ac.id','ROLE_PENG_U',true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PENGU101','password101','pengu101@ui.ac.id','ROLE_PENG_U',true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PENGU102','password102','pengu102@ui.ac.id','ROLE_PENG_U',true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PENGU103','password103','pengu103@ui.ac.id','ROLE_PENG_U',true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PENGU104','password104','pengu104@ui.ac.id','ROLE_PENG_U',true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PENGU105','password105','pengu105@ui.ac.id','ROLE_PENG_U',true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PENGU106','password106','pengu106@ui.ac.id','ROLE_PENG_U',true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PENGU107','password107','pengu107@ui.ac.id','ROLE_PENG_U',true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PENGU108','password108','pengu108@ui.ac.id','ROLE_PENG_U',true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PENGU109','password109','pengu109@ui.ac.id','ROLE_PENG_U',true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PENGU110','password110','pengu110@ui.ac.id','ROLE_PENG_U',true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PENGU111','password111','pengu111@ui.ac.id','ROLE_PENG_U',true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PENGU112','password112','pengu112@ui.ac.id','ROLE_PENG_U',true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PENGU113','password113','pengu113@ui.ac.id','ROLE_PENG_U',true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PENGU114','password114','pengu114@ui.ac.id','ROLE_PENG_U',true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PENGU115','password115','pengu115@ui.ac.id','ROLE_PENG',true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PENGU116','password116','pengu116@ui.ac.id','ROLE_PENG',true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PENGU117','password117','pengu117@ui.ac.id','ROLE_PENG',true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PENGU118','password118','pengu118@ui.ac.id','ROLE_PENG',true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PENGU119','password119','pengu119@ui.ac.id','ROLE_PENG',true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PENGU120','password120','pengu120@ui.ac.id','ROLE_PENG',true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PENGU121','password121','pengu121@ui.ac.id','ROLE_PENG',true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PENGU122','password122','pengu122@ui.ac.id','ROLE_PENG',true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PENGU123','password123','pengu123@ui.ac.id','ROLE_PENG',true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PENGU124','password124','pengu124@ui.ac.id','ROLE_PENG',true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PENGU125','password125','pengu125@ui.ac.id','ROLE_PENG',true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PENGU126','password126','pengu126@ui.ac.id','ROLE_PENG',true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PENGU127','password127','pengu127@ui.ac.id','ROLE_PENG',true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PENGU128','password128','pengu128@ui.ac.id','ROLE_PENG',true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PENGU129','password129','pengu129@ui.ac.id','ROLE_PENG',true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PENGU130','password130','pengu130@ui.ac.id','ROLE_PENG',true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PENGU131','password131','pengu131@ui.ac.id','ROLE_PENG',true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PENGU132','password132','pengu132@ui.ac.id','ROLE_PENG',true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PENGU133','password133','pengu133@ui.ac.id','ROLE_PENG',true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PENGU134','password134','pengu134@ui.ac.id','ROLE_PENG',true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PENGU135','password135','pengu135@ui.ac.id','ROLE_PENG',true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PENGU136','password136','pengu136@ui.ac.id','ROLE_PENG',true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PENGU137','password137','pengu137@ui.ac.id','ROLE_PENG',true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PENGU138','password138','pengu138@ui.ac.id','ROLE_PENG',true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PENGU139','password139','pengu139@ui.ac.id','ROLE_PENG',true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PENGU140','password140','pengu140@ui.ac.id','ROLE_PENG',true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PENGU141','password141','pengu141@ui.ac.id','ROLE_PENG',true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PENGU142','password142','pengu142@ui.ac.id','ROLE_PENG',true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PENGU143','password143','pengu143@ui.ac.id','ROLE_PENG',true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PENGU144','password144','pengu144@ui.ac.id','ROLE_PENG',true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PENGU145','password145','pengu145@ui.ac.id','ROLE_PENG',true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PENGU146','password146','pengu146@ui.ac.id','ROLE_PENG',true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PENGU147','password147','pengu147@ui.ac.id','ROLE_PENG',true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PENGU148','password148','pengu148@ui.ac.id','ROLE_PENG',true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PEND149','password149','pend149@ui.ac.id','ROLE_PEND',true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PEND150','password150','pend150@ui.ac.id','ROLE_PEND',true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PEND151','password151','pend151@ui.ac.id','ROLE_PEND',true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PEND152','password152','pend152@ui.ac.id','ROLE_PEND',true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PEND153','password153','pend153@ui.ac.id','ROLE_PEND',true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PEND154','password154','pend154@ui.ac.id','ROLE_PEND',true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PEND155','password155','pend155@ui.ac.id','ROLE_PEND',true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PEND156','password156','pend156@ui.ac.id','ROLE_PEND',true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PEND157','password157','pend157@ui.ac.id','ROLE_PEND',true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PEND158','password158','pend158@ui.ac.id','ROLE_PEND',true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PEND159','password159','pend159@ui.ac.id','ROLE_PEND',true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PEND160','password160','pend160@ui.ac.id','ROLE_PEND',true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PEND161','password161','pend161@ui.ac.id','ROLE_PEND',true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PEND162','password162','pend162@ui.ac.id','ROLE_PEND',true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PEND163','password163','pend163@ui.ac.id','ROLE_PEND',true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PEND164','password164','pend164@ui.ac.id','ROLE_PEND',true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PEND165','password165','pend165@ui.ac.id','ROLE_PEND',true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PEND166','password166','pend166@ui.ac.id','ROLE_PEND',true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PEND167','password167','pend167@ui.ac.id','ROLE_PEND',true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PEND168','password168','pend168@ui.ac.id','ROLE_PEND',true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PEND169','password169','pend169@ui.ac.id','ROLE_PEND',true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PEND170','password170','pend170@ui.ac.id','ROLE_PEND',true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PEND171','password171','pend171@ui.ac.id','ROLE_PEND',true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PEND172','password172','pend172@ui.ac.id','ROLE_PEND',true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PEND173','password173','pend173@ui.ac.id','ROLE_PEND',true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PEND174','password174','pend174@ui.ac.id','ROLE_PEND',true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PEND175','password175','pend175@ui.ac.id','ROLE_PEND',true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PEND176','password176','pend176@ui.ac.id','ROLE_PEND',true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PEND177','password177','pend177@ui.ac.id','ROLE_PEND',true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PEND178','password178','pend178@ui.ac.id','ROLE_PEND',true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PEND179','password179','pend179@ui.ac.id','ROLE_PEND',true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PEND180','password180','pend180@ui.ac.id','ROLE_PEND',true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PEND181','password181','pend181@ui.ac.id','ROLE_PEND',true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PEND182','password182','pend182@ui.ac.id','ROLE_PEND',true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PEND183','password183','pend183@ui.ac.id','ROLE_PEND',true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PEND184','password184','pend184@ui.ac.id','ROLE_PEND',true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PEND185','password185','pend185@ui.ac.id','ROLE_PEND',true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PEND186','password186','pend186@ui.ac.id','ROLE_PEND',true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PEND187','password187','pend187@ui.ac.id','ROLE_PEND',true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PEND188','password188','pend188@ui.ac.id','ROLE_PEND',true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PEND189','password189','pend189@ui.ac.id','ROLE_PEND',true);
INSERT INTO USER (username,password,email,role,enabled) VALUES ('PEND190','password190','pend190@ui.ac.id','ROLE_PEND',true);

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
INSERT INTO NEGARA (nama_negara) VALUES ('Jepang');
INSERT INTO NEGARA (nama_negara) VALUES ('Korea Selatan');
INSERT INTO NEGARA (nama_negara) VALUES ('Australia');
INSERT INTO NEGARA (nama_negara) VALUES ('Thailand');
INSERT INTO NEGARA (nama_negara) VALUES ('Vietnam');
INSERT INTO NEGARA (nama_negara) VALUES ('Laos');
INSERT INTO NEGARA (nama_negara) VALUES ('Filipina');

INSERT INTO PROVINSI (id_provinsi, id_negara, nama_provinsi) VALUES
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

INSERT INTO KOTA (id_kota, id_provinsi, nama_kota) VALUES
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

INSERT INTO LEMBAGA_PENDIDIKAN_TERAKHIR (id_user,nama_lembaga,nama_provinsi,nama_kota) VALUES
(5,'MTS Pramudito','DKI Jakarta','Jakarta Timur'),
(13,'SMAN 1000','Jawa Barat','Depok'),
(14,'SMAN 1001','DKI Jakarta','Jakarta Utara'),
(15,'SMAN 1002','DKI Jakarta','Jakarta Selatan'),
(16,'SMAK Pelita Jaya','Jawa Barat','Bogor'),
(17,'SMAN 209','Sumatera Barat','Bukittinggi'),
(18,'SMA Al-Makmuriah','Jawa Timur','Surabaya'),
(19,'Irving High School','DKI Jakarta','Jakarta Selatan'),
(20,'SLB Kami','DKI Jakarta','Jakarta Barat'),
(21,'SMAN 888','Yogyakarta','Yogyakarta');

INSERT INTO PENDAFTAR (id_user,no_id,nama_id,nama_ijazah,foto,no_hp,no_telp,nama_negara,kewarganegaraan,alamat_tetap,jenis_id,alamat_sekarang,tgl_lahir,nama_provinsi,nama_kota,jenis_kelamin,nama_lembaga,jurusan) VALUES (4,'1706520000','Pendaftar1','Pendaftar1i','foto1.jpg','82124360370','7987325','Indonesia','WNI','Jl. Juragan Sinda','KTP','Jl. Padepokan Timur','1999-07-24','Jawa Barat','Depok',1,"SMA 10 Padang",'IPA');
INSERT INTO PENDAFTAR (id_user,no_id,nama_id,nama_ijazah,foto,no_hp,no_telp,nama_negara,kewarganegaraan,alamat_tetap,jenis_id,alamat_sekarang,tgl_lahir,nama_provinsi,nama_kota,jenis_kelamin,nama_lembaga,jurusan) VALUES (7,'1706521090','Pendaftar2','Pendaftar2i','foto2.png','82124360371','7987326','Malaysia','WNA','Jl. Zimbabwe','SIM','Jl. Mangga Besar','2000-08-29','Dan lain-lain','Dan lain-lain',1,"Dummy High School",'IPA');
INSERT INTO PENDAFTAR (id_user,no_id,nama_id,nama_ijazah,foto,no_hp,no_telp,nama_negara,kewarganegaraan,alamat_tetap,jenis_id,alamat_sekarang,tgl_lahir,nama_provinsi,nama_kota,jenis_kelamin,nama_lembaga,jurusan) VALUES (8,'8906528000','Pendaftar3','Pendaftar3i','foto3.jpeg','82124360372','7987327','Indonesia','WNI','Jl. In Aja Dulu','KTP','Jl. Indah','2000-04-03','DKI Jakarta','Jakarta Selatan',0,"SMA 10 Padang",'IPA');
INSERT INTO PENDAFTAR (id_user,no_id,nama_id,nama_ijazah,foto,no_hp,no_telp,nama_negara,kewarganegaraan,alamat_tetap,jenis_id,alamat_sekarang,tgl_lahir,nama_provinsi,nama_kota,jenis_kelamin,nama_lembaga,jurusan) VALUES (9,'81706520110','Pendaftar4','Pendaftar4i','foto4.png','82124360373','7987328','Indonesia','WNI','Jl. Kebenaran','KTP','Jl. Besar','1999-01-19','Banten','Tangerang',0,"SMA 112 Jakarta",'IPS');
INSERT INTO PENDAFTAR (id_user,no_id,nama_id,nama_ijazah,foto,no_hp,no_telp,nama_negara,kewarganegaraan,alamat_tetap,jenis_id,alamat_sekarang,tgl_lahir,nama_provinsi,nama_kota,jenis_kelamin,nama_lembaga,jurusan) VALUES (10,'71896520001','Pendaftar5','Pendaftar5i','foto5.jpg','82124360374','7987329','Singapura','WNA','Jl. Lurus','KTP','Jl. Kecil','1999-11-11','Dan lain-lain','Dan lain-lain',1,null,null);
INSERT INTO PENDAFTAR (id_user,no_id,nama_id,nama_ijazah,foto,no_hp,no_telp,nama_negara,kewarganegaraan,alamat_tetap,jenis_id,alamat_sekarang,tgl_lahir,nama_provinsi,nama_kota,jenis_kelamin,nama_lembaga,jurusan) VALUES (22,'895473347809','Pendaftar22','Pendaftar22','foto22','82124360374','7987329','Indonesia','WNI','Jl. Tes 1','KTP','Jl. Tes2 57','1999-07-18','Jawa Barat','Depok',1,"SMA 412 Jakarta",'IPA');
INSERT INTO PENDAFTAR (id_user,no_id,nama_id,nama_ijazah,foto,no_hp,no_telp,nama_negara,kewarganegaraan,alamat_tetap,jenis_id,alamat_sekarang,tgl_lahir,nama_provinsi,nama_kota,jenis_kelamin,nama_lembaga,jurusan) VALUES (23,'895473347810','Pendaftar23','Pendaftar23','foto23','82124360375','7987330','Indonesia','WNI','Jl. Tes 2','KTP','Jl. Tes2 56','1999-07-19','DKI Jakarta','Jakarta Timur',1,"SMA 312 Jakarta",'IPA');
INSERT INTO PENDAFTAR (id_user,no_id,nama_id,nama_ijazah,foto,no_hp,no_telp,nama_negara,kewarganegaraan,alamat_tetap,jenis_id,alamat_sekarang,tgl_lahir,nama_provinsi,nama_kota,jenis_kelamin,nama_lembaga,jurusan) VALUES (24,'895473347811','Pendaftar24','Pendaftar24','foto24','82124360376','7987331','Indonesia','WNI','Jl. Tes 3','KTP','Jl. Tes2 55','1999-07-20','DKI Jakarta','Jakarta Selatan',1,"SMA 31 Jakarta",'IPA');
INSERT INTO PENDAFTAR (id_user,no_id,nama_id,nama_ijazah,foto,no_hp,no_telp,nama_negara,kewarganegaraan,alamat_tetap,jenis_id,alamat_sekarang,tgl_lahir,nama_provinsi,nama_kota,jenis_kelamin,nama_lembaga,jurusan) VALUES (25,'895473347812','Pendaftar25','Pendaftar25','foto25','82124360377','7987332','Indonesia','WNI','Jl. Tes 4','KTP','Jl. Tes2 54','1999-07-21','DKI Jakarta','Jakarta Barat',1,"SMA 10 Padang",'IPS');
INSERT INTO PENDAFTAR (id_user,no_id,nama_id,nama_ijazah,foto,no_hp,no_telp,nama_negara,kewarganegaraan,alamat_tetap,jenis_id,alamat_sekarang,tgl_lahir,nama_provinsi,nama_kota,jenis_kelamin,nama_lembaga,jurusan) VALUES (26,'895473347813','Pendaftar26','Pendaftar26','foto26','82124360378','7987333','Indonesia','WNI','Jl. Tes 5','KTP','Jl. Tes2 53','1999-07-22','DKI Jakarta','Jakarta Selatan',1,"SMA 10 Padang",'IPS');
INSERT INTO PENDAFTAR (id_user,no_id,nama_id,nama_ijazah,foto,no_hp,no_telp,nama_negara,kewarganegaraan,alamat_tetap,jenis_id,alamat_sekarang,tgl_lahir,nama_provinsi,nama_kota,jenis_kelamin,nama_lembaga,jurusan) VALUES (27,'895473347814','Pendaftar27','Pendaftar27','foto27','82124360379','7987334','Indonesia','WNI','Jl. Tes 6','KTP','Jl. Tes2 52','1999-07-23','DKI Jakarta','Jakarta Utara',1,"SMA 10 Padang",'IPS');
INSERT INTO PENDAFTAR (id_user,no_id,nama_id,nama_ijazah,foto,no_hp,no_telp,nama_negara,kewarganegaraan,alamat_tetap,jenis_id,alamat_sekarang,tgl_lahir,nama_provinsi,nama_kota,jenis_kelamin,nama_lembaga,jurusan) VALUES (28,'895473347815','Pendaftar28','Pendaftar28','foto28','82124360380','7987335','Indonesia','WNI','Jl. Tes 7','KTP','Jl. Tes2 51','1999-07-24','Jawa Timur','Surabaya',1,"SMA 10 Padang",'IPS');
INSERT INTO PENDAFTAR (id_user,no_id,nama_id,nama_ijazah,foto,no_hp,no_telp,nama_negara,kewarganegaraan,alamat_tetap,jenis_id,alamat_sekarang,tgl_lahir,nama_provinsi,nama_kota,jenis_kelamin,nama_lembaga,jurusan) VALUES (29,'895473347816','Pendaftar29','Pendaftar29','foto29','82124360381','7987336','Indonesia','WNI','Jl. Tes 8','KTP','Jl. Tes2 50','1999-07-25','Kalimantan Selatan','Banjarmasin',0,"SMA 10 Padang",'IPS');
INSERT INTO PENDAFTAR (id_user,no_id,nama_id,nama_ijazah,foto,no_hp,no_telp,nama_negara,kewarganegaraan,alamat_tetap,jenis_id,alamat_sekarang,tgl_lahir,nama_provinsi,nama_kota,jenis_kelamin,nama_lembaga,jurusan) VALUES (30,'895473347817','Pendaftar30','Pendaftar30','foto30','82124360382','7987337','Indonesia','WNI','Jl. Tes 9','KTP','Jl. Tes2 49','1999-07-26','Yogyakarta','Yogyakarta',0,"SMA 10 Padang",'IPA');
INSERT INTO PENDAFTAR (id_user,no_id,nama_id,nama_ijazah,foto,no_hp,no_telp,nama_negara,kewarganegaraan,alamat_tetap,jenis_id,alamat_sekarang,tgl_lahir,nama_provinsi,nama_kota,jenis_kelamin,nama_lembaga,jurusan) VALUES (31,'895473347818','Pendaftar31','Pendaftar31','foto31','82124360383','7987338','Indonesia','WNI','Jl. Tes 10','KTP','Jl. Tes2 48','1999-07-27','Aceh','Aceh',0,"SMA 10 Padang",'IPA');
INSERT INTO PENDAFTAR (id_user,no_id,nama_id,nama_ijazah,foto,no_hp,no_telp,nama_negara,kewarganegaraan,alamat_tetap,jenis_id,alamat_sekarang,tgl_lahir,nama_provinsi,nama_kota,jenis_kelamin,nama_lembaga,jurusan) VALUES (32,'895473347819','Pendaftar32','Pendaftar32','foto32','82124360384','7987339','Indonesia','WNI','Jl. Tes 11','KTP','Jl. Tes2 47','1999-07-28','Jawa Tengah','Semarang',0,"SMA 10 Padang",'IPA');
INSERT INTO PENDAFTAR (id_user,no_id,nama_id,nama_ijazah,foto,no_hp,no_telp,nama_negara,kewarganegaraan,alamat_tetap,jenis_id,alamat_sekarang,tgl_lahir,nama_provinsi,nama_kota,jenis_kelamin,nama_lembaga,jurusan) VALUES (33,'895473347820','Pendaftar33','Pendaftar33','foto33','82124360385','7987340','Indonesia','WNI','Jl. Tes 12','KTP','Jl. Tes2 46','1999-07-29','Sumatera Barat','Bukittinggi',0,"SMA 10 Padang",'IPA');
INSERT INTO PENDAFTAR (id_user,no_id,nama_id,nama_ijazah,foto,no_hp,no_telp,nama_negara,kewarganegaraan,alamat_tetap,jenis_id,alamat_sekarang,tgl_lahir,nama_provinsi,nama_kota,jenis_kelamin,nama_lembaga,jurusan) VALUES (34,'895473347821','Pendaftar34','Pendaftar34','foto34','82124360386','7987341','Indonesia','WNI','Jl. Tes 13','KTP','Jl. Tes2 45','1999-07-30','Sumatera Utara','Medan',0,"SMA 10 Padang",'IPA');
INSERT INTO PENDAFTAR (id_user,no_id,nama_id,nama_ijazah,foto,no_hp,no_telp,nama_negara,kewarganegaraan,alamat_tetap,jenis_id,alamat_sekarang,tgl_lahir,nama_provinsi,nama_kota,jenis_kelamin,nama_lembaga,jurusan) VALUES (35,'895473347822','Pendaftar35','Pendaftar35','foto35','82124360387','7987342','Indonesia','WNI','Jl. Tes 14','KTP','Jl. Tes2 44','1999-01-01','DKI Jakarta','Jakarta Selatan',0,"SMA 10 Padang",'IPA');
INSERT INTO PENDAFTAR (id_user,no_id,nama_id,nama_ijazah,foto,no_hp,no_telp,nama_negara,kewarganegaraan,alamat_tetap,jenis_id,alamat_sekarang,tgl_lahir,nama_provinsi,nama_kota,jenis_kelamin,nama_lembaga,jurusan) VALUES (36,'895473347823','Pendaftar36','Pendaftar36','foto36','82124360388','7987343','Singapura','WNA','Jl. Tes 15','Paspor','Jl. Tes2 43','1999-01-02','Dan lain-lain','Dan lain-lain',0,"Dummy High School",'IPA');
INSERT INTO PENDAFTAR (id_user,no_id,nama_id,nama_ijazah,foto,no_hp,no_telp,nama_negara,kewarganegaraan,alamat_tetap,jenis_id,alamat_sekarang,tgl_lahir,nama_provinsi,nama_kota,jenis_kelamin,nama_lembaga,jurusan) VALUES (37,'895473347824','Pendaftar37','Pendaftar37','foto37','82124360389','7987344','Singapura','WNA','Jl. Tes 16','Paspor','Jl. Tes2 42','1999-01-03','Dan lain-lain','Dan lain-lain',0,"Dummy High School",'IPA');
INSERT INTO PENDAFTAR (id_user,no_id,nama_id,nama_ijazah,foto,no_hp,no_telp,nama_negara,kewarganegaraan,alamat_tetap,jenis_id,alamat_sekarang,tgl_lahir,nama_provinsi,nama_kota,jenis_kelamin,nama_lembaga,jurusan) VALUES (38,'895473347825','Pendaftar38','Pendaftar38','foto38','82124360390','7987345','Singapura','WNA','Jl. Tes 17','Paspor','Jl. Tes2 41','1999-01-04','Dan lain-lain','Dan lain-lain',0,"Dummy High School",'IPA');
INSERT INTO PENDAFTAR (id_user,no_id,nama_id,nama_ijazah,foto,no_hp,no_telp,nama_negara,kewarganegaraan,alamat_tetap,jenis_id,alamat_sekarang,tgl_lahir,nama_provinsi,nama_kota,jenis_kelamin,nama_lembaga,jurusan) VALUES (39,'895473347826','Pendaftar39','Pendaftar39','foto39','82124360391','7987346','Singapura','WNA','Jl. Tes 18','Paspor','Jl. Tes2 40','1999-01-05','Dan lain-lain','Dan lain-lain',0,"Dummy High School",'IPA');
INSERT INTO PENDAFTAR (id_user,no_id,nama_id,nama_ijazah,foto,no_hp,no_telp,nama_negara,kewarganegaraan,alamat_tetap,jenis_id,alamat_sekarang,tgl_lahir,nama_provinsi,nama_kota,jenis_kelamin,nama_lembaga,jurusan) VALUES (40,'895473347827','Pendaftar40','Pendaftar40','foto40','82124360392','7987347','Singapura','WNA','Jl. Tes 19','Paspor','Jl. Tes2 39','1999-01-06','Dan lain-lain','Dan lain-lain',1,"Dummy High School",'IPA');
INSERT INTO PENDAFTAR (id_user,no_id,nama_id,nama_ijazah,foto,no_hp,no_telp,nama_negara,kewarganegaraan,alamat_tetap,jenis_id,alamat_sekarang,tgl_lahir,nama_provinsi,nama_kota,jenis_kelamin,nama_lembaga,jurusan) VALUES (41,'895473347828','Pendaftar41','Pendaftar41','foto41','82124360393','7987348','Singapura','WNA','Jl. Tes 20','Paspor','Jl. Tes2 38','1999-01-07','Dan lain-lain','Dan lain-lain',1,"Dummy High School",'IPA');
INSERT INTO PENDAFTAR (id_user,no_id,nama_id,nama_ijazah,foto,no_hp,no_telp,nama_negara,kewarganegaraan,alamat_tetap,jenis_id,alamat_sekarang,tgl_lahir,nama_provinsi,nama_kota,jenis_kelamin,nama_lembaga,jurusan) VALUES (42,'895473347829','Pendaftar42','Pendaftar42','foto42','82124360394','7987349','Singapura','WNA','Jl. Tes 21','Paspor','Jl. Tes2 37','1999-01-08','Dan lain-lain','Dan lain-lain',1,"Dummy High School",'IPA');
INSERT INTO PENDAFTAR (id_user,no_id,nama_id,nama_ijazah,foto,no_hp,no_telp,nama_negara,kewarganegaraan,alamat_tetap,jenis_id,alamat_sekarang,tgl_lahir,nama_provinsi,nama_kota,jenis_kelamin,nama_lembaga,jurusan) VALUES (43,'895473347830','Pendaftar43','Pendaftar43','foto43','82124360395','7987350','Singapura','WNA','Jl. Tes 22','Paspor','Jl. Tes2 36','1999-01-09','Dan lain-lain','Dan lain-lain',0,"Dummy High School",'IPA');
INSERT INTO PENDAFTAR (id_user,no_id,nama_id,nama_ijazah,foto,no_hp,no_telp,nama_negara,kewarganegaraan,alamat_tetap,jenis_id,alamat_sekarang,tgl_lahir,nama_provinsi,nama_kota,jenis_kelamin,nama_lembaga,jurusan) VALUES (44,'895473347831','Pendaftar44','Pendaftar44','foto44','82124360396','7987351','Singapura','WNA','Jl. Tes 23','Paspor','Jl. Tes2 35','1999-01-10','Dan lain-lain','Dan lain-lain',0,"Dummy High School",'IPA');
INSERT INTO PENDAFTAR (id_user,no_id,nama_id,nama_ijazah,foto,no_hp,no_telp,nama_negara,kewarganegaraan,alamat_tetap,jenis_id,alamat_sekarang,tgl_lahir,nama_provinsi,nama_kota,jenis_kelamin,nama_lembaga,jurusan) VALUES (45,'895473347832','Pendaftar45','Pendaftar45','foto45','82124360397','7987352','Singapura','WNA','Jl. Tes 24','Paspor','Jl. Tes2 34','1999-01-11','Dan lain-lain','Dan lain-lain',0,"Dummy High School",'IPA');
INSERT INTO PENDAFTAR (id_user,no_id,nama_id,nama_ijazah,foto,no_hp,no_telp,nama_negara,kewarganegaraan,alamat_tetap,jenis_id,alamat_sekarang,tgl_lahir,nama_provinsi,nama_kota,jenis_kelamin,nama_lembaga,jurusan) VALUES (46,'895473347833','Pendaftar46','Pendaftar46','foto46','82124360398','7987353','Singapura','WNA','Jl. Tes 25','Paspor','Jl. Tes2 33','1999-01-12','Dan lain-lain','Dan lain-lain',0,"Dummy High School",'IPA');
INSERT INTO PENDAFTAR (id_user,no_id,nama_id,nama_ijazah,foto,no_hp,no_telp,nama_negara,kewarganegaraan,alamat_tetap,jenis_id,alamat_sekarang,tgl_lahir,nama_provinsi,nama_kota,jenis_kelamin,nama_lembaga,jurusan) VALUES (47,'895473347834','Pendaftar47','Pendaftar47','foto47','82124360399','7987354','Singapura','WNA','Jl. Tes 26','Paspor','Jl. Tes2 32','1999-01-13','Dan lain-lain','Dan lain-lain',0,"Dummy High School",'IPA');
INSERT INTO PENDAFTAR (id_user,no_id,nama_id,nama_ijazah,foto,no_hp,no_telp,nama_negara,kewarganegaraan,alamat_tetap,jenis_id,alamat_sekarang,tgl_lahir,nama_provinsi,nama_kota,jenis_kelamin,nama_lembaga,jurusan) VALUES (48,'895473347835','Pendaftar48','Pendaftar48','foto48','82124360400','7987355','Singapura','WNA','Jl. Tes 27','Paspor','Jl. Tes2 31','1999-01-14','Dan lain-lain','Dan lain-lain',1,"Dummy High School",'IPA');
INSERT INTO PENDAFTAR (id_user,no_id,nama_id,nama_ijazah,foto,no_hp,no_telp,nama_negara,kewarganegaraan,alamat_tetap,jenis_id,alamat_sekarang,tgl_lahir,nama_provinsi,nama_kota,jenis_kelamin,nama_lembaga,jurusan) VALUES (49,'895473347836','Pendaftar49','Pendaftar49','foto49','82124360401','7987356','Malaysia','WNA','Jl. Tes 28','Paspor','Jl. Tes2 30','1999-01-15','Dan lain-lain','Dan lain-lain',1,"Dummy High School",'IPA');
INSERT INTO PENDAFTAR (id_user,no_id,nama_id,nama_ijazah,foto,no_hp,no_telp,nama_negara,kewarganegaraan,alamat_tetap,jenis_id,alamat_sekarang,tgl_lahir,nama_provinsi,nama_kota,jenis_kelamin,nama_lembaga,jurusan) VALUES (50,'895473347837','Pendaftar50','Pendaftar50','foto50','82124360402','7987357','Malaysia','WNA','Jl. Tes 29','Paspor','Jl. Tes2 29','1999-01-16','Dan lain-lain','Dan lain-lain',1,"Dummy High School",'IPA');
INSERT INTO PENDAFTAR (id_user,no_id,nama_id,nama_ijazah,foto,no_hp,no_telp,nama_negara,kewarganegaraan,alamat_tetap,jenis_id,alamat_sekarang,tgl_lahir,nama_provinsi,nama_kota,jenis_kelamin,nama_lembaga,jurusan) VALUES (51,'895473347838','Pendaftar51','Pendaftar51','foto51','82124360403','7987358','Malaysia','WNA','Jl. Tes 30','Paspor','Jl. Tes2 28','1999-01-17','Dan lain-lain','Dan lain-lain',1,"Dummy High School",'IPA');
INSERT INTO PENDAFTAR (id_user,no_id,nama_id,nama_ijazah,foto,no_hp,no_telp,nama_negara,kewarganegaraan,alamat_tetap,jenis_id,alamat_sekarang,tgl_lahir,nama_provinsi,nama_kota,jenis_kelamin,nama_lembaga,jurusan) VALUES (52,'895473347839','Pendaftar52','Pendaftar52','foto52','82124360404','7987359','Malaysia','WNA','Jl. Tes 31','Paspor','Jl. Tes2 27','1999-01-18','Dan lain-lain','Dan lain-lain',1,"Dummy High School",'IPA');
INSERT INTO PENDAFTAR (id_user,no_id,nama_id,nama_ijazah,foto,no_hp,no_telp,nama_negara,kewarganegaraan,alamat_tetap,jenis_id,alamat_sekarang,tgl_lahir,nama_provinsi,nama_kota,jenis_kelamin,nama_lembaga,jurusan) VALUES (53,'895473347840','Pendaftar53','Pendaftar53','foto53','82124360405','7987360','Malaysia','WNA','Jl. Tes 32','Paspor','Jl. Tes2 26','1999-01-19','Dan lain-lain','Dan lain-lain',1,"Dummy High School",'IPA');
INSERT INTO PENDAFTAR (id_user,no_id,nama_id,nama_ijazah,foto,no_hp,no_telp,nama_negara,kewarganegaraan,alamat_tetap,jenis_id,alamat_sekarang,tgl_lahir,nama_provinsi,nama_kota,jenis_kelamin,nama_lembaga,jurusan) VALUES (54,'895473347841','Pendaftar54','Pendaftar54','foto54','82124360406','7987361','Malaysia','WNA','Jl. Tes 33','Paspor','Jl. Tes2 25','1999-01-20','Dan lain-lain','Dan lain-lain',1,"Dummy High School",'IPA');
INSERT INTO PENDAFTAR (id_user,no_id,nama_id,nama_ijazah,foto,no_hp,no_telp,nama_negara,kewarganegaraan,alamat_tetap,jenis_id,alamat_sekarang,tgl_lahir,nama_provinsi,nama_kota,jenis_kelamin,nama_lembaga,jurusan) VALUES (55,'895473347842','Pendaftar55','Pendaftar55','foto55','82124360407','7987362','Malaysia','WNA','Jl. Tes 34','Paspor','Jl. Tes2 24','2000-03-04','Dan lain-lain','Dan lain-lain',1,"Dummy High School",'IPA');
INSERT INTO PENDAFTAR (id_user,no_id,nama_id,nama_ijazah,foto,no_hp,no_telp,nama_negara,kewarganegaraan,alamat_tetap,jenis_id,alamat_sekarang,tgl_lahir,nama_provinsi,nama_kota,jenis_kelamin,nama_lembaga,jurusan) VALUES (56,'895473347843','Pendaftar56','Pendaftar56','foto56','82124360408','7987363','Malaysia','WNA','Jl. Tes 35','Paspor','Jl. Tes2 23','2000-03-05','Dan lain-lain','Dan lain-lain',1,"Dummy High School",'IPA');
INSERT INTO PENDAFTAR (id_user,no_id,nama_id,nama_ijazah,foto,no_hp,no_telp,nama_negara,kewarganegaraan,alamat_tetap,jenis_id,alamat_sekarang,tgl_lahir,nama_provinsi,nama_kota,jenis_kelamin,nama_lembaga,jurusan) VALUES (57,'895473347844','Pendaftar57','Pendaftar57','foto57','82124360409','7987364','Malaysia','WNA','Jl. Tes 36','Paspor','Jl. Tes2 22','2000-03-06','Dan lain-lain','Dan lain-lain',1,"Dummy High School",'IPA');
INSERT INTO PENDAFTAR (id_user,no_id,nama_id,nama_ijazah,foto,no_hp,no_telp,nama_negara,kewarganegaraan,alamat_tetap,jenis_id,alamat_sekarang,tgl_lahir,nama_provinsi,nama_kota,jenis_kelamin,nama_lembaga,jurusan) VALUES (58,'895473347845','Pendaftar58','Pendaftar58','foto58','82124360410','7987365','Malaysia','WNA','Jl. Tes 37','Paspor','Jl. Tes2 21','2000-03-07','Dan lain-lain','Dan lain-lain',1,"Dummy High School",'IPA');
INSERT INTO PENDAFTAR (id_user,no_id,nama_id,nama_ijazah,foto,no_hp,no_telp,nama_negara,kewarganegaraan,alamat_tetap,jenis_id,alamat_sekarang,tgl_lahir,nama_provinsi,nama_kota,jenis_kelamin,nama_lembaga,jurusan) VALUES (59,'895473347846','Pendaftar59','Pendaftar59','foto59','82124360411','7987366','Malaysia','WNA','Jl. Tes 38','Paspor','Jl. Tes2 20','2000-03-08','Dan lain-lain','Dan lain-lain',1,"Dummy High School",'IPA');
INSERT INTO PENDAFTAR (id_user,no_id,nama_id,nama_ijazah,foto,no_hp,no_telp,nama_negara,kewarganegaraan,alamat_tetap,jenis_id,alamat_sekarang,tgl_lahir,nama_provinsi,nama_kota,jenis_kelamin,nama_lembaga,jurusan) VALUES (60,'895473347847','Pendaftar60','Pendaftar60','foto60','82124360412','7987367','Malaysia','WNA','Jl. Tes 39','Paspor','Jl. Tes2 19','2000-03-09','Dan lain-lain','Dan lain-lain',1,"Dummy High School",'IPA');
INSERT INTO PENDAFTAR (id_user,no_id,nama_id,nama_ijazah,foto,no_hp,no_telp,nama_negara,kewarganegaraan,alamat_tetap,jenis_id,alamat_sekarang,tgl_lahir,nama_provinsi,nama_kota,jenis_kelamin,nama_lembaga,jurusan) VALUES (61,'895473347848','Pendaftar61','Pendaftar61','foto61','82124360413','7987368','Malaysia','WNA','Jl. Tes 40','Paspor','Jl. Tes2 18','2000-03-10','Dan lain-lain','Dan lain-lain',1,"Dummy High School",'IPA');
INSERT INTO PENDAFTAR (id_user,no_id,nama_id,nama_ijazah,foto,no_hp,no_telp,nama_negara,kewarganegaraan,alamat_tetap,jenis_id,alamat_sekarang,tgl_lahir,nama_provinsi,nama_kota,jenis_kelamin,nama_lembaga,jurusan) VALUES (62,'895473347849','Pendaftar62','Pendaftar62','foto62','82124360414','7987369','Thailand','WNA','Jl. Tes 41','Paspor','Jl. Tes2 17','2000-03-11','Dan lain-lain','Dan lain-lain',1,"Dummy High School",'IPA');
INSERT INTO PENDAFTAR (id_user,no_id,nama_id,nama_ijazah,foto,no_hp,no_telp,nama_negara,kewarganegaraan,alamat_tetap,jenis_id,alamat_sekarang,tgl_lahir,nama_provinsi,nama_kota,jenis_kelamin,nama_lembaga,jurusan) VALUES (63,'895473347850','Pendaftar63','Pendaftar63','foto63','82124360415','7987370','Thailand','WNA','Jl. Tes 42','Paspor','Jl. Tes2 16','2000-03-12','Dan lain-lain','Dan lain-lain',0,"Dummy High School",'IPA');
INSERT INTO PENDAFTAR (id_user,no_id,nama_id,nama_ijazah,foto,no_hp,no_telp,nama_negara,kewarganegaraan,alamat_tetap,jenis_id,alamat_sekarang,tgl_lahir,nama_provinsi,nama_kota,jenis_kelamin,nama_lembaga,jurusan) VALUES (64,'895473347851','Pendaftar64','Pendaftar64','foto64','82124360416','7987371','Thailand','WNA','Jl. Tes 43','Paspor','Jl. Tes2 15','2000-03-13','Dan lain-lain','Dan lain-lain',0,"Dummy High School",'IPA');
INSERT INTO PENDAFTAR (id_user,no_id,nama_id,nama_ijazah,foto,no_hp,no_telp,nama_negara,kewarganegaraan,alamat_tetap,jenis_id,alamat_sekarang,tgl_lahir,nama_provinsi,nama_kota,jenis_kelamin,nama_lembaga,jurusan) VALUES (65,'895473347852','Pendaftar65','Pendaftar65','foto65','82124360417','7987372','Thailand','WNA','Jl. Tes 44','Paspor','Jl. Tes2 14','2000-03-14','Dan lain-lain','Dan lain-lain',0,"Dummy High School",'IPA');
INSERT INTO PENDAFTAR (id_user,no_id,nama_id,nama_ijazah,foto,no_hp,no_telp,nama_negara,kewarganegaraan,alamat_tetap,jenis_id,alamat_sekarang,tgl_lahir,nama_provinsi,nama_kota,jenis_kelamin,nama_lembaga,jurusan) VALUES (66,'895473347853','Pendaftar66','Pendaftar66','foto66','82124360418','7987373','Thailand','WNA','Jl. Tes 45','Paspor','Jl. Tes2 13','2000-03-15','Dan lain-lain','Dan lain-lain',0,"Dummy High School",'IPA');
INSERT INTO PENDAFTAR (id_user,no_id,nama_id,nama_ijazah,foto,no_hp,no_telp,nama_negara,kewarganegaraan,alamat_tetap,jenis_id,alamat_sekarang,tgl_lahir,nama_provinsi,nama_kota,jenis_kelamin,nama_lembaga,jurusan) VALUES (67,'895473347854','Pendaftar67','Pendaftar67','foto67','82124360419','7987374','Thailand','WNA','Jl. Tes 46','Paspor','Jl. Tes2 12','2000-03-16','Dan lain-lain','Dan lain-lain',0,"Dummy High School",'IPA');
INSERT INTO PENDAFTAR (id_user,no_id,nama_id,nama_ijazah,foto,no_hp,no_telp,nama_negara,kewarganegaraan,alamat_tetap,jenis_id,alamat_sekarang,tgl_lahir,nama_provinsi,nama_kota,jenis_kelamin,nama_lembaga,jurusan) VALUES (68,'895473347855','Pendaftar68','Pendaftar68','foto68','82124360420','7987375','Thailand','WNA','Jl. Tes 47','Paspor','Jl. Tes2 11','2000-03-17','Dan lain-lain','Dan lain-lain',0,"Dummy High School",'IPA');
INSERT INTO PENDAFTAR (id_user,no_id,nama_id,nama_ijazah,foto,no_hp,no_telp,nama_negara,kewarganegaraan,alamat_tetap,jenis_id,alamat_sekarang,tgl_lahir,nama_provinsi,nama_kota,jenis_kelamin,nama_lembaga,jurusan) VALUES (69,'895473347856','Pendaftar69','Pendaftar69','foto69','82124360421','7987376','Thailand','WNA','Jl. Tes 48','Paspor','Jl. Tes2 10','2000-03-18','Dan lain-lain','Dan lain-lain',0,"Dummy High School",'IPA');
INSERT INTO PENDAFTAR (id_user,no_id,nama_id,nama_ijazah,foto,no_hp,no_telp,nama_negara,kewarganegaraan,alamat_tetap,jenis_id,alamat_sekarang,tgl_lahir,nama_provinsi,nama_kota,jenis_kelamin,nama_lembaga,jurusan) VALUES (70,'895473347857','Pendaftar70','Pendaftar70','foto70','82124360422','7987377','Indonesia','WNI','Jl. Tes 49','SIM','Jl. Tes2 9','2000-03-19','Jawa Barat','Bandung',1,"SMA 312 Jakarta",'IPS');
INSERT INTO PENDAFTAR (id_user,no_id,nama_id,nama_ijazah,foto,no_hp,no_telp,nama_negara,kewarganegaraan,alamat_tetap,jenis_id,alamat_sekarang,tgl_lahir,nama_provinsi,nama_kota,jenis_kelamin,nama_lembaga,jurusan) VALUES (71,'895473347858','Pendaftar71','Pendaftar71','foto71','82124360423','7987378','Indonesia','WNI','Jl. Tes 50','SIM','Jl. Tes2 8','2000-03-20','DKI Jakarta','Jakarta Selatan',1,"SMA 34 Jakarta",'IPS');
INSERT INTO PENDAFTAR (id_user,no_id,nama_id,nama_ijazah,foto,no_hp,no_telp,nama_negara,kewarganegaraan,alamat_tetap,jenis_id,alamat_sekarang,tgl_lahir,nama_provinsi,nama_kota,jenis_kelamin,nama_lembaga,jurusan) VALUES (72,'895473347859','Pendaftar72','Pendaftar72','foto72','82124360424','7987379','Indonesia','WNI','Jl. Tes 51','SIM','Jl. Tes2 7','2000-03-21','DKI Jakarta','Jakarta Barat',1,"SMA 5 Jakarta",'IPS');
INSERT INTO PENDAFTAR (id_user,no_id,nama_id,nama_ijazah,foto,no_hp,no_telp,nama_negara,kewarganegaraan,alamat_tetap,jenis_id,alamat_sekarang,tgl_lahir,nama_provinsi,nama_kota,jenis_kelamin,nama_lembaga,jurusan) VALUES (73,'895473347860','Pendaftar73','Pendaftar73','foto73','82124360425','7987380','Indonesia','WNI','Jl. Tes 52','SIM','Jl. Tes2 6','1999-07-21','DKI Jakarta','Jakarta Timur',0,"SMA 40 Jakarta",'IPS');
INSERT INTO PENDAFTAR (id_user,no_id,nama_id,nama_ijazah,foto,no_hp,no_telp,nama_negara,kewarganegaraan,alamat_tetap,jenis_id,alamat_sekarang,tgl_lahir,nama_provinsi,nama_kota,jenis_kelamin,nama_lembaga,jurusan) VALUES (74,'895473347861','Pendaftar74','Pendaftar74','foto74','82124360426','7987381','Indonesia','WNI','Jl. Tes 53','SIM','Jl. Tes2 5','1999-07-22','Jawa Tengah','Semarang',0,"SMA 1 Jakarta",'IPS');
INSERT INTO PENDAFTAR (id_user,no_id,nama_id,nama_ijazah,foto,no_hp,no_telp,nama_negara,kewarganegaraan,alamat_tetap,jenis_id,alamat_sekarang,tgl_lahir,nama_provinsi,nama_kota,jenis_kelamin,nama_lembaga,jurusan) VALUES (75,'895473347862','Pendaftar75','Pendaftar75','foto75','82124360427','7987382','Indonesia','WNI','Jl. Tes 54','SIM','Jl. Tes2 4','1999-07-23','Yogyakarta','Yogyakarta',1,"SMA 2",'IPA');
INSERT INTO PENDAFTAR (id_user,no_id,nama_id,nama_ijazah,foto,no_hp,no_telp,nama_negara,kewarganegaraan,alamat_tetap,jenis_id,alamat_sekarang,tgl_lahir,nama_provinsi,nama_kota,jenis_kelamin,nama_lembaga,jurusan) VALUES (76,'895473347863','Pendaftar76','Pendaftar76','foto76','82124360428','7987383','Indonesia','WNI','Jl. Tes 55','SIM','Jl. Tes2 3','1999-07-24','Jawa Barat','Bandung',1,"SMA 1",'IPA');
INSERT INTO PENDAFTAR (id_user,no_id,nama_id,nama_ijazah,foto,no_hp,no_telp,nama_negara,kewarganegaraan,alamat_tetap,jenis_id,alamat_sekarang,tgl_lahir,nama_provinsi,nama_kota,jenis_kelamin,nama_lembaga,jurusan) VALUES (77,'895473347864','Pendaftar77','Pendaftar77','foto77','82124360429','7987384','Indonesia','WNI','Jl. Tes 56','SIM','Jl. Tes2 2','1999-07-25','Papua','Jayapura',1,"SMA 1",'IPA');
INSERT INTO PENDAFTAR (id_user,no_id,nama_id,nama_ijazah,foto,no_hp,no_telp,nama_negara,kewarganegaraan,alamat_tetap,jenis_id,alamat_sekarang,tgl_lahir,nama_provinsi,nama_kota,jenis_kelamin,nama_lembaga,jurusan) VALUES (78,'895473347865','Pendaftar78','Pendaftar78','foto78','82124360430','7987385','Indonesia','WNI','Jl. Tes 57','SIM','Jl. Tes2 1','1999-07-26','Maluku','Ambon',0,"SMA 1",'IPA');
INSERT INTO PENDAFTAR (id_user,no_id,nama_id,nama_ijazah,foto,no_hp,no_telp,nama_negara,kewarganegaraan,alamat_tetap,jenis_id,alamat_sekarang,tgl_lahir,nama_provinsi,nama_kota,jenis_kelamin,nama_lembaga,jurusan) VALUES (79,'895473347866','Pendaftar79','Pendaftar79','foto79','82124360431','7987386','Indonesia','WNI','Jl. Tes 58','SIM','Jl. Tes2','1999-07-27','Bali','Denpasar',0,"SMA 1",'IPA');
INSERT INTO PENDAFTAR (id_user,no_id,nama_id,nama_ijazah,foto,no_hp,no_telp,nama_negara,kewarganegaraan,alamat_tetap,jenis_id,alamat_sekarang,tgl_lahir,nama_provinsi,nama_kota,jenis_kelamin,nama_lembaga,jurusan) VALUES (80,'895473347867','Pendaftar80','Pendaftar80','foto80','82124360432','7987387','Indonesia','WNI','Jl. Tes 59','SIM','Jl. Tes2 IV','1999-07-28','Jawa Timur','Surabaya',0,"SMA 1",'IPA');
INSERT INTO PENDAFTAR (id_user,no_id,nama_id,nama_ijazah,foto,no_hp,no_telp,nama_negara,kewarganegaraan,alamat_tetap,jenis_id,alamat_sekarang,tgl_lahir,nama_provinsi,nama_kota,jenis_kelamin,nama_lembaga,jurusan) VALUES (149,'3156312149','Pendaftar149','Pendaftar149','foto149','82124360149','7987149','Indonesia','WNI','Jl. Tes 149','KTP','Jl. Tes2 149','1999-01-01','Jawa Barat','Depok',1,"SMA 1",'IPA');
INSERT INTO PENDAFTAR (id_user,no_id,nama_id,nama_ijazah,foto,no_hp,no_telp,nama_negara,kewarganegaraan,alamat_tetap,jenis_id,alamat_sekarang,tgl_lahir,nama_provinsi,nama_kota,jenis_kelamin,nama_lembaga,jurusan) VALUES (150,'3156312150','Pendaftar150','Pendaftar150','foto150','82124360150','7987150','Indonesia','WNI','Jl. Tes 150','KTP','Jl. Tes2 150','1999-09-02','Jawa Timur','Surabaya',1,"SMA 1",'IPS');
INSERT INTO PENDAFTAR (id_user,no_id,nama_id,nama_ijazah,foto,no_hp,no_telp,nama_negara,kewarganegaraan,alamat_tetap,jenis_id,alamat_sekarang,tgl_lahir,nama_provinsi,nama_kota,jenis_kelamin,nama_lembaga,jurusan) VALUES (151,'3156312151','Pendaftar151','Pendaftar151','foto151','82124360151','7987151','Indonesia','WNI','Jl. Tes 151','KTP','Jl. Tes2 151','1999-08-24','Kalimantan Barat','Pontianak',1,"SMA 1",'IPS');
INSERT INTO PENDAFTAR (id_user,no_id,nama_id,nama_ijazah,foto,no_hp,no_telp,nama_negara,kewarganegaraan,alamat_tetap,jenis_id,alamat_sekarang,tgl_lahir,nama_provinsi,nama_kota,jenis_kelamin,nama_lembaga,jurusan) VALUES (152,'3156312152','Pendaftar152','Pendaftar152','foto152','82124360152','7987152','Indonesia','WNI','Jl. Tes 152','KTP','Jl. Tes2 152','1999-10-10','DKI Jakarta','Jakarta Selatan',0,"SMA 1",'IPA');
INSERT INTO PENDAFTAR (id_user,no_id,nama_id,nama_ijazah,foto,no_hp,no_telp,nama_negara,kewarganegaraan,alamat_tetap,jenis_id,alamat_sekarang,tgl_lahir,nama_provinsi,nama_kota,jenis_kelamin,nama_lembaga,jurusan) VALUES (153,'3156312153','Pendaftar153','Pendaftar153','foto153','82124360153','7987153','Indonesia','WNI','Jl. Tes 153','KTP','Jl. Tes2 153','1999-09-09','Aceh','Aceh',0,"SMA 1",'IPS');
INSERT INTO PENDAFTAR (id_user,no_id,nama_id,nama_ijazah,foto,no_hp,no_telp,nama_negara,kewarganegaraan,alamat_tetap,jenis_id,alamat_sekarang,tgl_lahir,nama_provinsi,nama_kota,jenis_kelamin,nama_lembaga,jurusan) VALUES (154,'3156312154','Pendaftar154','Pendaftar154','foto154','82124360154','7987154','Indonesia','WNI','Jl. Tes 154','KTP','Jl. Tes2 154','1999-11-23','Sulawesi Barat','Padang',0,"SMA 1",'IPS');
INSERT INTO PENDAFTAR (id_user,no_id,nama_id,nama_ijazah,foto,no_hp,no_telp,nama_negara,kewarganegaraan,alamat_tetap,jenis_id,alamat_sekarang,tgl_lahir,nama_provinsi,nama_kota,jenis_kelamin,nama_lembaga,jurusan) VALUES (155,'3156312155','Pendaftar155','Pendaftar155','foto155','82124360155','7987155','Indonesia','WNI','Jl. Tes 155','KTP','Jl. Tes2 155','1999-06-01','Sumatra Utara','Medan',1,"SMA 1",'IPA');
INSERT INTO PENDAFTAR (id_user,no_id,nama_id,nama_ijazah,foto,no_hp,no_telp,nama_negara,kewarganegaraan,alamat_tetap,jenis_id,alamat_sekarang,tgl_lahir,nama_provinsi,nama_kota,jenis_kelamin,nama_lembaga,jurusan) VALUES (156,'3156312156','Pendaftar156','Pendaftar156','foto156','82124360156','7987156','Indonesia','WNI','Jl. Tes 156','KTP','Jl. Tes2 156','1999-12-12','Sumatra Barat','Padang',1,"SMA 1",'IPS');
INSERT INTO PENDAFTAR (id_user,no_id,nama_id,nama_ijazah,foto,no_hp,no_telp,nama_negara,kewarganegaraan,alamat_tetap,jenis_id,alamat_sekarang,tgl_lahir,nama_provinsi,nama_kota,jenis_kelamin,nama_lembaga,jurusan) VALUES (157,'3156312157','Pendaftar157','Pendaftar157','foto157','82124360157','7987157','Indonesia','WNI','Jl. Tes 157','KTP','Jl. Tes2 157','1999-07-15','DKI Jakarta','Jakarta Selatan',1,"SMA 1",'IPS');
INSERT INTO PENDAFTAR (id_user,no_id,nama_id,nama_ijazah,foto,no_hp,no_telp,nama_negara,kewarganegaraan,alamat_tetap,jenis_id,alamat_sekarang,tgl_lahir,nama_provinsi,nama_kota,jenis_kelamin,nama_lembaga,jurusan) VALUES (158,'3156312158','Pendaftar158','Pendaftar158','foto158','82124360158','7987158','Indonesia','WNI','Jl. Tes 158','KTP','Jl. Tes2 158','1999-08-01','DKI Jakarta','Jakarta Selatan',0,"SMA 1",'IPA');
INSERT INTO PENDAFTAR (id_user,no_id,nama_id,nama_ijazah,foto,no_hp,no_telp,nama_negara,kewarganegaraan,alamat_tetap,jenis_id,alamat_sekarang,tgl_lahir,nama_provinsi,nama_kota,jenis_kelamin,nama_lembaga,jurusan) VALUES (159,'3156312159','Pendaftar159','Pendaftar159','foto159','82124360159','7987159','Indonesia','WNI','Jl. Tes 159','KTP','Jl. Tes2 159','1999-05-24','DKI Jakarta','Jakarta Utara',0,"SMA 1",'IPS');
INSERT INTO PENDAFTAR (id_user,no_id,nama_id,nama_ijazah,foto,no_hp,no_telp,nama_negara,kewarganegaraan,alamat_tetap,jenis_id,alamat_sekarang,tgl_lahir,nama_provinsi,nama_kota,jenis_kelamin,nama_lembaga,jurusan) VALUES (160,'3156312160','Pendaftar160','Pendaftar160','foto160','82124360160','7987160','Indonesia','WNI','Jl. Tes 160','KTP','Jl. Tes2 160','1999-07-24','DKI Jakarta','Jakarta Barat',1,"SMA 1",'IPS');
INSERT INTO PENDAFTAR (id_user,no_id,nama_id,nama_ijazah,foto,no_hp,no_telp,nama_negara,kewarganegaraan,alamat_tetap,jenis_id,alamat_sekarang,tgl_lahir,nama_provinsi,nama_kota,jenis_kelamin,nama_lembaga,jurusan) VALUES (161,'3156312161','Pendaftar161','Pendaftar161','foto161','82124360161','7987161','Indonesia','WNI','Jl. Tes 161','KTP','Jl. Tes2 161','1999-02-20','DKI Jakarta','Jakarta Utara',0,"SMA 1",'IPA');
INSERT INTO PENDAFTAR (id_user,no_id,nama_id,nama_ijazah,foto,no_hp,no_telp,nama_negara,kewarganegaraan,alamat_tetap,jenis_id,alamat_sekarang,tgl_lahir,nama_provinsi,nama_kota,jenis_kelamin,nama_lembaga,jurusan) VALUES (162,'3156312162','Pendaftar162','Pendaftar162','foto162','82124360162','7987162','Indonesia','WNI','Jl. Tes 162','KTP','Jl. Tes2 162','1999-07-30','DKI Jakarta','Jakarta Timur',1,"SMA 1",'IPA');
INSERT INTO PENDAFTAR (id_user,no_id,nama_id,nama_ijazah,foto,no_hp,no_telp,nama_negara,kewarganegaraan,alamat_tetap,jenis_id,alamat_sekarang,tgl_lahir,nama_provinsi,nama_kota,jenis_kelamin,nama_lembaga,jurusan) VALUES (163,'3156312163','Pendaftar163','Pendaftar163','foto163','82124360163','7987163','Indonesia','WNI','Jl. Tes 163','KTP','Jl. Tes2 163','1999-04-15','DKI Jakarta','Jakarta Selatan',1,"SMA 1",'IPS');
INSERT INTO PENDAFTAR (id_user,no_id,nama_id,nama_ijazah,foto,no_hp,no_telp,nama_negara,kewarganegaraan,alamat_tetap,jenis_id,alamat_sekarang,tgl_lahir,nama_provinsi,nama_kota,jenis_kelamin,nama_lembaga,jurusan) VALUES (164,'3156312164','Pendaftar164','Pendaftar164','foto164','82124360164','7987164','Indonesia','WNI','Jl. Tes 164','KTP','Jl. Tes2 164','1999-11-22','Jawa Tengah','Semarang',1,"SMA 1",'IPA');
INSERT INTO PENDAFTAR (id_user,no_id,nama_id,nama_ijazah,foto,no_hp,no_telp,nama_negara,kewarganegaraan,alamat_tetap,jenis_id,alamat_sekarang,tgl_lahir,nama_provinsi,nama_kota,jenis_kelamin,nama_lembaga,jurusan) VALUES (165,'3156312165','Pendaftar165','Pendaftar165','foto165','82124360165','7987165','Indonesia','WNI','Jl. Tes 165','SIM','Jl. Tes2 165','1999-08-19','Banten','Serang',0,"SMA 1",'IPA');
INSERT INTO PENDAFTAR (id_user,no_id,nama_id,nama_ijazah,foto,no_hp,no_telp,nama_negara,kewarganegaraan,alamat_tetap,jenis_id,alamat_sekarang,tgl_lahir,nama_provinsi,nama_kota,jenis_kelamin,nama_lembaga,jurusan) VALUES (166,'3156312166','Pendaftar166','Pendaftar166','foto166','82124360166','7987166','Indonesia','WNI','Jl. Tes 166','SIM','Jl. Tes2 166','1999-03-03','Jawa Barat','Bogor',0,"SMA 1",'IPA');
INSERT INTO PENDAFTAR (id_user,no_id,nama_id,nama_ijazah,foto,no_hp,no_telp,nama_negara,kewarganegaraan,alamat_tetap,jenis_id,alamat_sekarang,tgl_lahir,nama_provinsi,nama_kota,jenis_kelamin,nama_lembaga,jurusan) VALUES (167,'3156312167','Pendaftar167','Pendaftar167','foto167','82124360167','7987167','Indonesia','WNI','Jl. Tes 167','SIM','Jl. Tes2 167','1999-06-18','Jawa Barat','Depok',1,"SMA 1",'IPA');
INSERT INTO PENDAFTAR (id_user,no_id,nama_id,nama_ijazah,foto,no_hp,no_telp,nama_negara,kewarganegaraan,alamat_tetap,jenis_id,alamat_sekarang,tgl_lahir,nama_provinsi,nama_kota,jenis_kelamin,nama_lembaga,jurusan) VALUES (168,'3156312168','Pendaftar168','Pendaftar168','foto168','82124360168','7987168','Indonesia','WNI','Jl. Tes 168','SIM','Jl. Tes2 168','1999-04-12','Jawa Barat','Depok',0,"SMA 1",'IPS');
INSERT INTO PENDAFTAR (id_user,no_id,nama_id,nama_ijazah,foto,no_hp,no_telp,nama_negara,kewarganegaraan,alamat_tetap,jenis_id,alamat_sekarang,tgl_lahir,nama_provinsi,nama_kota,jenis_kelamin,nama_lembaga,jurusan) VALUES (169,'3156312169','Pendaftar169','Pendaftar169','foto169','82124360169','7987169','Indonesia','WNI','Jl. Tes 169','SIM','Jl. Tes2 169','1999-01-21','DKI Jakarta','Jakarta Utara',0,"SMA 1",'IPS');
INSERT INTO PENDAFTAR (id_user,no_id,nama_id,nama_ijazah,foto,no_hp,no_telp,nama_negara,kewarganegaraan,alamat_tetap,jenis_id,alamat_sekarang,tgl_lahir,nama_provinsi,nama_kota,jenis_kelamin,nama_lembaga,jurusan) VALUES (170,'3156312170','Pendaftar170','Pendaftar170','foto170','82124360170','7987170','Indonesia','WNI','Jl. Tes 170','SIM','Jl. Tes2 170','1999-12-24','DKI Jakarta','Jakarta Barat',1,"SMA 1",'IPA');
INSERT INTO PENDAFTAR (id_user,no_id,nama_id,nama_ijazah,foto,no_hp,no_telp,nama_negara,kewarganegaraan,alamat_tetap,jenis_id,alamat_sekarang,tgl_lahir,nama_provinsi,nama_kota,jenis_kelamin,nama_lembaga,jurusan) VALUES (171,'3156312171','Pendaftar171','Pendaftar171','foto171','82124360171','7987171','Indonesia','WNI','Jl. Tes 171','SIM','Jl. Tes2 171','1999-04-13','DKI Jakarta','Jakarta Selatan',0,"SMA 1",'IPS');
INSERT INTO PENDAFTAR (id_user,no_id,nama_id,nama_ijazah,foto,no_hp,no_telp,nama_negara,kewarganegaraan,alamat_tetap,jenis_id,alamat_sekarang,tgl_lahir,nama_provinsi,nama_kota,jenis_kelamin,nama_lembaga,jurusan) VALUES (172,'3156312172','Pendaftar172','Pendaftar172','foto172','82124360172','7987172','Indonesia','WNI','Jl. Tes 172','SIM','Jl. Tes2 172','1999-06-07','DKI Jakarta','Jakarta Pusat',1,"SMA 1",'IPS');
INSERT INTO PENDAFTAR (id_user,no_id,nama_id,nama_ijazah,foto,no_hp,no_telp,nama_negara,kewarganegaraan,alamat_tetap,jenis_id,alamat_sekarang,tgl_lahir,nama_provinsi,nama_kota,jenis_kelamin,nama_lembaga,jurusan) VALUES (173,'3156312173','Pendaftar173','Pendaftar173','foto173','82124360173','7987173','Indonesia','WNI','Jl. Tes 173','SIM','Jl. Tes2 173','1999-10-25','DKI Jakarta','Jakarta Selatan',0,"SMA 1",'IPA');
INSERT INTO PENDAFTAR (id_user,no_id,nama_id,nama_ijazah,foto,no_hp,no_telp,nama_negara,kewarganegaraan,alamat_tetap,jenis_id,alamat_sekarang,tgl_lahir,nama_provinsi,nama_kota,jenis_kelamin,nama_lembaga,jurusan) VALUES (174,'3156312174','Pendaftar174','Pendaftar174','foto174','82124360174','7987174','Indonesia','WNI','Jl. Tes 174','SIM','Jl. Tes2 174','1999-01-16','DKI Jakarta','Jakarta Timur',1,"SMA 1",'IPA');
INSERT INTO PENDAFTAR (id_user,no_id,nama_id,nama_ijazah,foto,no_hp,no_telp,nama_negara,kewarganegaraan,alamat_tetap,jenis_id,alamat_sekarang,tgl_lahir,nama_provinsi,nama_kota,jenis_kelamin,nama_lembaga,jurusan) VALUES (175,'3156312175','Pendaftar175','Pendaftar175','foto175','82124360175','7987175','Indonesia','WNI','Jl. Tes 175','SIM','Jl. Tes2 175','1999-11-12','DKI Jakarta','Jakarta Selatan',1,"SMA 1",'IPA');
INSERT INTO PENDAFTAR (id_user,no_id,nama_id,nama_ijazah,foto,no_hp,no_telp,nama_negara,kewarganegaraan,alamat_tetap,jenis_id,alamat_sekarang,tgl_lahir,nama_provinsi,nama_kota,jenis_kelamin,nama_lembaga,jurusan) VALUES (176,'3156312176','Pendaftar176','Pendaftar176','foto176','82124360176','7987176','Indonesia','WNI','Jl. Tes 176','SIM','Jl. Tes2 176','1999-06-15','Banten','Tangerang',0,"SMA 1",'IPS');
INSERT INTO PENDAFTAR (id_user,no_id,nama_id,nama_ijazah,foto,no_hp,no_telp,nama_negara,kewarganegaraan,alamat_tetap,jenis_id,alamat_sekarang,tgl_lahir,nama_provinsi,nama_kota,jenis_kelamin,nama_lembaga,jurusan) VALUES (177,'3156312177','Pendaftar177','Pendaftar177','foto177','82124360177','7987177','Indonesia','WNI','Jl. Tes 177','SIM','Jl. Tes2 177','1999-03-14','Jawa Barat','Bogor',0,"SMA 1",'IPA');
INSERT INTO PENDAFTAR (id_user,no_id,nama_id,nama_ijazah,foto,no_hp,no_telp,nama_negara,kewarganegaraan,alamat_tetap,jenis_id,alamat_sekarang,tgl_lahir,nama_provinsi,nama_kota,jenis_kelamin,nama_lembaga,jurusan) VALUES (178,'3156312178','Pendaftar178','Pendaftar178','foto178','82124360178','7987178','Indonesia','WNI','Jl. Tes 178','SIM','Jl. Tes2 178','1999-12-23','Jawa Barat','Bekasi',0,"SMA 1",'IPA');
INSERT INTO PENDAFTAR (id_user,no_id,nama_id,nama_ijazah,foto,no_hp,no_telp,nama_negara,kewarganegaraan,alamat_tetap,jenis_id,alamat_sekarang,tgl_lahir,nama_provinsi,nama_kota,jenis_kelamin,nama_lembaga,jurusan) VALUES (179,'3156312179','Pendaftar179','Pendaftar179','foto179','82124360179','7987179','Indonesia','WNI','Jl. Tes 179','SIM','Jl. Tes2 179','1999-08-17','Jawa Barat','Bandung',1,"SMA 1",'IPA');
INSERT INTO PENDAFTAR (id_user,no_id,nama_id,nama_ijazah,foto,no_hp,no_telp,nama_negara,kewarganegaraan,alamat_tetap,jenis_id,alamat_sekarang,tgl_lahir,nama_provinsi,nama_kota,jenis_kelamin,nama_lembaga,jurusan) VALUES (180,'3156312180','Pendaftar180','Pendaftar180','foto180','82124360180','7987180','Indonesia','WNI','Jl. Tes 180','SIM','Jl. Tes2 180','1999-02-28','Banten','Tangerang Selatan',0,"SMA 1",'IPA');
INSERT INTO PENDAFTAR (id_user,no_id,nama_id,nama_ijazah,foto,no_hp,no_telp,nama_negara,kewarganegaraan,alamat_tetap,jenis_id,alamat_sekarang,tgl_lahir,nama_provinsi,nama_kota,jenis_kelamin,nama_lembaga,jurusan) VALUES (181,'3156312181','Pendaftar181','Pendaftar181','foto181','82124360181','7987181','Indonesia','WNI','Jl. Tes 181','SIM','Jl. Tes2 181','1999-01-01','Jawa Barat','Bogor',1,"SMA 1",'IPS');
INSERT INTO PENDAFTAR (id_user,no_id,nama_id,nama_ijazah,foto,no_hp,no_telp,nama_negara,kewarganegaraan,alamat_tetap,jenis_id,alamat_sekarang,tgl_lahir,nama_provinsi,nama_kota,jenis_kelamin,nama_lembaga,jurusan) VALUES (182,'3156312182','Pendaftar182','Pendaftar182','foto182','82124360182','7987182','Indonesia','WNI','Jl. Tes 182','SIM','Jl. Tes2 182','1999-02-12','Yogyakarta','Yogyakarta',1,"SMA 1",'IPA');
INSERT INTO PENDAFTAR (id_user,no_id,nama_id,nama_ijazah,foto,no_hp,no_telp,nama_negara,kewarganegaraan,alamat_tetap,jenis_id,alamat_sekarang,tgl_lahir,nama_provinsi,nama_kota,jenis_kelamin,nama_lembaga,jurusan) VALUES (183,'3156312183','Pendaftar183','Pendaftar183','foto183','82124360183','7987183','Indonesia','WNI','Jl. Tes 183','SIM','Jl. Tes2 183','1999-02-11','DKI Jakarta','Jakarta Selatan',0,"SMA 1",'IPA');
INSERT INTO PENDAFTAR (id_user,no_id,nama_id,nama_ijazah,foto,no_hp,no_telp,nama_negara,kewarganegaraan,alamat_tetap,jenis_id,alamat_sekarang,tgl_lahir,nama_provinsi,nama_kota,jenis_kelamin,nama_lembaga,jurusan) VALUES (184,'3156312184','Pendaftar184','Pendaftar184','foto184','82124360184','7987184','Indonesia','WNI','Jl. Tes 184','SIM','Jl. Tes2 184','1999-08-30','DKI Jakarta','Jakarta Timur',0,"SMA 1",'IPS');
INSERT INTO PENDAFTAR (id_user,no_id,nama_id,nama_ijazah,foto,no_hp,no_telp,nama_negara,kewarganegaraan,alamat_tetap,jenis_id,alamat_sekarang,tgl_lahir,nama_provinsi,nama_kota,jenis_kelamin,nama_lembaga,jurusan) VALUES (185,'3156312185','Pendaftar185','Pendaftar185','foto185','82124360185','7987185','Indonesia','WNI','Jl. Tes 185','SIM','Jl. Tes2 185','1999-04-01','DKI Jakarta','Jakarta Selatan',1,"SMA 1",'IPA');
INSERT INTO PENDAFTAR (id_user,no_id,nama_id,nama_ijazah,foto,no_hp,no_telp,nama_negara,kewarganegaraan,alamat_tetap,jenis_id,alamat_sekarang,tgl_lahir,nama_provinsi,nama_kota,jenis_kelamin,nama_lembaga,jurusan) VALUES (186,'3156312186','Pendaftar186','Pendaftar186','foto186','82124360186','7987186','Indonesia','WNI','Jl. Tes 186','SIM','Jl. Tes2 186','1999-03-18','DKI Jakarta','Jakarta Utara',0,"SMA 1",'IPA');
INSERT INTO PENDAFTAR (id_user,no_id,nama_id,nama_ijazah,foto,no_hp,no_telp,nama_negara,kewarganegaraan,alamat_tetap,jenis_id,alamat_sekarang,tgl_lahir,nama_provinsi,nama_kota,jenis_kelamin,nama_lembaga,jurusan) VALUES (187,'3156312187','Pendaftar187','Pendaftar187','foto187','82124360187','7987187','Indonesia','WNI','Jl. Tes 187','SIM','Jl. Tes2 187','1999-03-29','DKI Jakarta','Jakarta Barat',1,"SMA 1",'IPS');
INSERT INTO PENDAFTAR (id_user,no_id,nama_id,nama_ijazah,foto,no_hp,no_telp,nama_negara,kewarganegaraan,alamat_tetap,jenis_id,alamat_sekarang,tgl_lahir,nama_provinsi,nama_kota,jenis_kelamin,nama_lembaga,jurusan) VALUES (188,'3156312188','Pendaftar188','Pendaftar188','foto188','82124360188','7987188','Indonesia','WNI','Jl. Tes 188','SIM','Jl. Tes2 188','1999-10-01','DKI Jakarta','Jakarta Selatan',1,"SMA 1",'IPA');
INSERT INTO PENDAFTAR (id_user,no_id,nama_id,nama_ijazah,foto,no_hp,no_telp,nama_negara,kewarganegaraan,alamat_tetap,jenis_id,alamat_sekarang,tgl_lahir,nama_provinsi,nama_kota,jenis_kelamin,nama_lembaga,jurusan) VALUES (189,'3156312189','Pendaftar189','Pendaftar189','foto189','82124360189','7987189','Indonesia','WNI','Jl. Tes 189','SIM','Jl. Tes2 189','1999-08-08','Jawa Barat','Depok',0,"SMA 1",'IPA');
INSERT INTO PENDAFTAR (id_user,no_id,nama_id,nama_ijazah,foto,no_hp,no_telp,nama_negara,kewarganegaraan,alamat_tetap,jenis_id,alamat_sekarang,tgl_lahir,nama_provinsi,nama_kota,jenis_kelamin,nama_lembaga,jurusan) VALUES (190,'3156312190','Pendaftar190','Pendaftar190','foto190','82124360190','7987190','Indonesia','WNI','Jl. Tes 190','SIM','Jl. Tes2 190','1999-01-01','Banten','Serang',0,"SMA 1",'IPS');

INSERT INTO JALUR_MASUK (nama,tanggal_buka,tanggal_tutup,status,nama_jenjang,nama_program,jenis_jalur,persyaratan,waktu_ujian,flag_aktif) VALUES ('SIMAK UI','2017-05-11','2017-08-11',1,'S1','Reguler',1,'Pendaftar merupakan mahasiswa teladan','2017-07-07 09:00:00.000000',1);
INSERT INTO JALUR_MASUK (nama,tanggal_buka,tanggal_tutup,status,nama_jenjang,nama_program,jenis_jalur,persyaratan,waktu_ujian,flag_aktif) VALUES ('SIMAK UI S2','2017-03-10','2017-06-10',1,'S2','Reguler',1,'Pendaftar merupakan lulusan terdaftar univ tertentu','2017-10-08 09:00:00.000000',1);
INSERT INTO JALUR_MASUK (nama,tanggal_buka,tanggal_tutup,status,nama_jenjang,nama_program,jenis_jalur,persyaratan,waktu_ujian,flag_aktif) VALUES ('MASUK UI KUY','2018-05-11','2018-08-11',0,'S1','Paralel',0,'Pendaftar harus punya SIM dan STNK',null,1);
INSERT INTO JALUR_MASUK (nama,tanggal_buka,tanggal_tutup,status,nama_jenjang,nama_program,jenis_jalur,persyaratan,waktu_ujian,flag_aktif) VALUES ('PPKB UI','2017-03-12','2017-05-11',1,'S1','Paralel',0,'Pendaftar merupakan mahasiswa sholeh',null,1);
INSERT INTO JALUR_MASUK (nama,tanggal_buka,tanggal_tutup,status,nama_jenjang,nama_program,jenis_jalur,persyaratan,waktu_ujian,flag_aktif) VALUES ('SIMAK UI S3','2017-08-09','2017-10-10',1,'S3','Reguler',1,'Pendaftar sudah berumah tangga','2017-11-11 09:00:00.000000',1);

INSERT INTO LOKASI (id_jalur,alamat,no_telp,nama_lokasi,nama_provinsi,nama_kota,kuota_peng,kuota_pendaftar) VALUES (1,'Jl. Tes 1','9785372','SMAN 1100','Jawa Barat','Depok',5,100);
INSERT INTO LOKASI (id_jalur,alamat,no_telp,nama_lokasi,nama_provinsi,nama_kota,kuota_peng,kuota_pendaftar) VALUES (1,'Jl. Tes 2','9785373','SMAN 1101','Jawa Barat','Depok',5,100);
INSERT INTO LOKASI (id_jalur,alamat,no_telp,nama_lokasi,nama_provinsi,nama_kota,kuota_peng,kuota_pendaftar) VALUES (1,'Jl. Tes 3','9785374','SMAN 1102','Jawa Barat','Depok',5,100);
INSERT INTO LOKASI (id_jalur,alamat,no_telp,nama_lokasi,nama_provinsi,nama_kota,kuota_peng,kuota_pendaftar) VALUES (1,'Jl. Tes 4','9785375','SMAN 1103','Jawa Barat','Depok',5,100);
INSERT INTO LOKASI (id_jalur,alamat,no_telp,nama_lokasi,nama_provinsi,nama_kota,kuota_peng,kuota_pendaftar) VALUES (1,'Jl. Tes 5','9785376','SMAN 1104','Jawa Barat','Depok',7,150);
INSERT INTO LOKASI (id_jalur,alamat,no_telp,nama_lokasi,nama_provinsi,nama_kota,kuota_peng,kuota_pendaftar) VALUES (1,'Jl. Tes 6','9785377','SMAN 1105','Jawa Barat','Bogor',7,150);
INSERT INTO LOKASI (id_jalur,alamat,no_telp,nama_lokasi,nama_provinsi,nama_kota,kuota_peng,kuota_pendaftar) VALUES (1,'Jl. Tes 7','9785378','SMAN 1106','Jawa Barat','Bogor',7,150);
INSERT INTO LOKASI (id_jalur,alamat,no_telp,nama_lokasi,nama_provinsi,nama_kota,kuota_peng,kuota_pendaftar) VALUES (1,'Jl. Tes 8','9785379','SMAN 1107','Jawa Barat','Bogor',7,150);
INSERT INTO LOKASI (id_jalur,alamat,no_telp,nama_lokasi,nama_provinsi,nama_kota,kuota_peng,kuota_pendaftar) VALUES (1,'Jl. Tes 9','9785380','SMAN 1108','Jawa Barat','Bogor',5,80);
INSERT INTO LOKASI (id_jalur,alamat,no_telp,nama_lokasi,nama_provinsi,nama_kota,kuota_peng,kuota_pendaftar) VALUES (1,'Jl. Tes 10','9785381','SMAN 1109','DKI Jakarta','Jakarta Utara',5,100);
INSERT INTO LOKASI (id_jalur,alamat,no_telp,nama_lokasi,nama_provinsi,nama_kota,kuota_peng,kuota_pendaftar) VALUES (1,'Jl. Tes 11','9785382','SMAN 1110','DKI Jakarta','Jakarta Utara',5,100);
INSERT INTO LOKASI (id_jalur,alamat,no_telp,nama_lokasi,nama_provinsi,nama_kota,kuota_peng,kuota_pendaftar) VALUES (1,'Jl. Tes 12','9785383','SMAN 1111','DKI Jakarta','Jakarta Utara',5,100);
INSERT INTO LOKASI (id_jalur,alamat,no_telp,nama_lokasi,nama_provinsi,nama_kota,kuota_peng,kuota_pendaftar) VALUES (1,'Jl. Tes 13','9785384','SMAN 1112','DKI Jakarta','Jakarta Utara',5,100);
INSERT INTO LOKASI (id_jalur,alamat,no_telp,nama_lokasi,nama_provinsi,nama_kota,kuota_peng,kuota_pendaftar) VALUES (1,'Jl. Tes 14','9785385','SMAN 1113','DKI Jakarta','Jakarta Utara',6,120);
INSERT INTO LOKASI (id_jalur,alamat,no_telp,nama_lokasi,nama_provinsi,nama_kota,kuota_peng,kuota_pendaftar) VALUES (1,'Jl. Tes 15','9785386','SMAN 1114','DKI Jakarta','Jakarta Selatan',10,200);
INSERT INTO LOKASI (id_jalur,alamat,no_telp,nama_lokasi,nama_provinsi,nama_kota,kuota_peng,kuota_pendaftar) VALUES (1,'Jl. Tes 16','9785387','SMAN 1115','DKI Jakarta','Jakarta Selatan',10,200);
INSERT INTO LOKASI (id_jalur,alamat,no_telp,nama_lokasi,nama_provinsi,nama_kota,kuota_peng,kuota_pendaftar) VALUES (1,'Jl. Tes 17','9785388','SMAN 1116','DKI Jakarta','Jakarta Selatan',10,200);
INSERT INTO LOKASI (id_jalur,alamat,no_telp,nama_lokasi,nama_provinsi,nama_kota,kuota_peng,kuota_pendaftar) VALUES (1,'Jl. Tes 18','9785389','SMAN 1117','DKI Jakarta','Jakarta Selatan',10,200);
INSERT INTO LOKASI (id_jalur,alamat,no_telp,nama_lokasi,nama_provinsi,nama_kota,kuota_peng,kuota_pendaftar) VALUES (1,'Jl. Tes 19','9785390','SMAN 1118','DKI Jakarta','Jakarta Selatan',10,200);
INSERT INTO LOKASI (id_jalur,alamat,no_telp,nama_lokasi,nama_provinsi,nama_kota,kuota_peng,kuota_pendaftar) VALUES (1,'Jl. Tes 20','9785391','SMAN 1119','DKI Jakarta','Jakarta Selatan',7,150);
INSERT INTO LOKASI (id_jalur,alamat,no_telp,nama_lokasi,nama_provinsi,nama_kota,kuota_peng,kuota_pendaftar) VALUES (1,'Jl. Tes 21','9785392','SMAN 1120','DKI Jakarta','Jakarta Selatan',7,150);
INSERT INTO LOKASI (id_jalur,alamat,no_telp,nama_lokasi,nama_provinsi,nama_kota,kuota_peng,kuota_pendaftar) VALUES (1,'Jl. Tes 22','9785393','SMAN 1121','DKI Jakarta','Jakarta Barat',7,150);
INSERT INTO LOKASI (id_jalur,alamat,no_telp,nama_lokasi,nama_provinsi,nama_kota,kuota_peng,kuota_pendaftar) VALUES (2,'Jl. Tes 23','9785394','SMAN 1122','DKI Jakarta','Jakarta Barat',7,150);
INSERT INTO LOKASI (id_jalur,alamat,no_telp,nama_lokasi,nama_provinsi,nama_kota,kuota_peng,kuota_pendaftar) VALUES (2,'Jl. Tes 24','9785395','SMAN 1123','DKI Jakarta','Jakarta Barat',5,80);
INSERT INTO LOKASI (id_jalur,alamat,no_telp,nama_lokasi,nama_provinsi,nama_kota,kuota_peng,kuota_pendaftar) VALUES (2,'Jl. Tes 25','9785396','SMAN 1124','DKI Jakarta','Jakarta Barat',5,80);
INSERT INTO LOKASI (id_jalur,alamat,no_telp,nama_lokasi,nama_provinsi,nama_kota,kuota_peng,kuota_pendaftar) VALUES (2,'Jl. Tes 26','9785397','SMAN 1125','DKI Jakarta','Jakarta Timur',5,80);
INSERT INTO LOKASI (id_jalur,alamat,no_telp,nama_lokasi,nama_provinsi,nama_kota,kuota_peng,kuota_pendaftar) VALUES (2,'Jl. Tes 27','9785398','SMAN 1126','DKI Jakarta','Jakarta Timur',5,80);
INSERT INTO LOKASI (id_jalur,alamat,no_telp,nama_lokasi,nama_provinsi,nama_kota,kuota_peng,kuota_pendaftar) VALUES (2,'Jl. Tes 28','9785399','SMAN 1127','DKI Jakarta','Jakarta Timur',5,80);
INSERT INTO LOKASI (id_jalur,alamat,no_telp,nama_lokasi,nama_provinsi,nama_kota,kuota_peng,kuota_pendaftar) VALUES (2,'Jl. Tes 29','9785400','SMAN 1128','DKI Jakarta','Jakarta Timur',5,80);
INSERT INTO LOKASI (id_jalur,alamat,no_telp,nama_lokasi,nama_provinsi,nama_kota,kuota_peng,kuota_pendaftar) VALUES (2,'Jl. Tes 30','9785401','SMAN 1129','Banten','Serang',6,100);
INSERT INTO LOKASI (id_jalur,alamat,no_telp,nama_lokasi,nama_provinsi,nama_kota,kuota_peng,kuota_pendaftar) VALUES (2,'Jl. Tes 31','9785402','SMAN 1130','Banten','Serang',6,100);
INSERT INTO LOKASI (id_jalur,alamat,no_telp,nama_lokasi,nama_provinsi,nama_kota,kuota_peng,kuota_pendaftar) VALUES (2,'Jl. Tes 32','9785403','SMAN 1131','Banten','Serang',6,100);
INSERT INTO LOKASI (id_jalur,alamat,no_telp,nama_lokasi,nama_provinsi,nama_kota,kuota_peng,kuota_pendaftar) VALUES (2,'Jl. Tes 33','9785404','SMAN 1132','Banten','Serang',6,100);
INSERT INTO LOKASI (id_jalur,alamat,no_telp,nama_lokasi,nama_provinsi,nama_kota,kuota_peng,kuota_pendaftar) VALUES (2,'Jl. Tes 34','9785405','SMAN 1133','Banten','Serang',6,100);
INSERT INTO LOKASI (id_jalur,alamat,no_telp,nama_lokasi,nama_provinsi,nama_kota,kuota_peng,kuota_pendaftar) VALUES (2,'Jl. Tes 35','9785406','SMAN 1134','Banten','Serang',6,110);
INSERT INTO LOKASI (id_jalur,alamat,no_telp,nama_lokasi,nama_provinsi,nama_kota,kuota_peng,kuota_pendaftar) VALUES (2,'Jl. Tes 36','9785407','SMAN 1135','Banten','Serang',6,110);
INSERT INTO LOKASI (id_jalur,alamat,no_telp,nama_lokasi,nama_provinsi,nama_kota,kuota_peng,kuota_pendaftar) VALUES (2,'Jl. Tes 37','9785408','SMAN 1136','Banten','Serang',6,110);
INSERT INTO LOKASI (id_jalur,alamat,no_telp,nama_lokasi,nama_provinsi,nama_kota,kuota_peng,kuota_pendaftar) VALUES (2,'Jl. Tes 38','9785409','SMAN 1137','Jawa Barat','Depok',10,200);
INSERT INTO LOKASI (id_jalur,alamat,no_telp,nama_lokasi,nama_provinsi,nama_kota,kuota_peng,kuota_pendaftar) VALUES (2,'Jl. Tes 39','8886677','SMAN 1138','Jawa Barat','Depok',6,120);
INSERT INTO LOKASI (id_jalur,alamat,no_telp,nama_lokasi,nama_provinsi,nama_kota,kuota_peng,kuota_pendaftar) VALUES (2,'Jl. Tes 40','7779933','SMAN 1139','DKI Jakarta','Jakarta Utara',7,150);
INSERT INTO LOKASI (id_jalur,alamat,no_telp,nama_lokasi,nama_provinsi,nama_kota,kuota_peng,kuota_pendaftar) VALUES (5,'Jl. Tes 41','9894212','UI','Jawa Barat','Depok',2,50);

INSERT INTO PENGAWAS_UJIAN (id_user,status,jabatan,nama,no_hp,id_lokasi,pindah_bool,flag_aktif) VALUES (6,1,'Mahasiswa','Pengawas6','8532817546',1,1,1);
INSERT INTO PENGAWAS_UJIAN (id_user,status,jabatan,nama,no_hp,id_lokasi,pindah_bool,flag_aktif) VALUES (11,1,'Mahasiswa','Pengawas11','85328175411',1,1,1);
INSERT INTO PENGAWAS_UJIAN (id_user,status,jabatan,nama,no_hp,id_lokasi,pindah_bool,flag_aktif) VALUES (12,1,'Mahasiswa','Pengawas12','85328175412',1,1,1);
INSERT INTO PENGAWAS_UJIAN (id_user,status,jabatan,nama,no_hp,id_lokasi,pindah_bool,flag_aktif) VALUES (81,1,'Pegawai','Pengawas81','8432325481',1,1,1);
INSERT INTO PENGAWAS_UJIAN (id_user,status,jabatan,nama,no_hp,id_lokasi,pindah_bool,flag_aktif) VALUES (82,1,'Pegawai','Pengawas82','8432325482',1,1,1);
INSERT INTO PENGAWAS_UJIAN (id_user,status,jabatan,nama,no_hp,id_lokasi,pindah_bool,flag_aktif) VALUES (83,0,'Mahasiswa','Pengawas83','8432325483',1,1,1);
INSERT INTO PENGAWAS_UJIAN (id_user,status,jabatan,nama,no_hp,id_lokasi,pindah_bool,flag_aktif) VALUES (84,1,'Mahasiswa','Pengawas84','8432325484',1,0,1);
INSERT INTO PENGAWAS_UJIAN (id_user,status,jabatan,nama,no_hp,id_lokasi,pindah_bool,flag_aktif) VALUES (85,1,'Mahasiswa','Pengawas85','8432325485',1,0,1);
INSERT INTO PENGAWAS_UJIAN (id_user,status,jabatan,nama,no_hp,id_lokasi,pindah_bool,flag_aktif) VALUES (86,1,'Pegawai','Pengawas86','8432325486',1,1,1);
INSERT INTO PENGAWAS_UJIAN (id_user,status,jabatan,nama,no_hp,id_lokasi,pindah_bool,flag_aktif) VALUES (87,1,'Pegawai','Pengawas87','8432325487',1,1,1);
INSERT INTO PENGAWAS_UJIAN (id_user,status,jabatan,nama,no_hp,id_lokasi,pindah_bool,flag_aktif) VALUES (88,1,'Mahasiswa','Pengawas88','8432325488',1,1,1);
INSERT INTO PENGAWAS_UJIAN (id_user,status,jabatan,nama,no_hp,id_lokasi,pindah_bool,flag_aktif) VALUES (89,1,'Mahasiswa','Pengawas89','8432325489',1,1,1);
INSERT INTO PENGAWAS_UJIAN (id_user,status,jabatan,nama,no_hp,id_lokasi,pindah_bool,flag_aktif) VALUES (90,1,'Mahasiswa','Pengawas90','8432325490',1,1,1);
INSERT INTO PENGAWAS_UJIAN (id_user,status,jabatan,nama,no_hp,id_lokasi,pindah_bool,flag_aktif) VALUES (91,1,'Mahasiswa','Pengawas91','8432325491',1,1,1);
INSERT INTO PENGAWAS_UJIAN (id_user,status,jabatan,nama,no_hp,id_lokasi,pindah_bool,flag_aktif) VALUES (92,0,'Mahasiswa','Pengawas92','8432325492',1,0,1);
INSERT INTO PENGAWAS_UJIAN (id_user,status,jabatan,nama,no_hp,id_lokasi,pindah_bool,flag_aktif) VALUES (93,1,'Mahasiswa','Pengawas93','8432325493',1,0,1);
INSERT INTO PENGAWAS_UJIAN (id_user,status,jabatan,nama,no_hp,id_lokasi,pindah_bool,flag_aktif) VALUES (94,1,'Mahasiswa','Pengawas94','8432325494',1,0,1);
INSERT INTO PENGAWAS_UJIAN (id_user,status,jabatan,nama,no_hp,id_lokasi,pindah_bool,flag_aktif) VALUES (95,1,'Mahasiswa','Pengawas95','8432325495',1,1,1);
INSERT INTO PENGAWAS_UJIAN (id_user,status,jabatan,nama,no_hp,id_lokasi,pindah_bool,flag_aktif) VALUES (96,1,'Pegawai','Pengawas96','8432325496',1,1,1);
INSERT INTO PENGAWAS_UJIAN (id_user,status,jabatan,nama,no_hp,id_lokasi,pindah_bool,flag_aktif) VALUES (97,0,'Pegawai','Pengawas97','8432325497',1,1,1);
INSERT INTO PENGAWAS_UJIAN (id_user,status,jabatan,nama,no_hp,id_lokasi,pindah_bool,flag_aktif) VALUES (98,1,'Mahasiswa','Pengawas98','8432325498',1,1,1);
INSERT INTO PENGAWAS_UJIAN (id_user,status,jabatan,nama,no_hp,id_lokasi,pindah_bool,flag_aktif) VALUES (99,1,'Mahasiswa','Pengawas99','8432325499',1,1,1);
INSERT INTO PENGAWAS_UJIAN (id_user,status,jabatan,nama,no_hp,id_lokasi,pindah_bool,flag_aktif) VALUES (100,1,'Mahasiswa','Pengawas100','84323254100',1,1,1);
INSERT INTO PENGAWAS_UJIAN (id_user,status,jabatan,nama,no_hp,id_lokasi,pindah_bool,flag_aktif) VALUES (101,1,'Mahasiswa','Pengawas101','84323254101',1,1,1);
INSERT INTO PENGAWAS_UJIAN (id_user,status,jabatan,nama,no_hp,id_lokasi,pindah_bool,flag_aktif) VALUES (102,0,'Pegawai','Pengawas102','84323254102',1,0,1);
INSERT INTO PENGAWAS_UJIAN (id_user,status,jabatan,nama,no_hp,id_lokasi,pindah_bool,flag_aktif) VALUES (103,1,'Pegawai','Pengawas103','84323254103',2,1,1);
INSERT INTO PENGAWAS_UJIAN (id_user,status,jabatan,nama,no_hp,id_lokasi,pindah_bool,flag_aktif) VALUES (104,1,'Mahasiswa','Pengawas104','84323254104',2,1,1);
INSERT INTO PENGAWAS_UJIAN (id_user,status,jabatan,nama,no_hp,id_lokasi,pindah_bool,flag_aktif) VALUES (105,0,'Mahasiswa','Pengawas105','84323254105',2,1,1);
INSERT INTO PENGAWAS_UJIAN (id_user,status,jabatan,nama,no_hp,id_lokasi,pindah_bool,flag_aktif) VALUES (106,1,'Mahasiswa','Pengawas106','84323254106',2,1,1);
INSERT INTO PENGAWAS_UJIAN (id_user,status,jabatan,nama,no_hp,id_lokasi,pindah_bool,flag_aktif) VALUES (107,1,'Mahasiswa','Pengawas107','84323254107',2,1,1);
INSERT INTO PENGAWAS_UJIAN (id_user,status,jabatan,nama,no_hp,id_lokasi,pindah_bool,flag_aktif) VALUES (108,1,'Pegawai','Pengawas108','84323254108',2,1,1);
INSERT INTO PENGAWAS_UJIAN (id_user,status,jabatan,nama,no_hp,id_lokasi,pindah_bool,flag_aktif) VALUES (109,1,'Mahasiswa','Pengawas109','84323254109',2,0,1);
INSERT INTO PENGAWAS_UJIAN (id_user,status,jabatan,nama,no_hp,id_lokasi,pindah_bool,flag_aktif) VALUES (110,0,'Mahasiswa','Pengawas110','84323254110',2,1,1);
INSERT INTO PENGAWAS_UJIAN (id_user,status,jabatan,nama,no_hp,id_lokasi,pindah_bool,flag_aktif) VALUES (111,1,'Mahasiswa','Pengawas111','84323254111',2,1,1);
INSERT INTO PENGAWAS_UJIAN (id_user,status,jabatan,nama,no_hp,id_lokasi,pindah_bool,flag_aktif) VALUES (112,1,'Mahasiswa','Pengawas112','84323254112',2,1,1);
INSERT INTO PENGAWAS_UJIAN (id_user,status,jabatan,nama,no_hp,id_lokasi,pindah_bool,flag_aktif) VALUES (113,0,'Pegawai','Pengawas113','84323254113',2,1,1);
INSERT INTO PENGAWAS_UJIAN (id_user,status,jabatan,nama,no_hp,id_lokasi,pindah_bool,flag_aktif) VALUES (114,0,'Pegawai','Pengawas114','84323254114',2,1,1);
INSERT INTO PENGAWAS_UJIAN (id_user,status,jabatan,nama,no_hp,id_lokasi,pindah_bool,flag_aktif) VALUES (115,1,'Pegawai','Pengawas115','84323254115',2,1,1);
INSERT INTO PENGAWAS_UJIAN (id_user,status,jabatan,nama,no_hp,id_lokasi,pindah_bool,flag_aktif) VALUES (116,1,'Mahasiswa','Pengawas116','84323254116',2,0,1);
INSERT INTO PENGAWAS_UJIAN (id_user,status,jabatan,nama,no_hp,id_lokasi,pindah_bool,flag_aktif) VALUES (117,1,'Mahasiswa','Pengawas117','84323254117',2,0,1);
INSERT INTO PENGAWAS_UJIAN (id_user,status,jabatan,nama,no_hp,id_lokasi,pindah_bool,flag_aktif) VALUES (118,1,'Mahasiswa','Pengawas118','84323254118',2,1,1);
INSERT INTO PENGAWAS_UJIAN (id_user,status,jabatan,nama,no_hp,id_lokasi,pindah_bool,flag_aktif) VALUES (119,0,'Mahasiswa','Pengawas119','84323254119',2,1,1);
INSERT INTO PENGAWAS_UJIAN (id_user,status,jabatan,nama,no_hp,id_lokasi,pindah_bool,flag_aktif) VALUES (120,1,'Pegawai','Pengawas120','84323254120',2,1,1);
INSERT INTO PENGAWAS_UJIAN (id_user,status,jabatan,nama,no_hp,id_lokasi,pindah_bool,flag_aktif) VALUES (121,1,'Pegawai','Pengawas121','84323254121',2,1,1);
INSERT INTO PENGAWAS_UJIAN (id_user,status,jabatan,nama,no_hp,id_lokasi,pindah_bool,flag_aktif) VALUES (122,1,'Mahasiswa','Pengawas122','84323254122',2,1,1);
INSERT INTO PENGAWAS_UJIAN (id_user,status,jabatan,nama,no_hp,id_lokasi,pindah_bool,flag_aktif) VALUES (123,1,'Mahasiswa','Pengawas123','84323254123',2,0,1);
INSERT INTO PENGAWAS_UJIAN (id_user,status,jabatan,nama,no_hp,id_lokasi,pindah_bool,flag_aktif) VALUES (124,1,'Mahasiswa','Pengawas124','84323254124',2,0,1);
INSERT INTO PENGAWAS_UJIAN (id_user,status,jabatan,nama,no_hp,id_lokasi,pindah_bool,flag_aktif) VALUES (125,1,'Mahasiswa','Pengawas125','84323254125',2,1,1);
INSERT INTO PENGAWAS_UJIAN (id_user,status,jabatan,nama,no_hp,id_lokasi,pindah_bool,flag_aktif) VALUES (126,1,'Pegawai','Pengawas126','84323254126',2,1,1);
INSERT INTO PENGAWAS_UJIAN (id_user,status,jabatan,nama,no_hp,id_lokasi,pindah_bool,flag_aktif) VALUES (127,1,'Pegawai','Pengawas127','84323254127',2,1,1);
INSERT INTO PENGAWAS_UJIAN (id_user,status,jabatan,nama,no_hp,id_lokasi,pindah_bool,flag_aktif) VALUES (128,1,'Pegawai','Pengawas128','84323254128',2,1,1);
INSERT INTO PENGAWAS_UJIAN (id_user,status,jabatan,nama,no_hp,id_lokasi,pindah_bool,flag_aktif) VALUES (129,1,'Pegawai','Pengawas129','84323254129',3,1,1);
INSERT INTO PENGAWAS_UJIAN (id_user,status,jabatan,nama,no_hp,id_lokasi,pindah_bool,flag_aktif) VALUES (130,0,'Mahasiswa','Pengawas130','84323254130',3,1,1);
INSERT INTO PENGAWAS_UJIAN (id_user,status,jabatan,nama,no_hp,id_lokasi,pindah_bool,flag_aktif) VALUES (131,1,'Mahasiswa','Pengawas131','84323254131',3,1,1);
INSERT INTO PENGAWAS_UJIAN (id_user,status,jabatan,nama,no_hp,id_lokasi,pindah_bool,flag_aktif) VALUES (132,1,'Mahasiswa','Pengawas132','84323254132',3,1,1);
INSERT INTO PENGAWAS_UJIAN (id_user,status,jabatan,nama,no_hp,id_lokasi,pindah_bool,flag_aktif) VALUES (133,1,'Mahasiswa','Pengawas133','84323254133',3,1,1);
INSERT INTO PENGAWAS_UJIAN (id_user,status,jabatan,nama,no_hp,id_lokasi,pindah_bool,flag_aktif) VALUES (134,1,'Pegawai','Pengawas134','84323254134',3,1,1);
INSERT INTO PENGAWAS_UJIAN (id_user,status,jabatan,nama,no_hp,id_lokasi,pindah_bool,flag_aktif) VALUES (135,1,'Pegawai','Pengawas135','84323254135',3,1,1);
INSERT INTO PENGAWAS_UJIAN (id_user,status,jabatan,nama,no_hp,id_lokasi,pindah_bool,flag_aktif) VALUES (136,1,'Pegawai','Pengawas136','84323254136',3,1,1);
INSERT INTO PENGAWAS_UJIAN (id_user,status,jabatan,nama,no_hp,id_lokasi,pindah_bool,flag_aktif) VALUES (137,0,'Mahasiswa','Pengawas137','84323254137',3,0,1);
INSERT INTO PENGAWAS_UJIAN (id_user,status,jabatan,nama,no_hp,id_lokasi,pindah_bool,flag_aktif) VALUES (138,1,'Mahasiswa','Pengawas138','84323254138',3,0,1);
INSERT INTO PENGAWAS_UJIAN (id_user,status,jabatan,nama,no_hp,id_lokasi,pindah_bool,flag_aktif) VALUES (139,1,'Mahasiswa','Pengawas139','84323254139',3,0,1);
INSERT INTO PENGAWAS_UJIAN (id_user,status,jabatan,nama,no_hp,id_lokasi,pindah_bool,flag_aktif) VALUES (140,1,'Mahasiswa','Pengawas140','84323254140',3,1,1);
INSERT INTO PENGAWAS_UJIAN (id_user,status,jabatan,nama,no_hp,id_lokasi,pindah_bool,flag_aktif) VALUES (141,1,'Pegawai','Pengawas141','84323254141',3,1,1);
INSERT INTO PENGAWAS_UJIAN (id_user,status,jabatan,nama,no_hp,id_lokasi,pindah_bool,flag_aktif) VALUES (142,1,'Pegawai','Pengawas142','84323254142',3,1,1);
INSERT INTO PENGAWAS_UJIAN (id_user,status,jabatan,nama,no_hp,id_lokasi,pindah_bool,flag_aktif) VALUES (143,1,'Mahasiswa','Pengawas143','84323254143',3,1,1);
INSERT INTO PENGAWAS_UJIAN (id_user,status,jabatan,nama,no_hp,id_lokasi,pindah_bool,flag_aktif) VALUES (144,1,'Mahasiswa','Pengawas144','84323254144',3,1,1);
INSERT INTO PENGAWAS_UJIAN (id_user,status,jabatan,nama,no_hp,id_lokasi,pindah_bool,flag_aktif) VALUES (145,1,'Mahasiswa','Pengawas145','84323254145',3,1,1);
INSERT INTO PENGAWAS_UJIAN (id_user,status,jabatan,nama,no_hp,id_lokasi,pindah_bool,flag_aktif) VALUES (146,0,'Mahasiswa','Pengawas146','84323254146',3,0,1);
INSERT INTO PENGAWAS_UJIAN (id_user,status,jabatan,nama,no_hp,id_lokasi,pindah_bool,flag_aktif) VALUES (147,1,'Pegawai','Pengawas147','84323254147',3,1,1);
INSERT INTO PENGAWAS_UJIAN (id_user,status,jabatan,nama,no_hp,id_lokasi,pindah_bool,flag_aktif) VALUES (148,1,'Pegawai','Pengawas148','84323254148',3,1,1);

INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Kedokteran',150,1,1,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Kedokteran Gigi',150,2,1,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Matematika',150,6,1,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Fisika',150,6,1,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Biologi',150,6,1,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Kimia',150,6,1,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Geografi',150,6,1,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Teknik Elektronika',150,7,1,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Teknik Mesin',150,7,1,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Teknik Sipil',150,7,1,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Arsitektur',150,7,1,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Teknik Kimia',150,7,1,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Teknik Industri',150,7,1,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Teknik Metalurgi dan Material',150,7,1,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Teknik Perkapalan',150,7,1,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Teknik Komputer',150,7,1,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Arsitektur Interior',150,7,1,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Bioteknologi',150,7,1,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Hukum',150,9,1,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Ekonomi',150,10,1,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Managemen',150,10,1,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Akuntansi',150,10,1,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Ilmu Perpustakaan',150,11,1,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Filsafat',150,11,1,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Studi Indonesia',150,11,1,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Studi Arab',150,11,1,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Studi Inggris',150,11,1,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Studi Jepang',150,11,1,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Studi Perancis',150,11,1,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Studi Jerman',150,11,1,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Studi Rusia',150,11,1,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Studi Belanda',150,11,1,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Studi Cina',150,11,1,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Studi Korea',150,11,1,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Studi Jawa',150,11,1,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Sejarah',150,11,1,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Arkeologi',150,11,1,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Psikologi',150,12,1,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Ilmu Administrasi Negara',150,14,1,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Ilmu Administrasi Niaga',150,14,1,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Ilmu Administrasi Fiskal',150,14,1,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Ilmu Komunikasi',150,13,1,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Sosiologi',150,13,1,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Kriminologi',150,13,1,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Ilmu Politik',150,13,1,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Hubungan Internasional',150,13,1,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Ilmu Kesejahteraan Sosial',150,13,1,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Antropologi Sosial',150,13,1,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Kesehatan Masyarakat',150,3,1,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Gizi',150,3,1,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Ilmu Keperawatan',150,4,1,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Ilmu Komputer',150,8,1,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Sistem Informasi',150,8,1,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Farmasi',150,5,1,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Ilmu Biomedikal','50',1,2,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Resiko Medis','50',1,2,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Ilmu Gizi','50',3,2,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Ilmu Dasar Profesi Dokter Gigi','50',2,2,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Ilmu Kelompok Profesi Dokter Gigi','50',2,2,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Matematika','50',6,2,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Fisika','50',6,2,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Biologi','50',6,2,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Kimia','50',6,2,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Ilmu Pharmasitologikal','50',5,2,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Ilmu Geografi','50',6,2,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Ilmu Kelautan','50',6,2,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Teknik Elektronika','50',7,2,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Penerapan Laser dan Elektronika Optik','50',7,2,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Teknik Mesin','50',7,2,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Teknik Sipil','50',7,2,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Arsitektur','50',7,2,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Teknik Kimia','50',7,2,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Teknik Industri','50',7,2,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Teknik Metalurgi','50',7,2,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Hukum','50',9,2,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Studi Kenotariatan','50',9,2,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Ekonomi','50',10,2,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Managemen','50',10,2,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Akuntansi','50',10,2,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Perencanaan Kebijakan Publik','50',10,2,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Ilmu Perpustakaan','50',11,2,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Filsafat','50',11,2,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Studi Literatur','50',11,2,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Linguistik','50',11,2,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Kedokteran',150,1,3,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Kedokteran Gigi',150,2,3,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Matematika',150,6,3,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Fisika',150,6,3,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Biologi',150,6,3,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Kimia',150,6,3,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Geografi',150,6,3,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Teknik Elektronika',150,7,3,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Teknik Mesin',150,7,3,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Teknik Sipil',150,7,3,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Arsitektur',150,7,3,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Teknik Kimia',150,7,3,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Teknik Industri',150,7,3,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Teknik Metalurgi dan Material',150,7,3,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Teknik Perkapalan',150,7,3,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Teknik Komputer',150,7,3,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Arsitektur Interior',150,7,3,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Bioteknologi',150,7,3,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Hukum',150,9,3,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Ekonomi',150,10,3,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Managemen',150,10,3,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Akuntansi',150,10,3,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Ilmu Perpustakaan',150,11,3,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Filsafat',150,11,3,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Studi Indonesia',150,11,3,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Studi Arab',150,11,3,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Studi Inggris',150,11,3,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Studi Jepang',150,11,3,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Studi Perancis',150,11,3,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Studi Jerman',150,11,3,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Studi Rusia',150,11,3,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Studi Belanda',150,11,3,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Studi Cina',150,11,3,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Studi Korea',150,11,3,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Studi Jawa',150,11,3,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Sejarah',150,11,3,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Arkeologi',150,11,3,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Psikologi',150,12,3,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Ilmu Administrasi Negara',150,14,3,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Ilmu Administrasi Niaga',150,14,3,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Ilmu Administrasi Fiskal',150,14,3,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Ilmu Komunikasi',150,13,3,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Sosiologi',150,13,3,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Kriminologi',150,13,3,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Ilmu Politik',150,13,3,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Hubungan Internasional',150,13,3,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Ilmu Kesejahteraan Sosial',150,13,3,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Antropologi Sosial',150,13,3,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Kesehatan Masyarakat',150,3,3,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Gizi',150,3,3,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Ilmu Komputer',150,8,3,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Sistem Informasi',150,8,3,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Farmasi',150,5,3,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Kedokteran',150,1,4,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Kedokteran Gigi',150,2,4,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Matematika',150,6,4,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Fisika',150,6,4,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Biologi',150,6,4,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Kimia',150,6,4,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Geografi',150,6,4,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Teknik Elektronika',150,7,4,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Teknik Mesin',150,7,4,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Teknik Sipil',150,7,4,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Arsitektur',150,7,4,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Teknik Kimia',150,7,4,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Teknik Industri',150,7,4,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Teknik Metalurgi dan Material',150,7,4,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Teknik Perkapalan',150,7,4,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Teknik Komputer',150,7,4,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Arsitektur Interior',150,7,4,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Bioteknologi',150,7,4,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Hukum',150,9,4,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Ekonomi',150,10,4,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Managemen',150,10,4,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Akuntansi',150,10,4,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Ilmu Perpustakaan',150,11,4,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Filsafat',150,11,4,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Studi Indonesia',150,11,4,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Studi Arab',150,11,4,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Studi Inggris',150,11,4,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Studi Jepang',150,11,4,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Studi Perancis',150,11,4,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Studi Jerman',150,11,4,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Studi Rusia',150,11,4,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Studi Belanda',150,11,4,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Studi Cina',150,11,4,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Studi Korea',150,11,4,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Studi Jawa',150,11,4,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Sejarah',150,11,4,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Arkeologi',150,11,4,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Psikologi',150,12,4,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Ilmu Administrasi Negara',150,14,4,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Ilmu Administrasi Niaga',150,14,4,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Ilmu Administrasi Fiskal',150,14,4,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Ilmu Komunikasi',150,13,4,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Sosiologi',150,13,4,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Kriminologi',150,13,4,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Ilmu Politik',150,13,4,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Hubungan Internasional',150,13,4,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Ilmu Kesejahteraan Sosial',150,13,4,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Antropologi Sosial',150,13,4,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Kesehatan Masyarakat',150,3,4,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Gizi',150,3,4,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Ilmu Keperawatan',150,4,4,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Farmasi',150,5,4,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Ilmu Komputer',150,8,4,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Sistem Informasi',150,8,4,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Ilmu Medis',150,1,5,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Ilmu Biomedis',150,1,5,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Ilmu Gizi',150,3,5,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Biologi',150,6,5,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Kimia',150,6,5,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Teknik Elektronika',150,7,5,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Penerapan Laser dan Elektronika Optik',150,7,5,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Teknik Mesin',150,7,5,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Teknik Kimia',150,7,5,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Teknik Metalurgi',150,7,5,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Hukum',150,9,5,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Ekonomi',150,10,5,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Ilmu Managemen',150,10,5,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Akuntansi',150,10,5,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Filsafat',150,11,5,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Linguistik',150,11,5,1);
INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,id_fakultas,id_jalur,flag_aktif) VALUES ('Studi Literatur',150,11,5,1);

INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (1,'S1','Reguler',34,1);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (1,'S1','Reguler',33,2);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (2,'S1','Reguler',12,1);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (2,'S1','Reguler',43,2);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (3,'S1','Reguler',12,1);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (3,'S1','Reguler',15,2);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (4,'S1','Reguler',46,1);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (4,'S1','Reguler',21,2);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (4,'S1','Reguler',32,3);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (5,'S1','Reguler',33,1);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (5,'S1','Reguler',10,2);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (6,'S1','Reguler',4,1);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (6,'S1','Reguler',13,2);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (7,'S1','Reguler',16,1);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (7,'S1','Reguler',35,2);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (7,'S1','Reguler',42,3);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (8,'S1','Reguler',43,1);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (8,'S1','Reguler',18,2);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (9,'S1','Reguler',19,1);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (10,'S1','Reguler',30,1);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (10,'S1','Reguler',14,2);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (11,'S1','Reguler',20,1);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (11,'S1','Reguler',19,2);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (11,'S1','Reguler',24,3);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (12,'S1','Reguler',36,1);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (12,'S1','Reguler',32,2);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (13,'S1','Reguler',53,1);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (13,'S1','Reguler',32,2);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (14,'S1','Reguler',18,1);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (14,'S1','Reguler',16,2);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (15,'S1','Reguler',17,1);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (15,'S1','Reguler',32,2);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (16,'S1','Reguler',20,1);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (17,'S1','Reguler',21,1);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (18,'S1','Reguler',25,1);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (19,'S1','Reguler',29,1);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (20,'S1','Reguler',28,1);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (20,'S1','Reguler',21,2);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (21,'S1','Reguler',16,1);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (22,'S1','Reguler',2,1);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (23,'S1','Reguler',4,1);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (23,'S1','Reguler',15,2);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (23,'S1','Reguler',2,3);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (24,'S1','Reguler',5,1);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (24,'S1','Reguler',6,2);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (25,'S1','Reguler',1,1);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (25,'S1','Reguler',9,2);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (26,'S1','Reguler',7,1);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (26,'S1','Reguler',8,2);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (27,'S1','Reguler',14,1);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (27,'S1','Reguler',20,2);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (28,'S1','Reguler',19,1);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (28,'S1','Reguler',51,2);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (28,'S1','Reguler',36,3);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (29,'S1','Reguler',32,1);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (30,'S1','Reguler',45,1);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (31,'S1','Reguler',32,1);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (31,'S1','Reguler',18,2);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (32,'S1','Reguler',16,1);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (32,'S1','Reguler',17,2);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (33,'S1','Reguler',32,1);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (33,'S1','Reguler',20,2);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (34,'S1','Reguler',21,1);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (34,'S1','Reguler',25,2);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (34,'S1','Reguler',29,3);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (35,'S1','Reguler',28,1);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (35,'S1','Reguler',21,2);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (36,'S1','Reguler',16,1);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (36,'S1','Reguler',2,2);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (37,'S1','Reguler',4,1);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (37,'S1','Reguler',15,2);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (37,'S1','Reguler',2,3);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (38,'S1','Reguler',13,1);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (38,'S1','Reguler',53,2);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (39,'S1','Reguler',12,1);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (39,'S1','Reguler',14,2);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (40,'S1','Reguler',14,1);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (40,'S1','Reguler',13,2);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (41,'S2','Reguler',69,1);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (42,'S2','Reguler',63,1);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (43,'S2','Reguler',56,1);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (44,'S2','Reguler',56,1);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (45,'S2','Reguler',73,1);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (46,'S2','Reguler',60,1);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (47,'S2','Reguler',61,1);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (48,'S2','Reguler',62,1);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (49,'S2','Reguler',63,1);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (50,'S2','Reguler',60,1);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (51,'S2','Reguler',63,1);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (52,'S2','Reguler',62,1);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (53,'S2','Reguler',59,1);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (54,'S2','Reguler',60,1);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (55,'S2','Reguler',69,1);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (56,'S3','Reguler',190,1);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (57,'S3','Reguler',190,1);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (58,'S3','Reguler',190,1);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (59,'S3','Reguler',193,1);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (60,'S3','Reguler',190,1);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (61,'S3','Reguler',195,1);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (62,'S3','Reguler',196,1);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (63,'S3','Reguler',197,1);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (64,'S1','Paralel',16,1);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (64,'S1','Paralel',35,2);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (65,'S1','Paralel',42,1);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (65,'S1','Paralel',43,2);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (65,'S1','Paralel',18,3);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (66,'S1','Paralel',32,1);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (66,'S1','Paralel',18,2);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (67,'S1','Paralel',16,1);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (67,'S1','Paralel',17,2);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (67,'S1','Paralel',32,3);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (68,'S1','Paralel',20,1);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (68,'S1','Paralel',21,2);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (69,'S1','Paralel',25,1);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (69,'S1','Paralel',29,2);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (70,'S1','Paralel',15,1);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (70,'S1','Paralel',46,2);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (70,'S1','Paralel',21,3);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (71,'S1','Paralel',32,1);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (71,'S1','Paralel',33,2);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (72,'S1','Paralel',10,1);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (72,'S1','Paralel',4,2);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (72,'S1','Paralel',13,3);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (73,'S1','Paralel',16,1);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (73,'S1','Paralel',35,2);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (73,'S1','Paralel',42,3);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (74,'S1','Paralel',43,1);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (74,'S1','Paralel',18,2);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (75,'S1','Paralel',19,1);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (76,'S1','Paralel',30,1);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (76,'S1','Paralel',14,2);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (77,'S1','Paralel',20,1);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (77,'S1','Paralel',19,2);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (77,'S1','Paralel',24,3);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (78,'S1','Paralel',36,1);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (78,'S1','Paralel',32,2);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (79,'S1','Paralel',53,1);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (79,'S1','Paralel',32,2);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (79,'S1','Paralel',31,3);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (80,'S1','Paralel',20,1);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (80,'S1','Paralel',21,2);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (81,'S1','Paralel',25,1);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (81,'S1','Paralel',29,2);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (82,'S1','Paralel',28,1);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (82,'S1','Paralel',21,2);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (82,'S1','Paralel',16,3);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (83,'S1','Paralel',2,1);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (83,'S1','Paralel',4,2);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (83,'S1','Paralel',32,3);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (84,'S1','Paralel',20,1);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (84,'S1','Paralel',21,2);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (85,'S1','Paralel',25,1);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (85,'S1','Paralel',29,2);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (86,'S1','Paralel',28,1);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (86,'S1','Paralel',21,2);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (86,'S1','Paralel',16,3);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (87,'S1','Paralel',2,1);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (87,'S1','Paralel',4,2);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (88,'S1','Paralel',15,1);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (88,'S1','Paralel',2,2);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (88,'S1','Paralel',5,3);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (89,'S1','Paralel',50,1);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (89,'S1','Paralel',1,2);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (90,'S1','Paralel',9,1);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (90,'S1','Paralel',36,2);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (90,'S1','Paralel',32,3);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (91,'S1','Paralel',45,1);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (91,'S1','Paralel',32,2);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (91,'S1','Paralel',18,3);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (92,'S1','Paralel',16,1);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (92,'S1','Paralel',17,2);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (93,'S1','Paralel',32,1);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (93,'S1','Paralel',20,2);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (93,'S1','Paralel',21,3);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (94,'S1','Paralel',25,1);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (94,'S1','Paralel',29,2);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (95,'S1','Paralel',17,1);
INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,id_prodi,pilihan) VALUES (95,'S1','Paralel',32,2);

INSERT INTO DETAIL_UJIAN (no_daftar,no_ujian,id_jalur,id_lokasi,waktu_ujian) VALUES (1,'000001',1,1,'2017-07-07 09:00:00.000000');
INSERT INTO DETAIL_UJIAN (no_daftar,no_ujian,id_jalur,id_lokasi,waktu_ujian) VALUES (2,'000002',1,1,'2017-07-07 09:00:00.000000');
INSERT INTO DETAIL_UJIAN (no_daftar,no_ujian,id_jalur,id_lokasi,waktu_ujian) VALUES (3,'000003',1,1,'2017-07-07 09:00:00.000000');
INSERT INTO DETAIL_UJIAN (no_daftar,no_ujian,id_jalur,id_lokasi,waktu_ujian) VALUES (4,'000004',1,1,'2017-07-07 09:00:00.000000');
INSERT INTO DETAIL_UJIAN (no_daftar,no_ujian,id_jalur,id_lokasi,waktu_ujian) VALUES (5,'000005',1,1,'2017-07-07 09:00:00.000000');
INSERT INTO DETAIL_UJIAN (no_daftar,no_ujian,id_jalur,id_lokasi,waktu_ujian) VALUES (6,'000006',1,1,'2017-07-07 09:00:00.000000');
INSERT INTO DETAIL_UJIAN (no_daftar,no_ujian,id_jalur,id_lokasi,waktu_ujian) VALUES (7,'000007',1,1,'2017-07-07 09:00:00.000000');
INSERT INTO DETAIL_UJIAN (no_daftar,no_ujian,id_jalur,id_lokasi,waktu_ujian) VALUES (8,'000008',1,1,'2017-07-07 09:00:00.000000');
INSERT INTO DETAIL_UJIAN (no_daftar,no_ujian,id_jalur,id_lokasi,waktu_ujian) VALUES (9,'000009',1,1,'2017-07-07 09:00:00.000000');
INSERT INTO DETAIL_UJIAN (no_daftar,no_ujian,id_jalur,id_lokasi,waktu_ujian) VALUES (10,'000010',1,1,'2017-07-07 09:00:00.000000');
INSERT INTO DETAIL_UJIAN (no_daftar,no_ujian,id_jalur,id_lokasi,waktu_ujian) VALUES (11,'000011',1,1,'2017-07-07 09:00:00.000000');
INSERT INTO DETAIL_UJIAN (no_daftar,no_ujian,id_jalur,id_lokasi,waktu_ujian) VALUES (12,'000012',1,1,'2017-07-07 09:00:00.000000');
INSERT INTO DETAIL_UJIAN (no_daftar,no_ujian,id_jalur,id_lokasi,waktu_ujian) VALUES (13,'000013',1,1,'2017-07-07 09:00:00.000000');
INSERT INTO DETAIL_UJIAN (no_daftar,no_ujian,id_jalur,id_lokasi,waktu_ujian) VALUES (14,'000014',1,1,'2017-07-07 09:00:00.000000');
INSERT INTO DETAIL_UJIAN (no_daftar,no_ujian,id_jalur,id_lokasi,waktu_ujian) VALUES (15,'000015',1,1,'2017-07-07 09:00:00.000000');
INSERT INTO DETAIL_UJIAN (no_daftar,no_ujian,id_jalur,id_lokasi,waktu_ujian) VALUES (16,'000016',1,1,'2017-07-07 09:00:00.000000');
INSERT INTO DETAIL_UJIAN (no_daftar,no_ujian,id_jalur,id_lokasi,waktu_ujian) VALUES (17,'000017',1,1,'2017-07-07 09:00:00.000000');
INSERT INTO DETAIL_UJIAN (no_daftar,no_ujian,id_jalur,id_lokasi,waktu_ujian) VALUES (18,'000018',1,1,'2017-07-07 09:00:00.000000');
INSERT INTO DETAIL_UJIAN (no_daftar,no_ujian,id_jalur,id_lokasi,waktu_ujian) VALUES (19,'000019',1,1,'2017-07-07 09:00:00.000000');
INSERT INTO DETAIL_UJIAN (no_daftar,no_ujian,id_jalur,id_lokasi,waktu_ujian) VALUES (20,'000020',1,1,'2017-07-07 09:00:00.000000');
INSERT INTO DETAIL_UJIAN (no_daftar,no_ujian,id_jalur,id_lokasi,waktu_ujian) VALUES (21,'000021',1,1,'2017-07-07 09:00:00.000000');
INSERT INTO DETAIL_UJIAN (no_daftar,no_ujian,id_jalur,id_lokasi,waktu_ujian) VALUES (22,'000022',1,1,'2017-07-07 09:00:00.000000');
INSERT INTO DETAIL_UJIAN (no_daftar,no_ujian,id_jalur,id_lokasi,waktu_ujian) VALUES (23,'000023',1,1,'2017-07-07 09:00:00.000000');
INSERT INTO DETAIL_UJIAN (no_daftar,no_ujian,id_jalur,id_lokasi,waktu_ujian) VALUES (24,'000024',1,1,'2017-07-07 09:00:00.000000');
INSERT INTO DETAIL_UJIAN (no_daftar,no_ujian,id_jalur,id_lokasi,waktu_ujian) VALUES (25,'000025',1,1,'2017-07-07 09:00:00.000000');
INSERT INTO DETAIL_UJIAN (no_daftar,no_ujian,id_jalur,id_lokasi,waktu_ujian) VALUES (26,'000026',1,1,'2017-07-07 09:00:00.000000');
INSERT INTO DETAIL_UJIAN (no_daftar,no_ujian,id_jalur,id_lokasi,waktu_ujian) VALUES (27,'000027',1,1,'2017-07-07 09:00:00.000000');
INSERT INTO DETAIL_UJIAN (no_daftar,no_ujian,id_jalur,id_lokasi,waktu_ujian) VALUES (28,'000028',1,1,'2017-07-07 09:00:00.000000');
INSERT INTO DETAIL_UJIAN (no_daftar,no_ujian,id_jalur,id_lokasi,waktu_ujian) VALUES (29,'000029',1,1,'2017-07-07 09:00:00.000000');
INSERT INTO DETAIL_UJIAN (no_daftar,no_ujian,id_jalur,id_lokasi,waktu_ujian) VALUES (30,'000030',1,1,'2017-07-07 09:00:00.000000');
INSERT INTO DETAIL_UJIAN (no_daftar,no_ujian,id_jalur,id_lokasi,waktu_ujian) VALUES (31,'000031',1,1,'2017-07-07 09:00:00.000000');
INSERT INTO DETAIL_UJIAN (no_daftar,no_ujian,id_jalur,id_lokasi,waktu_ujian) VALUES (32,'000032',1,1,'2017-07-07 09:00:00.000000');
INSERT INTO DETAIL_UJIAN (no_daftar,no_ujian,id_jalur,id_lokasi,waktu_ujian) VALUES (33,'000033',1,1,'2017-07-07 09:00:00.000000');
INSERT INTO DETAIL_UJIAN (no_daftar,no_ujian,id_jalur,id_lokasi,waktu_ujian) VALUES (34,'000034',1,1,'2017-07-07 09:00:00.000000');
INSERT INTO DETAIL_UJIAN (no_daftar,no_ujian,id_jalur,id_lokasi,waktu_ujian) VALUES (35,'000035',1,1,'2017-07-07 09:00:00.000000');
INSERT INTO DETAIL_UJIAN (no_daftar,no_ujian,id_jalur,id_lokasi,waktu_ujian) VALUES (36,'000036',1,1,'2017-07-07 09:00:00.000000');
INSERT INTO DETAIL_UJIAN (no_daftar,no_ujian,id_jalur,id_lokasi,waktu_ujian) VALUES (37,'000037',1,1,'2017-07-07 09:00:00.000000');
INSERT INTO DETAIL_UJIAN (no_daftar,no_ujian,id_jalur,id_lokasi,waktu_ujian) VALUES (38,'000038',1,1,'2017-07-07 09:00:00.000000');
INSERT INTO DETAIL_UJIAN (no_daftar,no_ujian,id_jalur,id_lokasi,waktu_ujian) VALUES (39,'000039',1,1,'2017-07-07 09:00:00.000000');
INSERT INTO DETAIL_UJIAN (no_daftar,no_ujian,id_jalur,id_lokasi,waktu_ujian) VALUES (40,'000040',1,1,'2017-07-07 09:00:00.000000');
INSERT INTO DETAIL_UJIAN (no_daftar,no_ujian,id_jalur,id_lokasi,waktu_ujian) VALUES (41,'000041',2,23,'2017-10-08 09:00:00.000000');
INSERT INTO DETAIL_UJIAN (no_daftar,no_ujian,id_jalur,id_lokasi,waktu_ujian) VALUES (42,'000042',2,23,'2017-10-08 09:00:00.000000');
INSERT INTO DETAIL_UJIAN (no_daftar,no_ujian,id_jalur,id_lokasi,waktu_ujian) VALUES (43,'000043',2,23,'2017-10-08 09:00:00.000000');
INSERT INTO DETAIL_UJIAN (no_daftar,no_ujian,id_jalur,id_lokasi,waktu_ujian) VALUES (44,'000044',2,23,'2017-10-08 09:00:00.000000');
INSERT INTO DETAIL_UJIAN (no_daftar,no_ujian,id_jalur,id_lokasi,waktu_ujian) VALUES (45,'000045',2,23,'2017-10-08 09:00:00.000000');
INSERT INTO DETAIL_UJIAN (no_daftar,no_ujian,id_jalur,id_lokasi,waktu_ujian) VALUES (46,'000046',2,23,'2017-10-08 09:00:00.000000');
INSERT INTO DETAIL_UJIAN (no_daftar,no_ujian,id_jalur,id_lokasi,waktu_ujian) VALUES (47,'000047',2,23,'2017-10-08 09:00:00.000000');
INSERT INTO DETAIL_UJIAN (no_daftar,no_ujian,id_jalur,id_lokasi,waktu_ujian) VALUES (48,'000048',2,23,'2017-10-08 09:00:00.000000');
INSERT INTO DETAIL_UJIAN (no_daftar,no_ujian,id_jalur,id_lokasi,waktu_ujian) VALUES (49,'000049',2,23,'2017-10-08 09:00:00.000000');
INSERT INTO DETAIL_UJIAN (no_daftar,no_ujian,id_jalur,id_lokasi,waktu_ujian) VALUES (50,'000050',2,23,'2017-10-08 09:00:00.000000');
INSERT INTO DETAIL_UJIAN (no_daftar,no_ujian,id_jalur,id_lokasi,waktu_ujian) VALUES (51,'000051',2,23,'2017-10-08 09:00:00.000000');
INSERT INTO DETAIL_UJIAN (no_daftar,no_ujian,id_jalur,id_lokasi,waktu_ujian) VALUES (52,'000052',2,23,'2017-10-08 09:00:00.000000');
INSERT INTO DETAIL_UJIAN (no_daftar,no_ujian,id_jalur,id_lokasi,waktu_ujian) VALUES (53,'000053',2,23,'2017-10-08 09:00:00.000000');
INSERT INTO DETAIL_UJIAN (no_daftar,no_ujian,id_jalur,id_lokasi,waktu_ujian) VALUES (54,'000054',2,23,'2017-10-08 09:00:00.000000');
INSERT INTO DETAIL_UJIAN (no_daftar,no_ujian,id_jalur,id_lokasi,waktu_ujian) VALUES (55,'000055',2,23,'2017-10-08 09:00:00.000000');
INSERT INTO DETAIL_UJIAN (no_daftar,no_ujian,id_jalur,id_lokasi,waktu_ujian) VALUES (56,'000056',5,41,'2017-11-11 09:00:00.000000');
INSERT INTO DETAIL_UJIAN (no_daftar,no_ujian,id_jalur,id_lokasi,waktu_ujian) VALUES (57,'000057',5,41,'2017-11-11 09:00:00.000000');
INSERT INTO DETAIL_UJIAN (no_daftar,no_ujian,id_jalur,id_lokasi,waktu_ujian) VALUES (58,'000058',5,41,'2017-11-11 09:00:00.000000');
INSERT INTO DETAIL_UJIAN (no_daftar,no_ujian,id_jalur,id_lokasi,waktu_ujian) VALUES (59,'000059',5,41,'2017-11-11 09:00:00.000000');
INSERT INTO DETAIL_UJIAN (no_daftar,no_ujian,id_jalur,id_lokasi,waktu_ujian) VALUES (60,'000060',5,41,'2017-11-11 09:00:00.000000');
INSERT INTO DETAIL_UJIAN (no_daftar,no_ujian,id_jalur,id_lokasi,waktu_ujian) VALUES (61,'000061',5,41,'2017-11-11 09:00:00.000000');
INSERT INTO DETAIL_UJIAN (no_daftar,no_ujian,id_jalur,id_lokasi,waktu_ujian) VALUES (62,'000062',5,41,'2017-11-11 09:00:00.000000');
INSERT INTO DETAIL_UJIAN (no_daftar,no_ujian,id_jalur,id_lokasi,waktu_ujian) VALUES (63,'000063',5,41,'2017-11-11 09:00:00.000000');

INSERT INTO RIWAYAT_PENDAFTARAN (no_pendaftaran,tahun,id_jalur,nama_jenjang,nama_program) VALUES (1,'2017',1,'S1','Reguler');
INSERT INTO RIWAYAT_PENDAFTARAN (no_pendaftaran,tahun,id_jalur,nama_jenjang,nama_program) VALUES (2,'2017',1,'S1','Reguler');
INSERT INTO RIWAYAT_PENDAFTARAN (no_pendaftaran,tahun,id_jalur,nama_jenjang,nama_program) VALUES (3,'2017',1,'S1','Reguler');
INSERT INTO RIWAYAT_PENDAFTARAN (no_pendaftaran,tahun,id_jalur,nama_jenjang,nama_program) VALUES (4,'2017',1,'S1','Reguler');
INSERT INTO RIWAYAT_PENDAFTARAN (no_pendaftaran,tahun,id_jalur,nama_jenjang,nama_program) VALUES (5,'2017',1,'S1','Reguler');
INSERT INTO RIWAYAT_PENDAFTARAN (no_pendaftaran,tahun,id_jalur,nama_jenjang,nama_program) VALUES (6,'2017',1,'S1','Reguler');
INSERT INTO RIWAYAT_PENDAFTARAN (no_pendaftaran,tahun,id_jalur,nama_jenjang,nama_program) VALUES (7,'2017',1,'S1','Reguler');
INSERT INTO RIWAYAT_PENDAFTARAN (no_pendaftaran,tahun,id_jalur,nama_jenjang,nama_program) VALUES (8,'2017',1,'S1','Reguler');
INSERT INTO RIWAYAT_PENDAFTARAN (no_pendaftaran,tahun,id_jalur,nama_jenjang,nama_program) VALUES (9,'2017',1,'S1','Reguler');
INSERT INTO RIWAYAT_PENDAFTARAN (no_pendaftaran,tahun,id_jalur,nama_jenjang,nama_program) VALUES (10,'2017',1,'S1','Reguler');
INSERT INTO RIWAYAT_PENDAFTARAN (no_pendaftaran,tahun,id_jalur,nama_jenjang,nama_program) VALUES (11,'2017',1,'S1','Reguler');
INSERT INTO RIWAYAT_PENDAFTARAN (no_pendaftaran,tahun,id_jalur,nama_jenjang,nama_program) VALUES (12,'2017',1,'S1','Reguler');
INSERT INTO RIWAYAT_PENDAFTARAN (no_pendaftaran,tahun,id_jalur,nama_jenjang,nama_program) VALUES (13,'2017',1,'S1','Reguler');
INSERT INTO RIWAYAT_PENDAFTARAN (no_pendaftaran,tahun,id_jalur,nama_jenjang,nama_program) VALUES (14,'2017',1,'S1','Reguler');
INSERT INTO RIWAYAT_PENDAFTARAN (no_pendaftaran,tahun,id_jalur,nama_jenjang,nama_program) VALUES (15,'2017',1,'S1','Reguler');
INSERT INTO RIWAYAT_PENDAFTARAN (no_pendaftaran,tahun,id_jalur,nama_jenjang,nama_program) VALUES (16,'2017',1,'S1','Reguler');
INSERT INTO RIWAYAT_PENDAFTARAN (no_pendaftaran,tahun,id_jalur,nama_jenjang,nama_program) VALUES (17,'2017',1,'S1','Reguler');
INSERT INTO RIWAYAT_PENDAFTARAN (no_pendaftaran,tahun,id_jalur,nama_jenjang,nama_program) VALUES (18,'2017',1,'S1','Reguler');
INSERT INTO RIWAYAT_PENDAFTARAN (no_pendaftaran,tahun,id_jalur,nama_jenjang,nama_program) VALUES (19,'2017',1,'S1','Reguler');
INSERT INTO RIWAYAT_PENDAFTARAN (no_pendaftaran,tahun,id_jalur,nama_jenjang,nama_program) VALUES (20,'2017',1,'S1','Reguler');
INSERT INTO RIWAYAT_PENDAFTARAN (no_pendaftaran,tahun,id_jalur,nama_jenjang,nama_program) VALUES (21,'2017',1,'S1','Reguler');
INSERT INTO RIWAYAT_PENDAFTARAN (no_pendaftaran,tahun,id_jalur,nama_jenjang,nama_program) VALUES (22,'2017',1,'S1','Reguler');
INSERT INTO RIWAYAT_PENDAFTARAN (no_pendaftaran,tahun,id_jalur,nama_jenjang,nama_program) VALUES (23,'2017',1,'S1','Reguler');
INSERT INTO RIWAYAT_PENDAFTARAN (no_pendaftaran,tahun,id_jalur,nama_jenjang,nama_program) VALUES (24,'2017',1,'S1','Reguler');
INSERT INTO RIWAYAT_PENDAFTARAN (no_pendaftaran,tahun,id_jalur,nama_jenjang,nama_program) VALUES (25,'2017',1,'S1','Reguler');
INSERT INTO RIWAYAT_PENDAFTARAN (no_pendaftaran,tahun,id_jalur,nama_jenjang,nama_program) VALUES (26,'2017',1,'S1','Reguler');
INSERT INTO RIWAYAT_PENDAFTARAN (no_pendaftaran,tahun,id_jalur,nama_jenjang,nama_program) VALUES (27,'2017',1,'S1','Reguler');
INSERT INTO RIWAYAT_PENDAFTARAN (no_pendaftaran,tahun,id_jalur,nama_jenjang,nama_program) VALUES (28,'2017',1,'S1','Reguler');
INSERT INTO RIWAYAT_PENDAFTARAN (no_pendaftaran,tahun,id_jalur,nama_jenjang,nama_program) VALUES (29,'2017',1,'S1','Reguler');
INSERT INTO RIWAYAT_PENDAFTARAN (no_pendaftaran,tahun,id_jalur,nama_jenjang,nama_program) VALUES (30,'2017',1,'S1','Reguler');
INSERT INTO RIWAYAT_PENDAFTARAN (no_pendaftaran,tahun,id_jalur,nama_jenjang,nama_program) VALUES (31,'2017',1,'S1','Reguler');
INSERT INTO RIWAYAT_PENDAFTARAN (no_pendaftaran,tahun,id_jalur,nama_jenjang,nama_program) VALUES (32,'2017',1,'S1','Reguler');
INSERT INTO RIWAYAT_PENDAFTARAN (no_pendaftaran,tahun,id_jalur,nama_jenjang,nama_program) VALUES (33,'2017',1,'S1','Reguler');
INSERT INTO RIWAYAT_PENDAFTARAN (no_pendaftaran,tahun,id_jalur,nama_jenjang,nama_program) VALUES (34,'2017',1,'S1','Reguler');
INSERT INTO RIWAYAT_PENDAFTARAN (no_pendaftaran,tahun,id_jalur,nama_jenjang,nama_program) VALUES (35,'2017',1,'S1','Reguler');
INSERT INTO RIWAYAT_PENDAFTARAN (no_pendaftaran,tahun,id_jalur,nama_jenjang,nama_program) VALUES (36,'2017',1,'S1','Reguler');
INSERT INTO RIWAYAT_PENDAFTARAN (no_pendaftaran,tahun,id_jalur,nama_jenjang,nama_program) VALUES (37,'2017',1,'S1','Reguler');
INSERT INTO RIWAYAT_PENDAFTARAN (no_pendaftaran,tahun,id_jalur,nama_jenjang,nama_program) VALUES (38,'2017',1,'S1','Reguler');
INSERT INTO RIWAYAT_PENDAFTARAN (no_pendaftaran,tahun,id_jalur,nama_jenjang,nama_program) VALUES (39,'2017',1,'S1','Reguler');
INSERT INTO RIWAYAT_PENDAFTARAN (no_pendaftaran,tahun,id_jalur,nama_jenjang,nama_program) VALUES (40,'2017',1,'S1','Reguler');
INSERT INTO RIWAYAT_PENDAFTARAN (no_pendaftaran,tahun,id_jalur,nama_jenjang,nama_program) VALUES (41,'2017',2,'S2','Reguler');
INSERT INTO RIWAYAT_PENDAFTARAN (no_pendaftaran,tahun,id_jalur,nama_jenjang,nama_program) VALUES (42,'2017',2,'S2','Reguler');
INSERT INTO RIWAYAT_PENDAFTARAN (no_pendaftaran,tahun,id_jalur,nama_jenjang,nama_program) VALUES (43,'2017',2,'S2','Reguler');
INSERT INTO RIWAYAT_PENDAFTARAN (no_pendaftaran,tahun,id_jalur,nama_jenjang,nama_program) VALUES (44,'2017',2,'S2','Reguler');
INSERT INTO RIWAYAT_PENDAFTARAN (no_pendaftaran,tahun,id_jalur,nama_jenjang,nama_program) VALUES (45,'2017',2,'S2','Reguler');
INSERT INTO RIWAYAT_PENDAFTARAN (no_pendaftaran,tahun,id_jalur,nama_jenjang,nama_program) VALUES (46,'2017',2,'S2','Reguler');
INSERT INTO RIWAYAT_PENDAFTARAN (no_pendaftaran,tahun,id_jalur,nama_jenjang,nama_program) VALUES (47,'2017',2,'S2','Reguler');
INSERT INTO RIWAYAT_PENDAFTARAN (no_pendaftaran,tahun,id_jalur,nama_jenjang,nama_program) VALUES (48,'2017',2,'S2','Reguler');
INSERT INTO RIWAYAT_PENDAFTARAN (no_pendaftaran,tahun,id_jalur,nama_jenjang,nama_program) VALUES (49,'2017',2,'S2','Reguler');
INSERT INTO RIWAYAT_PENDAFTARAN (no_pendaftaran,tahun,id_jalur,nama_jenjang,nama_program) VALUES (50,'2017',2,'S2','Reguler');
INSERT INTO RIWAYAT_PENDAFTARAN (no_pendaftaran,tahun,id_jalur,nama_jenjang,nama_program) VALUES (51,'2017',2,'S2','Reguler');
INSERT INTO RIWAYAT_PENDAFTARAN (no_pendaftaran,tahun,id_jalur,nama_jenjang,nama_program) VALUES (52,'2017',2,'S2','Reguler');
INSERT INTO RIWAYAT_PENDAFTARAN (no_pendaftaran,tahun,id_jalur,nama_jenjang,nama_program) VALUES (53,'2017',2,'S2','Reguler');
INSERT INTO RIWAYAT_PENDAFTARAN (no_pendaftaran,tahun,id_jalur,nama_jenjang,nama_program) VALUES (54,'2017',2,'S2','Reguler');
INSERT INTO RIWAYAT_PENDAFTARAN (no_pendaftaran,tahun,id_jalur,nama_jenjang,nama_program) VALUES (55,'2017',2,'S2','Reguler');
INSERT INTO RIWAYAT_PENDAFTARAN (no_pendaftaran,tahun,id_jalur,nama_jenjang,nama_program) VALUES (56,'2017',5,'S3','Reguler');
INSERT INTO RIWAYAT_PENDAFTARAN (no_pendaftaran,tahun,id_jalur,nama_jenjang,nama_program) VALUES (57,'2017',5,'S3','Reguler');
INSERT INTO RIWAYAT_PENDAFTARAN (no_pendaftaran,tahun,id_jalur,nama_jenjang,nama_program) VALUES (58,'2017',5,'S3','Reguler');
INSERT INTO RIWAYAT_PENDAFTARAN (no_pendaftaran,tahun,id_jalur,nama_jenjang,nama_program) VALUES (59,'2017',5,'S3','Reguler');
INSERT INTO RIWAYAT_PENDAFTARAN (no_pendaftaran,tahun,id_jalur,nama_jenjang,nama_program) VALUES (60,'2017',5,'S3','Reguler');
INSERT INTO RIWAYAT_PENDAFTARAN (no_pendaftaran,tahun,id_jalur,nama_jenjang,nama_program) VALUES (61,'2017',5,'S3','Reguler');
INSERT INTO RIWAYAT_PENDAFTARAN (no_pendaftaran,tahun,id_jalur,nama_jenjang,nama_program) VALUES (62,'2017',5,'S3','Reguler');
INSERT INTO RIWAYAT_PENDAFTARAN (no_pendaftaran,tahun,id_jalur,nama_jenjang,nama_program) VALUES (63,'2017',5,'S3','Reguler');
INSERT INTO RIWAYAT_PENDAFTARAN (no_pendaftaran,tahun,id_jalur,nama_jenjang,nama_program) VALUES (64,'2017',3,'S1','Paralel');
INSERT INTO RIWAYAT_PENDAFTARAN (no_pendaftaran,tahun,id_jalur,nama_jenjang,nama_program) VALUES (65,'2017',3,'S1','Paralel');
INSERT INTO RIWAYAT_PENDAFTARAN (no_pendaftaran,tahun,id_jalur,nama_jenjang,nama_program) VALUES (66,'2017',3,'S1','Paralel');
INSERT INTO RIWAYAT_PENDAFTARAN (no_pendaftaran,tahun,id_jalur,nama_jenjang,nama_program) VALUES (67,'2017',3,'S1','Paralel');
INSERT INTO RIWAYAT_PENDAFTARAN (no_pendaftaran,tahun,id_jalur,nama_jenjang,nama_program) VALUES (68,'2017',3,'S1','Paralel');
INSERT INTO RIWAYAT_PENDAFTARAN (no_pendaftaran,tahun,id_jalur,nama_jenjang,nama_program) VALUES (69,'2017',3,'S1','Paralel');
INSERT INTO RIWAYAT_PENDAFTARAN (no_pendaftaran,tahun,id_jalur,nama_jenjang,nama_program) VALUES (70,'2017',3,'S1','Paralel');
INSERT INTO RIWAYAT_PENDAFTARAN (no_pendaftaran,tahun,id_jalur,nama_jenjang,nama_program) VALUES (71,'2017',3,'S1','Paralel');
INSERT INTO RIWAYAT_PENDAFTARAN (no_pendaftaran,tahun,id_jalur,nama_jenjang,nama_program) VALUES (72,'2017',3,'S1','Paralel');
INSERT INTO RIWAYAT_PENDAFTARAN (no_pendaftaran,tahun,id_jalur,nama_jenjang,nama_program) VALUES (73,'2017',3,'S1','Paralel');
INSERT INTO RIWAYAT_PENDAFTARAN (no_pendaftaran,tahun,id_jalur,nama_jenjang,nama_program) VALUES (74,'2017',3,'S1','Paralel');
INSERT INTO RIWAYAT_PENDAFTARAN (no_pendaftaran,tahun,id_jalur,nama_jenjang,nama_program) VALUES (75,'2017',3,'S1','Paralel');
INSERT INTO RIWAYAT_PENDAFTARAN (no_pendaftaran,tahun,id_jalur,nama_jenjang,nama_program) VALUES (76,'2017',3,'S1','Paralel');
INSERT INTO RIWAYAT_PENDAFTARAN (no_pendaftaran,tahun,id_jalur,nama_jenjang,nama_program) VALUES (77,'2017',3,'S1','Paralel');
INSERT INTO RIWAYAT_PENDAFTARAN (no_pendaftaran,tahun,id_jalur,nama_jenjang,nama_program) VALUES (78,'2017',3,'S1','Paralel');
INSERT INTO RIWAYAT_PENDAFTARAN (no_pendaftaran,tahun,id_jalur,nama_jenjang,nama_program) VALUES (79,'2017',3,'S1','Paralel');
INSERT INTO RIWAYAT_PENDAFTARAN (no_pendaftaran,tahun,id_jalur,nama_jenjang,nama_program) VALUES (80,'2017',3,'S1','Paralel');
INSERT INTO RIWAYAT_PENDAFTARAN (no_pendaftaran,tahun,id_jalur,nama_jenjang,nama_program) VALUES (81,'2017',3,'S1','Paralel');
INSERT INTO RIWAYAT_PENDAFTARAN (no_pendaftaran,tahun,id_jalur,nama_jenjang,nama_program) VALUES (82,'2017',3,'S1','Paralel');
INSERT INTO RIWAYAT_PENDAFTARAN (no_pendaftaran,tahun,id_jalur,nama_jenjang,nama_program) VALUES (83,'2017',3,'S1','Paralel');
INSERT INTO RIWAYAT_PENDAFTARAN (no_pendaftaran,tahun,id_jalur,nama_jenjang,nama_program) VALUES (84,'2017',3,'S1','Paralel');
INSERT INTO RIWAYAT_PENDAFTARAN (no_pendaftaran,tahun,id_jalur,nama_jenjang,nama_program) VALUES (85,'2017',3,'S1','Paralel');
INSERT INTO RIWAYAT_PENDAFTARAN (no_pendaftaran,tahun,id_jalur,nama_jenjang,nama_program) VALUES (86,'2017',3,'S1','Paralel');
INSERT INTO RIWAYAT_PENDAFTARAN (no_pendaftaran,tahun,id_jalur,nama_jenjang,nama_program) VALUES (87,'2017',3,'S1','Paralel');
INSERT INTO RIWAYAT_PENDAFTARAN (no_pendaftaran,tahun,id_jalur,nama_jenjang,nama_program) VALUES (88,'2017',3,'S1','Paralel');
INSERT INTO RIWAYAT_PENDAFTARAN (no_pendaftaran,tahun,id_jalur,nama_jenjang,nama_program) VALUES (89,'2017',3,'S1','Paralel');
INSERT INTO RIWAYAT_PENDAFTARAN (no_pendaftaran,tahun,id_jalur,nama_jenjang,nama_program) VALUES (90,'2017',3,'S1','Paralel');
INSERT INTO RIWAYAT_PENDAFTARAN (no_pendaftaran,tahun,id_jalur,nama_jenjang,nama_program) VALUES (91,'2017',3,'S1','Paralel');
INSERT INTO RIWAYAT_PENDAFTARAN (no_pendaftaran,tahun,id_jalur,nama_jenjang,nama_program) VALUES (92,'2017',3,'S1','Paralel');
INSERT INTO RIWAYAT_PENDAFTARAN (no_pendaftaran,tahun,id_jalur,nama_jenjang,nama_program) VALUES (93,'2017',3,'S1','Paralel');
INSERT INTO RIWAYAT_PENDAFTARAN (no_pendaftaran,tahun,id_jalur,nama_jenjang,nama_program) VALUES (94,'2017',3,'S1','Paralel');
INSERT INTO RIWAYAT_PENDAFTARAN (no_pendaftaran,tahun,id_jalur,nama_jenjang,nama_program) VALUES (95,'2017',3,'S1','Paralel');

INSERT INTO PENYELEKSIAN (no_daftar,status,id_jalur,status_rekomen,berkas) VALUES (1,1,1,0,null);
INSERT INTO PENYELEKSIAN (no_daftar,status,id_jalur,status_rekomen,berkas) VALUES (2,1,1,0,null);
INSERT INTO PENYELEKSIAN (no_daftar,status,id_jalur,status_rekomen,berkas) VALUES (3,1,1,0,null);
INSERT INTO PENYELEKSIAN (no_daftar,status,id_jalur,status_rekomen,berkas) VALUES (4,1,1,0,null);
INSERT INTO PENYELEKSIAN (no_daftar,status,id_jalur,status_rekomen,berkas) VALUES (5,1,1,0,null);
INSERT INTO PENYELEKSIAN (no_daftar,status,id_jalur,status_rekomen,berkas) VALUES (6,1,1,0,null);
INSERT INTO PENYELEKSIAN (no_daftar,status,id_jalur,status_rekomen,berkas) VALUES (7,1,1,0,null);
INSERT INTO PENYELEKSIAN (no_daftar,status,id_jalur,status_rekomen,berkas) VALUES (8,1,1,0,null);
INSERT INTO PENYELEKSIAN (no_daftar,status,id_jalur,status_rekomen,berkas) VALUES (9,1,1,0,null);
INSERT INTO PENYELEKSIAN (no_daftar,status,id_jalur,status_rekomen,berkas) VALUES (10,1,1,0,null);
INSERT INTO PENYELEKSIAN (no_daftar,status,id_jalur,status_rekomen,berkas) VALUES (11,0,1,0,null);
INSERT INTO PENYELEKSIAN (no_daftar,status,id_jalur,status_rekomen,berkas) VALUES (12,1,1,0,null);
INSERT INTO PENYELEKSIAN (no_daftar,status,id_jalur,status_rekomen,berkas) VALUES (13,1,1,0,null);
INSERT INTO PENYELEKSIAN (no_daftar,status,id_jalur,status_rekomen,berkas) VALUES (14,1,1,0,null);
INSERT INTO PENYELEKSIAN (no_daftar,status,id_jalur,status_rekomen,berkas) VALUES (15,1,1,0,null);
INSERT INTO PENYELEKSIAN (no_daftar,status,id_jalur,status_rekomen,berkas) VALUES (16,1,1,0,null);
INSERT INTO PENYELEKSIAN (no_daftar,status,id_jalur,status_rekomen,berkas) VALUES (17,1,1,0,null);
INSERT INTO PENYELEKSIAN (no_daftar,status,id_jalur,status_rekomen,berkas) VALUES (18,1,1,0,null);
INSERT INTO PENYELEKSIAN (no_daftar,status,id_jalur,status_rekomen,berkas) VALUES (19,1,1,0,null);
INSERT INTO PENYELEKSIAN (no_daftar,status,id_jalur,status_rekomen,berkas) VALUES (20,1,1,0,null);
INSERT INTO PENYELEKSIAN (no_daftar,status,id_jalur,status_rekomen,berkas) VALUES (21,0,1,0,null);
INSERT INTO PENYELEKSIAN (no_daftar,status,id_jalur,status_rekomen,berkas) VALUES (22,1,1,0,null);
INSERT INTO PENYELEKSIAN (no_daftar,status,id_jalur,status_rekomen,berkas) VALUES (23,1,1,0,null);
INSERT INTO PENYELEKSIAN (no_daftar,status,id_jalur,status_rekomen,berkas) VALUES (24,1,1,0,null);
INSERT INTO PENYELEKSIAN (no_daftar,status,id_jalur,status_rekomen,berkas) VALUES (25,1,1,0,null);
INSERT INTO PENYELEKSIAN (no_daftar,status,id_jalur,status_rekomen,berkas) VALUES (26,0,1,0,null);
INSERT INTO PENYELEKSIAN (no_daftar,status,id_jalur,status_rekomen,berkas) VALUES (27,1,1,0,null);
INSERT INTO PENYELEKSIAN (no_daftar,status,id_jalur,status_rekomen,berkas) VALUES (28,1,1,0,null);
INSERT INTO PENYELEKSIAN (no_daftar,status,id_jalur,status_rekomen,berkas) VALUES (29,1,1,0,null);
INSERT INTO PENYELEKSIAN (no_daftar,status,id_jalur,status_rekomen,berkas) VALUES (30,1,1,0,null);
INSERT INTO PENYELEKSIAN (no_daftar,status,id_jalur,status_rekomen,berkas) VALUES (31,0,1,0,null);
INSERT INTO PENYELEKSIAN (no_daftar,status,id_jalur,status_rekomen,berkas) VALUES (32,0,1,0,null);
INSERT INTO PENYELEKSIAN (no_daftar,status,id_jalur,status_rekomen,berkas) VALUES (33,1,1,0,null);
INSERT INTO PENYELEKSIAN (no_daftar,status,id_jalur,status_rekomen,berkas) VALUES (34,1,1,0,null);
INSERT INTO PENYELEKSIAN (no_daftar,status,id_jalur,status_rekomen,berkas) VALUES (35,1,1,0,null);
INSERT INTO PENYELEKSIAN (no_daftar,status,id_jalur,status_rekomen,berkas) VALUES (36,1,1,0,null);
INSERT INTO PENYELEKSIAN (no_daftar,status,id_jalur,status_rekomen,berkas) VALUES (37,1,1,0,null);
INSERT INTO PENYELEKSIAN (no_daftar,status,id_jalur,status_rekomen,berkas) VALUES (38,1,1,0,null);
INSERT INTO PENYELEKSIAN (no_daftar,status,id_jalur,status_rekomen,berkas) VALUES (39,0,1,0,null);
INSERT INTO PENYELEKSIAN (no_daftar,status,id_jalur,status_rekomen,berkas) VALUES (40,1,1,0,null);
INSERT INTO PENYELEKSIAN (no_daftar,status,id_jalur,status_rekomen,berkas) VALUES (41,0,2,0,null);
INSERT INTO PENYELEKSIAN (no_daftar,status,id_jalur,status_rekomen,berkas) VALUES (42,1,2,0,null);
INSERT INTO PENYELEKSIAN (no_daftar,status,id_jalur,status_rekomen,berkas) VALUES (43,1,2,0,null);
INSERT INTO PENYELEKSIAN (no_daftar,status,id_jalur,status_rekomen,berkas) VALUES (44,1,2,0,null);
INSERT INTO PENYELEKSIAN (no_daftar,status,id_jalur,status_rekomen,berkas) VALUES (45,1,2,0,null);
INSERT INTO PENYELEKSIAN (no_daftar,status,id_jalur,status_rekomen,berkas) VALUES (46,1,2,0,null);
INSERT INTO PENYELEKSIAN (no_daftar,status,id_jalur,status_rekomen,berkas) VALUES (47,1,2,0,null);
INSERT INTO PENYELEKSIAN (no_daftar,status,id_jalur,status_rekomen,berkas) VALUES (48,1,2,0,null);
INSERT INTO PENYELEKSIAN (no_daftar,status,id_jalur,status_rekomen,berkas) VALUES (49,0,2,0,null);
INSERT INTO PENYELEKSIAN (no_daftar,status,id_jalur,status_rekomen,berkas) VALUES (50,1,2,0,null);
INSERT INTO PENYELEKSIAN (no_daftar,status,id_jalur,status_rekomen,berkas) VALUES (51,1,2,0,null);
INSERT INTO PENYELEKSIAN (no_daftar,status,id_jalur,status_rekomen,berkas) VALUES (52,1,2,0,null);
INSERT INTO PENYELEKSIAN (no_daftar,status,id_jalur,status_rekomen,berkas) VALUES (53,1,2,0,null);
INSERT INTO PENYELEKSIAN (no_daftar,status,id_jalur,status_rekomen,berkas) VALUES (54,1,2,0,null);
INSERT INTO PENYELEKSIAN (no_daftar,status,id_jalur,status_rekomen,berkas) VALUES (55,1,2,0,null);
INSERT INTO PENYELEKSIAN (no_daftar,status,id_jalur,status_rekomen,berkas) VALUES (56,1,5,0,null);
INSERT INTO PENYELEKSIAN (no_daftar,status,id_jalur,status_rekomen,berkas) VALUES (57,0,5,0,null);
INSERT INTO PENYELEKSIAN (no_daftar,status,id_jalur,status_rekomen,berkas) VALUES (58,1,5,0,null);
INSERT INTO PENYELEKSIAN (no_daftar,status,id_jalur,status_rekomen,berkas) VALUES (59,1,5,0,null);
INSERT INTO PENYELEKSIAN (no_daftar,status,id_jalur,status_rekomen,berkas) VALUES (60,0,5,0,null);
INSERT INTO PENYELEKSIAN (no_daftar,status,id_jalur,status_rekomen,berkas) VALUES (61,1,5,0,null);
INSERT INTO PENYELEKSIAN (no_daftar,status,id_jalur,status_rekomen,berkas) VALUES (62,1,5,0,null);
INSERT INTO PENYELEKSIAN (no_daftar,status,id_jalur,status_rekomen,berkas) VALUES (63,1,5,0,null);
INSERT INTO PENYELEKSIAN (no_daftar,status,id_jalur,status_rekomen,berkas) VALUES (64,1,3,0,null);
INSERT INTO PENYELEKSIAN (no_daftar,status,id_jalur,status_rekomen,berkas) VALUES (65,1,3,0,null);
INSERT INTO PENYELEKSIAN (no_daftar,status,id_jalur,status_rekomen,berkas) VALUES (66,1,3,0,null);
INSERT INTO PENYELEKSIAN (no_daftar,status,id_jalur,status_rekomen,berkas) VALUES (67,1,3,0,null);
INSERT INTO PENYELEKSIAN (no_daftar,status,id_jalur,status_rekomen,berkas) VALUES (68,1,3,1,null);
INSERT INTO PENYELEKSIAN (no_daftar,status,id_jalur,status_rekomen,berkas) VALUES (69,1,3,0,null);
INSERT INTO PENYELEKSIAN (no_daftar,status,id_jalur,status_rekomen,berkas) VALUES (70,1,3,0,null);
INSERT INTO PENYELEKSIAN (no_daftar,status,id_jalur,status_rekomen,berkas) VALUES (71,1,3,0,null);
INSERT INTO PENYELEKSIAN (no_daftar,status,id_jalur,status_rekomen,berkas) VALUES (72,1,3,1,null);
INSERT INTO PENYELEKSIAN (no_daftar,status,id_jalur,status_rekomen,berkas) VALUES (73,1,3,0,null);
INSERT INTO PENYELEKSIAN (no_daftar,status,id_jalur,status_rekomen,berkas) VALUES (74,0,3,0,null);
INSERT INTO PENYELEKSIAN (no_daftar,status,id_jalur,status_rekomen,berkas) VALUES (75,1,3,0,null);
INSERT INTO PENYELEKSIAN (no_daftar,status,id_jalur,status_rekomen,berkas) VALUES (76,1,3,0,null);
INSERT INTO PENYELEKSIAN (no_daftar,status,id_jalur,status_rekomen,berkas) VALUES (77,1,3,1,null);
INSERT INTO PENYELEKSIAN (no_daftar,status,id_jalur,status_rekomen,berkas) VALUES (78,1,3,0,null);
INSERT INTO PENYELEKSIAN (no_daftar,status,id_jalur,status_rekomen,berkas) VALUES (79,1,3,0,null);
INSERT INTO PENYELEKSIAN (no_daftar,status,id_jalur,status_rekomen,berkas) VALUES (80,1,3,0,null);
INSERT INTO PENYELEKSIAN (no_daftar,status,id_jalur,status_rekomen,berkas) VALUES (81,1,3,0,null);
INSERT INTO PENYELEKSIAN (no_daftar,status,id_jalur,status_rekomen,berkas) VALUES (82,1,3,0,null);
INSERT INTO PENYELEKSIAN (no_daftar,status,id_jalur,status_rekomen,berkas) VALUES (83,1,3,0,null);
INSERT INTO PENYELEKSIAN (no_daftar,status,id_jalur,status_rekomen,berkas) VALUES (84,0,3,1,null);
INSERT INTO PENYELEKSIAN (no_daftar,status,id_jalur,status_rekomen,berkas) VALUES (85,1,3,0,null);
INSERT INTO PENYELEKSIAN (no_daftar,status,id_jalur,status_rekomen,berkas) VALUES (86,1,3,0,null);
INSERT INTO PENYELEKSIAN (no_daftar,status,id_jalur,status_rekomen,berkas) VALUES (87,1,3,1,null);
INSERT INTO PENYELEKSIAN (no_daftar,status,id_jalur,status_rekomen,berkas) VALUES (88,1,3,0,null);
INSERT INTO PENYELEKSIAN (no_daftar,status,id_jalur,status_rekomen,berkas) VALUES (89,0,3,0,null);
INSERT INTO PENYELEKSIAN (no_daftar,status,id_jalur,status_rekomen,berkas) VALUES (90,1,3,0,null);
INSERT INTO PENYELEKSIAN (no_daftar,status,id_jalur,status_rekomen,berkas) VALUES (91,1,3,0,null);
INSERT INTO PENYELEKSIAN (no_daftar,status,id_jalur,status_rekomen,berkas) VALUES (92,1,3,1,null);
INSERT INTO PENYELEKSIAN (no_daftar,status,id_jalur,status_rekomen,berkas) VALUES (93,1,3,1,null);
INSERT INTO PENYELEKSIAN (no_daftar,status,id_jalur,status_rekomen,berkas) VALUES (94,0,3,0,null);
INSERT INTO PENYELEKSIAN (no_daftar,status,id_jalur,status_rekomen,berkas) VALUES (95,0,3,0,null);

INSERT INTO NILAI_UJIAN (no_daftar,tpa,mtk_dasar,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing) VALUES (1,80,75,75,70,80,81,0,0,0,0,80,75);
INSERT INTO NILAI_UJIAN (no_daftar,tpa,mtk_dasar,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing) VALUES (2,80,75,75,70,80,81,0,0,0,0,80,75);
INSERT INTO NILAI_UJIAN (no_daftar,tpa,mtk_dasar,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing) VALUES (3,80,81,72,70,80,81,0,0,0,0,80,75);
INSERT INTO NILAI_UJIAN (no_daftar,tpa,mtk_dasar,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing) VALUES (4,80,81,72,0,0,0,80,80,80,70,80,75);
INSERT INTO NILAI_UJIAN (no_daftar,tpa,mtk_dasar,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing) VALUES (5,80,81,0,0,0,70,80,80,75,65,74,75);
INSERT INTO NILAI_UJIAN (no_daftar,tpa,mtk_dasar,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing) VALUES (6,80,81,0,0,0,88,85,80,75,80,80,75);
INSERT INTO NILAI_UJIAN (no_daftar,tpa,mtk_dasar,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing) VALUES (7,80,81,0,0,0,70,80,70,80,80,80,75);
INSERT INTO NILAI_UJIAN (no_daftar,tpa,mtk_dasar,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing) VALUES (8,80,81,72,65,74,70,80,70,80,80,75,75);
INSERT INTO NILAI_UJIAN (no_daftar,tpa,mtk_dasar,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing) VALUES (9,80,81,72,81,72,80,75,70,80,80,75,75);
INSERT INTO NILAI_UJIAN (no_daftar,tpa,mtk_dasar,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing) VALUES (10,80,81,72,70,80,80,75,70,80,88,85,75);
INSERT INTO NILAI_UJIAN (no_daftar,tpa,mtk_dasar,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing) VALUES (11,80,70,80,88,85,80,81,70,80,70,80,75);
INSERT INTO NILAI_UJIAN (no_daftar,tpa,mtk_dasar,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing) VALUES (12,80,70,80,70,80,80,81,70,80,65,74,75);
INSERT INTO NILAI_UJIAN (no_daftar,tpa,mtk_dasar,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing) VALUES (13,80,70,80,81,72,80,81,65,74,65,74,75);
INSERT INTO NILAI_UJIAN (no_daftar,tpa,mtk_dasar,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing) VALUES (14,80,70,80,81,72,80,81,80,80,65,74,75);
INSERT INTO NILAI_UJIAN (no_daftar,tpa,mtk_dasar,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing) VALUES (15,80,70,80,81,72,80,81,80,80,65,74,75);
INSERT INTO NILAI_UJIAN (no_daftar,tpa,mtk_dasar,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing) VALUES (16,80,70,80,70,80,81,72,80,75,65,74,75);
INSERT INTO NILAI_UJIAN (no_daftar,tpa,mtk_dasar,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing) VALUES (17,80,70,80,70,80,81,72,80,75,65,74,75);
INSERT INTO NILAI_UJIAN (no_daftar,tpa,mtk_dasar,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing) VALUES (18,80,70,80,88,85,81,72,80,81,65,74,75);
INSERT INTO NILAI_UJIAN (no_daftar,tpa,mtk_dasar,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing) VALUES (19,80,70,80,70,80,70,80,80,81,65,74,75);
INSERT INTO NILAI_UJIAN (no_daftar,tpa,mtk_dasar,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing) VALUES (20,84,70,80,70,80,70,80,80,81,86,74,75);
INSERT INTO NILAI_UJIAN (no_daftar,tpa,mtk_dasar,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing) VALUES (21,84,70,80,70,80,88,85,80,81,81,72,75);
INSERT INTO NILAI_UJIAN (no_daftar,tpa,mtk_dasar,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing) VALUES (22,84,65,74,70,80,70,80,80,81,70,80,75);
INSERT INTO NILAI_UJIAN (no_daftar,tpa,mtk_dasar,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing) VALUES (23,84,65,74,65,74,70,80,86,74,80,75,75);
INSERT INTO NILAI_UJIAN (no_daftar,tpa,mtk_dasar,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing) VALUES (24,84,65,74,80,80,70,80,86,74,80,75,75);
INSERT INTO NILAI_UJIAN (no_daftar,tpa,mtk_dasar,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing) VALUES (25,84,65,74,80,80,82,80,81,72,80,81,75);
INSERT INTO NILAI_UJIAN (no_daftar,tpa,mtk_dasar,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing) VALUES (26,84,65,74,80,75,82,80,70,80,80,81,75);
INSERT INTO NILAI_UJIAN (no_daftar,tpa,mtk_dasar,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing) VALUES (27,84,65,74,80,75,82,80,70,80,80,81,75);
INSERT INTO NILAI_UJIAN (no_daftar,tpa,mtk_dasar,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing) VALUES (28,84,65,74,70,80,70,80,80,70,80,81,75);
INSERT INTO NILAI_UJIAN (no_daftar,tpa,mtk_dasar,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing) VALUES (29,84,65,74,65,74,70,80,74,70,80,81,75);
INSERT INTO NILAI_UJIAN (no_daftar,tpa,mtk_dasar,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing) VALUES (30,84,65,74,80,80,70,80,74,65,70,82,75);
INSERT INTO NILAI_UJIAN (no_daftar,tpa,mtk_dasar,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing) VALUES (31,84,65,74,70,80,74,80,74,80,81,72,75);
INSERT INTO NILAI_UJIAN (no_daftar,tpa,mtk_dasar,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing) VALUES (32,84,65,74,65,74,72,80,74,80,81,72,75);
INSERT INTO NILAI_UJIAN (no_daftar,tpa,mtk_dasar,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing) VALUES (33,84,65,74,80,80,70,80,70,80,81,72,75);
INSERT INTO NILAI_UJIAN (no_daftar,tpa,mtk_dasar,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing) VALUES (34,85,65,74,70,80,65,74,70,80,70,80,75);
INSERT INTO NILAI_UJIAN (no_daftar,tpa,mtk_dasar,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing) VALUES (35,85,65,74,65,74,80,80,70,80,70,80,75);
INSERT INTO NILAI_UJIAN (no_daftar,tpa,mtk_dasar,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing) VALUES (36,85,65,74,80,75,70,80,65,74,88,85,75);
INSERT INTO NILAI_UJIAN (no_daftar,tpa,mtk_dasar,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing) VALUES (37,85,65,74,80,75,65,74,86,74,70,80,75);
INSERT INTO NILAI_UJIAN (no_daftar,tpa,mtk_dasar,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing) VALUES (38,85,65,74,70,80,80,80,81,72,70,80,75);
INSERT INTO NILAI_UJIAN (no_daftar,tpa,mtk_dasar,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing) VALUES (39,85,65,74,65,74,80,80,70,80,70,80,75);
INSERT INTO NILAI_UJIAN (no_daftar,tpa,mtk_dasar,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing) VALUES (40,85,65,74,80,80,80,75,80,75,65,74,75);

INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_sosiologi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (64,70,0,0,0,70,70,70,70,70,70,75,0,0,0,81,72,70,80,70,80,1);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_sosiologi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (64,70,0,0,0,70,70,70,70,70,70,75,0,0,0,81,72,65,74,70,80,2);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_sosiologi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (64,70,0,0,0,70,70,70,70,70,70,72,0,0,0,81,72,80,80,70,80,3);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_sosiologi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (64,70,0,0,0,70,70,70,70,70,70,72,0,0,0,70,80,80,80,70,80,4);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_sosiologi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (64,70,0,0,0,70,70,70,70,70,70,72,0,0,0,70,80,80,75,65,74,5);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_sosiologi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (65,75,0,0,0,75,75,75,70,75,75,72,0,0,0,88,85,80,75,80,80,1);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_sosiologi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (65,75,0,0,0,75,75,75,70,75,75,72,0,0,0,70,80,70,80,80,80,2);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_sosiologi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (65,75,0,0,0,75,75,75,70,75,75,72,0,0,0,70,80,70,80,80,75,3);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_sosiologi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (65,75,0,0,0,75,75,75,70,75,75,72,0,0,0,80,75,70,80,80,75,4);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_sosiologi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (65,75,0,0,0,75,75,75,70,75,75,72,0,0,0,80,75,70,80,88,85,5);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_sosiologi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (66,78,0,0,0,78,78,78,70,78,78,80,0,0,0,80,81,70,80,70,80,1);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_sosiologi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (66,78,0,0,0,78,78,78,70,78,78,80,0,0,0,80,81,70,80,65,74,2);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_sosiologi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (66,78,0,0,0,78,78,78,70,78,78,80,0,0,0,80,81,65,74,65,74,3);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_sosiologi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (66,78,0,0,0,78,78,78,70,78,78,80,0,0,0,80,81,80,80,65,74,4);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_sosiologi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (66,78,0,0,0,78,78,78,70,78,78,80,0,0,0,80,81,80,80,65,74,5);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_sosiologi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (67,75,0,0,0,75,75,75,70,75,75,80,0,0,0,81,72,80,75,65,74,1);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_sosiologi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (67,75,0,0,0,75,75,75,70,75,75,80,0,0,0,81,72,80,75,65,74,2);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_sosiologi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (67,75,0,0,0,75,75,75,70,75,75,80,0,0,0,81,72,80,81,65,74,3);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_sosiologi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (67,75,75,75,75,0,0,0,0,75,75,76,80,70,80,0,0,0,0,65,74,4);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_sosiologi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (67,75,75,75,75,0,0,0,0,75,75,76,80,70,80,0,0,0,0,86,74,5);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_sosiologi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (68,75,75,75,75,0,0,0,0,75,75,76,80,70,80,0,0,0,0,81,72,1);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_sosiologi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (68,75,75,75,75,0,0,0,0,75,75,76,74,70,80,0,0,0,0,70,80,2);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_sosiologi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (68,75,75,75,75,0,0,0,0,75,75,76,74,65,74,0,0,0,0,80,75,3);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_sosiologi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (68,75,75,75,75,0,0,0,0,75,75,76,74,80,80,0,0,0,0,80,75,4);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_sosiologi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (68,75,75,75,75,0,0,0,0,75,75,76,74,80,80,0,0,0,0,80,81,5);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_sosiologi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (69,75,75,75,75,0,0,0,0,75,75,76,74,80,75,0,0,0,0,80,81,1);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_sosiologi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (69,75,75,75,75,0,0,0,0,75,75,76,74,80,75,0,0,0,0,80,81,2);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_sosiologi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (69,75,75,75,75,0,0,0,0,75,75,76,74,70,80,0,0,0,0,80,81,3);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_sosiologi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (69,75,75,75,75,0,0,0,0,75,75,76,74,65,74,0,0,0,0,80,81,4);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_sosiologi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (69,75,75,75,75,0,0,0,0,75,75,76,74,80,80,0,0,0,0,70,82,5);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_sosiologi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (70,78,78,78,78,0,0,0,0,75,78,76,74,70,80,0,0,0,0,81,72,1);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_sosiologi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (70,78,78,78,78,0,0,0,0,75,78,76,74,65,74,0,0,0,0,81,72,2);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_sosiologi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (70,78,78,78,78,0,0,0,0,75,78,76,74,80,80,0,0,0,0,81,72,3);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_sosiologi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (70,78,78,78,78,0,0,0,0,75,78,76,74,70,80,0,0,0,0,70,80,4);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_sosiologi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (70,78,78,78,78,0,0,0,0,75,78,76,74,65,74,0,0,0,0,70,80,5);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (71,75,75,75,75,75,75,75,75,75,74,80,75,70,80,65,80,74,88,85,1);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (71,75,75,75,75,75,75,75,75,75,74,80,75,65,74,86,74,89,70,80,2);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (71,75,75,75,75,75,75,75,75,75,74,70,80,80,80,81,72,80,70,80,3);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (71,75,75,75,75,75,75,75,75,75,74,65,74,80,80,70,80,80,70,80,4);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (71,75,75,75,75,75,75,75,75,75,74,80,80,80,75,80,75,80,65,74,5);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (72,70,70,70,70,70,70,70,70,70,75,70,80,81,72,70,80,80,70,80,1);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (72,70,70,70,70,70,70,70,70,70,75,70,80,81,72,65,74,80,70,80,2);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (72,70,70,70,70,70,70,70,70,70,72,70,80,81,72,80,80,80,70,80,3);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (72,70,70,70,70,70,70,70,70,70,72,70,80,70,80,80,80,80,70,80,4);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (72,70,70,70,70,70,70,70,70,70,72,70,80,70,80,80,75,80,65,74,5);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (73,70,70,70,70,70,70,70,70,70,72,70,80,88,85,80,75,80,80,80,1);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (73,70,70,70,70,70,70,70,70,70,72,70,80,70,80,70,80,80,80,80,2);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (73,70,70,70,70,70,70,70,70,70,72,65,74,70,80,70,80,80,80,75,3);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (73,70,70,70,70,70,70,70,70,70,72,81,72,80,75,70,80,80,80,75,4);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (73,70,70,70,70,70,70,70,70,70,72,70,80,80,75,70,80,88,80,85,5);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (74,80,80,80,80,80,80,80,80,80,80,88,85,80,81,70,80,70,80,80,1);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (74,80,80,80,80,80,80,80,80,80,80,70,80,80,81,70,80,65,80,74,2);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (74,80,80,80,80,80,80,80,80,80,80,81,72,80,81,65,74,65,80,74,3);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (74,80,80,80,80,80,80,80,80,80,80,81,72,80,81,80,80,65,80,74,4);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (74,80,80,80,80,80,80,80,80,80,80,81,72,80,81,80,80,65,80,74,5);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (75,75,75,75,75,75,75,75,75,75,80,70,80,81,72,80,75,65,80,74,1);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (75,75,75,75,75,75,75,75,75,75,80,70,80,81,72,80,75,65,80,74,2);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (75,75,75,75,75,75,75,75,75,75,80,88,85,81,72,80,81,65,80,74,3);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (75,75,75,75,75,75,75,75,75,75,80,70,80,70,80,80,81,65,80,74,4);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (75,75,75,75,75,75,75,75,75,75,80,70,80,70,80,80,81,86,80,74,5);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (76,70,70,70,70,70,70,70,70,70,80,70,80,88,85,80,81,81,80,72,1);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (76,70,70,70,70,70,70,70,70,70,74,70,80,70,80,80,81,70,80,80,2);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (76,70,70,70,70,70,70,70,70,70,74,65,74,70,80,86,74,80,80,75,3);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (76,70,70,70,70,70,70,70,70,70,74,80,80,70,80,86,74,80,80,75,4);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (76,70,70,70,70,70,70,70,70,70,74,80,80,82,80,81,72,80,80,81,5);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (77,72,72,72,72,72,72,72,72,72,74,80,75,82,80,70,80,80,80,81,1);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (77,72,72,72,72,72,72,72,72,72,74,80,75,82,80,70,80,80,80,81,2);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (77,72,72,72,72,72,72,72,72,72,74,70,80,70,80,80,70,80,80,81,3);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (77,72,72,72,72,72,72,72,72,72,74,65,74,70,80,74,70,80,80,81,4);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (77,72,72,72,72,72,72,72,72,72,74,80,80,70,80,74,65,70,80,82,5);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (78,70,70,70,70,70,70,70,70,70,74,70,80,74,80,74,80,81,80,72,1);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (78,70,70,70,70,70,70,70,70,70,74,80,80,70,80,74,65,70,80,82,2);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (78,70,70,70,70,70,70,70,70,70,74,70,80,74,80,74,80,81,80,72,3);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (78,70,70,70,70,70,70,70,70,70,74,65,74,72,80,74,80,81,80,72,4);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (78,70,70,70,70,70,70,70,70,70,74,80,80,70,80,70,80,81,80,72,5);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (79,75,75,75,75,75,75,75,75,75,74,70,80,65,74,70,80,70,80,80,1);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (79,75,75,75,75,75,75,75,75,75,74,65,74,80,80,70,80,70,80,80,2);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (79,75,75,75,75,75,75,75,75,75,74,80,75,70,80,65,74,88,80,85,3);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (79,75,75,75,75,75,75,75,75,75,74,80,75,65,74,86,74,70,80,80,4);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (79,75,75,75,75,75,75,75,75,75,74,70,80,80,80,81,72,70,80,80,5);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (80,70,70,70,70,70,70,70,70,70,74,65,74,80,80,70,80,70,80,80,1);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (80,70,70,70,70,70,70,70,70,70,74,80,80,80,75,80,75,65,80,74,2);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (80,70,70,70,70,70,70,70,70,70,75,70,80,81,72,70,80,70,80,80,3);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (80,70,70,70,70,70,70,70,70,70,75,70,80,81,72,65,74,70,80,80,4);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (80,70,70,70,70,70,70,70,70,70,72,70,80,81,72,80,80,70,80,80,5);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (81,72,72,72,72,72,72,72,72,72,72,70,80,70,80,80,80,70,80,80,1);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (81,72,72,72,72,72,72,72,72,72,72,70,80,70,80,80,75,65,80,74,2);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (81,72,72,72,72,72,72,72,72,72,72,70,80,88,85,80,75,80,80,80,3);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (81,72,72,72,72,72,72,72,72,72,72,70,80,70,80,70,80,80,80,80,4);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (81,72,72,72,72,72,72,72,72,72,72,65,74,70,80,70,80,80,80,75,5);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (82,72,72,72,72,72,72,72,72,72,72,81,72,80,75,70,80,80,75,80,1);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (82,72,72,72,72,72,72,72,72,72,74,65,74,70,80,86,74,80,80,75,2);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (82,72,72,72,72,72,72,72,72,72,74,80,80,70,80,86,74,80,80,75,3);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (82,72,72,72,72,72,72,72,72,72,74,80,80,82,80,81,72,80,81,80,4);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (82,72,72,72,72,72,72,72,72,72,74,80,75,82,80,70,80,80,81,80,5);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (83,70,70,70,70,70,70,70,70,70,74,80,75,82,80,70,80,80,81,80,1);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (83,70,70,70,70,70,70,70,70,70,74,70,80,70,80,80,70,80,81,80,2);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (83,70,70,70,70,70,70,70,70,70,74,65,74,70,80,74,70,80,81,80,3);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (83,70,70,70,70,70,70,70,70,70,74,80,80,70,80,74,65,70,82,80,4);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (83,70,70,70,70,70,70,70,70,70,74,70,80,74,80,74,80,81,72,80,5);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (84,80,80,80,80,80,80,80,80,80,74,80,80,70,80,74,65,70,82,80,1);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (84,80,80,80,80,80,80,80,80,80,74,70,80,74,80,74,80,81,72,80,2);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (84,80,80,80,80,80,80,80,80,80,74,65,74,72,80,74,80,81,72,80,3);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (84,80,80,80,80,80,80,80,80,80,74,80,80,70,80,70,80,81,72,80,4);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (84,80,80,80,80,80,80,80,80,80,74,70,80,65,74,70,80,70,80,80,5);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (85,70,70,70,70,70,70,70,70,70,74,65,74,80,80,70,80,70,80,80,1);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (85,70,70,70,70,70,70,70,70,70,74,80,75,70,80,65,74,88,85,80,2);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (85,70,70,70,70,70,70,70,70,70,74,80,75,65,74,86,74,70,80,80,3);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (85,70,70,70,70,70,70,70,70,70,74,70,80,80,80,81,72,70,80,80,4);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (85,70,70,70,70,70,70,70,70,70,74,65,74,80,80,70,80,70,80,80,5);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (86,75,75,75,75,75,75,75,75,75,74,80,80,80,75,80,75,65,74,80,1);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (86,75,75,75,75,75,75,75,75,75,75,70,80,81,72,70,80,70,80,80,2);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (86,75,75,75,75,75,75,75,75,75,75,70,80,81,72,65,74,70,80,80,3);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (86,75,75,75,75,75,75,75,75,75,72,70,80,81,72,80,80,70,80,80,4);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (86,75,75,75,75,75,75,75,75,75,72,70,80,70,80,80,80,70,80,80,5);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (87,70,70,70,70,70,70,70,70,70,72,70,80,70,80,80,75,65,74,80,1);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (87,70,70,70,70,70,70,70,70,70,72,70,80,88,85,80,75,80,80,80,2);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (87,70,70,70,70,70,70,70,70,70,72,70,80,70,80,70,80,80,80,80,3);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (87,70,70,70,70,70,70,70,70,70,72,70,80,80,75,70,80,88,85,80,4);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (87,70,70,70,70,70,70,70,70,70,80,88,85,80,81,70,80,70,80,80,5);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (88,72,72,72,72,72,72,72,72,72,80,70,80,80,81,70,80,65,74,80,1);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (88,72,72,72,72,72,72,72,72,72,80,81,72,80,81,65,74,65,74,80,2);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (88,72,72,72,72,72,72,72,72,72,80,81,72,80,81,80,80,65,74,80,3);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (88,72,72,72,72,72,72,72,72,72,80,81,72,80,81,80,80,65,74,80,4);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (88,72,72,72,72,72,72,72,72,72,80,70,80,81,72,80,75,65,74,80,5);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (89,80,80,80,80,80,80,80,80,80,80,70,80,81,72,80,75,65,74,80,1);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (89,80,80,80,80,80,80,80,80,80,80,88,85,81,72,80,81,65,74,80,2);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (89,80,80,80,80,80,80,80,80,80,72,70,80,81,72,80,80,70,80,80,3);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (89,80,80,80,80,80,80,80,80,80,72,70,80,70,80,80,80,70,80,80,4);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (89,80,80,80,80,80,80,80,80,80,72,70,80,70,80,80,75,65,74,80,5);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (90,72,72,72,72,72,72,72,72,72,72,70,80,88,85,80,75,80,80,80,1);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (90,72,72,72,72,72,72,72,72,72,72,70,80,70,80,70,80,80,80,80,2);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (90,72,72,72,72,72,72,72,72,72,72,70,80,80,75,70,80,88,85,80,3);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (90,72,72,72,72,72,72,72,72,72,80,88,85,80,81,70,80,70,80,80,4);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (90,72,72,72,72,72,72,72,72,72,74,80,80,80,75,80,75,65,74,80,5);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (91,70,70,70,70,70,70,70,70,70,75,70,80,81,72,70,80,70,80,80,1);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (91,70,70,70,70,70,70,70,70,70,75,70,80,81,72,65,74,70,80,80,2);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (91,70,70,70,70,70,70,70,70,70,72,70,80,81,72,80,80,70,80,80,3);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (91,70,70,70,70,70,70,70,70,70,72,70,80,70,80,80,80,70,80,80,4);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (91,70,70,70,70,70,70,70,70,70,72,70,80,70,80,80,75,65,74,80,5);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (92,70,70,70,70,70,70,70,70,70,72,70,80,88,85,80,75,80,80,80,1);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (92,70,70,70,70,70,70,70,70,70,72,70,80,70,80,70,80,80,80,80,2);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (92,70,70,70,70,70,70,70,70,70,72,65,74,70,80,70,80,80,75,80,3);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (92,70,70,70,70,70,70,70,70,70,72,81,72,80,75,70,80,80,75,80,4);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (92,70,70,70,70,70,70,70,70,70,74,70,80,70,80,80,70,80,81,80,5);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (93,75,75,75,75,75,75,75,75,75,74,65,74,70,80,74,70,80,81,80,1);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (93,75,75,75,75,75,75,75,75,75,74,80,80,70,80,74,65,70,82,80,2);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (93,75,75,75,75,75,75,75,75,75,74,70,80,74,80,74,80,81,72,80,3);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (93,75,75,75,75,75,75,75,75,75,74,65,74,72,80,74,80,81,72,80,4);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (93,75,75,75,75,75,75,75,75,75,74,80,80,70,80,70,80,81,72,80,5);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (94,80,80,80,80,80,80,80,80,80,74,70,80,65,74,70,80,70,80,80,1);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (94,80,80,80,80,80,80,80,80,80,74,65,74,80,80,70,80,70,80,80,2);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (94,80,80,80,80,80,80,80,80,80,74,80,75,70,80,65,74,88,85,80,3);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (94,80,80,80,80,80,80,80,80,80,74,80,75,65,74,86,74,70,80,80,4);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (94,80,80,80,80,80,80,80,80,80,74,70,80,80,80,81,72,70,80,80,5);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (95,80,80,80,80,80,80,80,80,80,74,65,74,80,80,70,80,70,80,80,1);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (95,80,80,80,80,80,80,80,80,80,74,80,80,80,75,80,75,65,74,80,2);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (95,80,80,80,80,80,80,80,80,80,80,70,80,88,85,80,81,81,72,80,3);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (95,80,80,80,80,80,80,80,80,80,74,70,80,70,80,80,81,70,80,80,4);
INSERT INTO NILAI_RAPOR (no_daftar,kkm_mtk,kkm_kimia,kkm_fisika,kkm_biologi,kkm_sejarah,kkm_geografi,kkm_ekonomi,kkm_bindo,kkm_bing,mtk,kimia,fisika,biologi,sejarah,geografi,ekonomi,sosiologi,bindo,bing,semester) VALUES (95,80,80,80,80,80,80,80,80,80,74,65,74,70,80,86,74,80,75,80,5);

INSERT INTO CALON_MAHASISWA (no_daftar,npm,id_prodi,id_jalur,jenjang) VALUES (1,'2700000001',34,1,'S1');
INSERT INTO CALON_MAHASISWA (no_daftar,npm,id_prodi,id_jalur,jenjang) VALUES (2,'2700000002',12,1,'S1');
INSERT INTO CALON_MAHASISWA (no_daftar,npm,id_prodi,id_jalur,jenjang) VALUES (3,'2700000003',12,1,'S1');
INSERT INTO CALON_MAHASISWA (no_daftar,npm,id_prodi,id_jalur,jenjang) VALUES (4,'2700000004',46,1,'S1');
INSERT INTO CALON_MAHASISWA (no_daftar,npm,id_prodi,id_jalur,jenjang) VALUES (5,'2700000005',33,1,'S1');
INSERT INTO CALON_MAHASISWA (no_daftar,npm,id_prodi,id_jalur,jenjang) VALUES (6,'2700000006',4,1,'S1');
INSERT INTO CALON_MAHASISWA (no_daftar,npm,id_prodi,id_jalur,jenjang) VALUES (7,'2700000007',16,1,'S1');
INSERT INTO CALON_MAHASISWA (no_daftar,npm,id_prodi,id_jalur,jenjang) VALUES (8,'2700000008',43,1,'S1');
INSERT INTO CALON_MAHASISWA (no_daftar,npm,id_prodi,id_jalur,jenjang) VALUES (9,'2700000009',19,1,'S1');
INSERT INTO CALON_MAHASISWA (no_daftar,npm,id_prodi,id_jalur,jenjang) VALUES (10,'2700000010',14,1,'S1');
INSERT INTO CALON_MAHASISWA (no_daftar,npm,id_prodi,id_jalur,jenjang) VALUES (12,'2700000012',36,1,'S1');
INSERT INTO CALON_MAHASISWA (no_daftar,npm,id_prodi,id_jalur,jenjang) VALUES (13,'2700000013',53,1,'S1');
INSERT INTO CALON_MAHASISWA (no_daftar,npm,id_prodi,id_jalur,jenjang) VALUES (14,'2700000014',18,1,'S1');
INSERT INTO CALON_MAHASISWA (no_daftar,npm,id_prodi,id_jalur,jenjang) VALUES (15,'2700000015',17,1,'S1');
INSERT INTO CALON_MAHASISWA (no_daftar,npm,id_prodi,id_jalur,jenjang) VALUES (16,'2700000016',20,1,'S1');
INSERT INTO CALON_MAHASISWA (no_daftar,npm,id_prodi,id_jalur,jenjang) VALUES (17,'2700000017',21,1,'S1');
INSERT INTO CALON_MAHASISWA (no_daftar,npm,id_prodi,id_jalur,jenjang) VALUES (18,'2700000018',25,1,'S1');
INSERT INTO CALON_MAHASISWA (no_daftar,npm,id_prodi,id_jalur,jenjang) VALUES (19,'2700000019',29,1,'S1');
INSERT INTO CALON_MAHASISWA (no_daftar,npm,id_prodi,id_jalur,jenjang) VALUES (20,'2700000020',28,1,'S1');
INSERT INTO CALON_MAHASISWA (no_daftar,npm,id_prodi,id_jalur,jenjang) VALUES (22,'2700000022',2,1,'S1');
INSERT INTO CALON_MAHASISWA (no_daftar,npm,id_prodi,id_jalur,jenjang) VALUES (23,'2700000023',4,1,'S1');
INSERT INTO CALON_MAHASISWA (no_daftar,npm,id_prodi,id_jalur,jenjang) VALUES (24,'2700000024',6,1,'S1');
INSERT INTO CALON_MAHASISWA (no_daftar,npm,id_prodi,id_jalur,jenjang) VALUES (25,'2700000025',1,1,'S1');
INSERT INTO CALON_MAHASISWA (no_daftar,npm,id_prodi,id_jalur,jenjang) VALUES (27,'2700000027',14,1,'S1');
INSERT INTO CALON_MAHASISWA (no_daftar,npm,id_prodi,id_jalur,jenjang) VALUES (28,'2700000028',19,1,'S1');
INSERT INTO CALON_MAHASISWA (no_daftar,npm,id_prodi,id_jalur,jenjang) VALUES (29,'2700000029',32,1,'S1');
INSERT INTO CALON_MAHASISWA (no_daftar,npm,id_prodi,id_jalur,jenjang) VALUES (30,'2700000030',45,1,'S1');
INSERT INTO CALON_MAHASISWA (no_daftar,npm,id_prodi,id_jalur,jenjang) VALUES (33,'2700000033',20,1,'S1');
INSERT INTO CALON_MAHASISWA (no_daftar,npm,id_prodi,id_jalur,jenjang) VALUES (34,'2700000034',29,1,'S1');
INSERT INTO CALON_MAHASISWA (no_daftar,npm,id_prodi,id_jalur,jenjang) VALUES (35,'2700000035',21,1,'S1');
INSERT INTO CALON_MAHASISWA (no_daftar,npm,id_prodi,id_jalur,jenjang) VALUES (36,'2700000036',2,1,'S1');
INSERT INTO CALON_MAHASISWA (no_daftar,npm,id_prodi,id_jalur,jenjang) VALUES (37,'2700000037',2,1,'S1');
INSERT INTO CALON_MAHASISWA (no_daftar,npm,id_prodi,id_jalur,jenjang) VALUES (38,'2700000038',53,1,'S1');
INSERT INTO CALON_MAHASISWA (no_daftar,npm,id_prodi,id_jalur,jenjang) VALUES (40,'2700000040',13,1,'S1');
INSERT INTO CALON_MAHASISWA (no_daftar,npm,id_prodi,id_jalur,jenjang) VALUES (42,'2700000042',63,2,'S2');
INSERT INTO CALON_MAHASISWA (no_daftar,npm,id_prodi,id_jalur,jenjang) VALUES (43,'2700000043',56,2,'S2');
INSERT INTO CALON_MAHASISWA (no_daftar,npm,id_prodi,id_jalur,jenjang) VALUES (44,'2700000044',56,2,'S2');
INSERT INTO CALON_MAHASISWA (no_daftar,npm,id_prodi,id_jalur,jenjang) VALUES (45,'2700000045',73,2,'S2');
INSERT INTO CALON_MAHASISWA (no_daftar,npm,id_prodi,id_jalur,jenjang) VALUES (46,'2700000046',60,2,'S2');
INSERT INTO CALON_MAHASISWA (no_daftar,npm,id_prodi,id_jalur,jenjang) VALUES (47,'2700000047',61,2,'S2');
INSERT INTO CALON_MAHASISWA (no_daftar,npm,id_prodi,id_jalur,jenjang) VALUES (48,'2700000048',62,2,'S2');
INSERT INTO CALON_MAHASISWA (no_daftar,npm,id_prodi,id_jalur,jenjang) VALUES (50,'2700000050',60,2,'S2');
INSERT INTO CALON_MAHASISWA (no_daftar,npm,id_prodi,id_jalur,jenjang) VALUES (51,'2700000051',63,2,'S2');
INSERT INTO CALON_MAHASISWA (no_daftar,npm,id_prodi,id_jalur,jenjang) VALUES (52,'2700000052',62,2,'S2');
INSERT INTO CALON_MAHASISWA (no_daftar,npm,id_prodi,id_jalur,jenjang) VALUES (53,'2700000053',59,2,'S2');
INSERT INTO CALON_MAHASISWA (no_daftar,npm,id_prodi,id_jalur,jenjang) VALUES (54,'2700000054',60,2,'S2');
INSERT INTO CALON_MAHASISWA (no_daftar,npm,id_prodi,id_jalur,jenjang) VALUES (55,'2700000055',69,2,'S2');
INSERT INTO CALON_MAHASISWA (no_daftar,npm,id_prodi,id_jalur,jenjang) VALUES (56,'2700000056',190,5,'S3');
INSERT INTO CALON_MAHASISWA (no_daftar,npm,id_prodi,id_jalur,jenjang) VALUES (58,'2700000058',190,5,'S3');
INSERT INTO CALON_MAHASISWA (no_daftar,npm,id_prodi,id_jalur,jenjang) VALUES (59,'2700000059',193,5,'S3');
INSERT INTO CALON_MAHASISWA (no_daftar,npm,id_prodi,id_jalur,jenjang) VALUES (61,'2700000061',195,5,'S3');
INSERT INTO CALON_MAHASISWA (no_daftar,npm,id_prodi,id_jalur,jenjang) VALUES (62,'2700000062',196,5,'S3');
INSERT INTO CALON_MAHASISWA (no_daftar,npm,id_prodi,id_jalur,jenjang) VALUES (63,'2700000063',197,5,'S3');
INSERT INTO CALON_MAHASISWA (no_daftar,npm,id_prodi,id_jalur,jenjang) VALUES (64,'2700000064',16,3,'S1');
INSERT INTO CALON_MAHASISWA (no_daftar,npm,id_prodi,id_jalur,jenjang) VALUES (65,'2700000065',42,3,'S1');
INSERT INTO CALON_MAHASISWA (no_daftar,npm,id_prodi,id_jalur,jenjang) VALUES (66,'2700000066',18,3,'S1');
INSERT INTO CALON_MAHASISWA (no_daftar,npm,id_prodi,id_jalur,jenjang) VALUES (67,'2700000067',16,3,'S1');
INSERT INTO CALON_MAHASISWA (no_daftar,npm,id_prodi,id_jalur,jenjang) VALUES (68,'2700000068',20,3,'S1');
INSERT INTO CALON_MAHASISWA (no_daftar,npm,id_prodi,id_jalur,jenjang) VALUES (69,'2700000069',25,3,'S1');
INSERT INTO CALON_MAHASISWA (no_daftar,npm,id_prodi,id_jalur,jenjang) VALUES (70,'2700000070',15,3,'S1');
INSERT INTO CALON_MAHASISWA (no_daftar,npm,id_prodi,id_jalur,jenjang) VALUES (71,'2700000071',32,3,'S1');
INSERT INTO CALON_MAHASISWA (no_daftar,npm,id_prodi,id_jalur,jenjang) VALUES (72,'2700000072',4,3,'S1');
INSERT INTO CALON_MAHASISWA (no_daftar,npm,id_prodi,id_jalur,jenjang) VALUES (73,'2700000073',16,3,'S1');
INSERT INTO CALON_MAHASISWA (no_daftar,npm,id_prodi,id_jalur,jenjang) VALUES (75,'2700000075',19,3,'S1');
INSERT INTO CALON_MAHASISWA (no_daftar,npm,id_prodi,id_jalur,jenjang) VALUES (76,'2700000076',30,3,'S1');
INSERT INTO CALON_MAHASISWA (no_daftar,npm,id_prodi,id_jalur,jenjang) VALUES (77,'2700000077',19,3,'S1');
INSERT INTO CALON_MAHASISWA (no_daftar,npm,id_prodi,id_jalur,jenjang) VALUES (78,'2700000078',36,3,'S1');
INSERT INTO CALON_MAHASISWA (no_daftar,npm,id_prodi,id_jalur,jenjang) VALUES (79,'2700000079',53,3,'S1');
INSERT INTO CALON_MAHASISWA (no_daftar,npm,id_prodi,id_jalur,jenjang) VALUES (80,'2700000080',20,3,'S1');
INSERT INTO CALON_MAHASISWA (no_daftar,npm,id_prodi,id_jalur,jenjang) VALUES (81,'2700000081',25,3,'S1');
INSERT INTO CALON_MAHASISWA (no_daftar,npm,id_prodi,id_jalur,jenjang) VALUES (82,'2700000082',28,3,'S1');
INSERT INTO CALON_MAHASISWA (no_daftar,npm,id_prodi,id_jalur,jenjang) VALUES (83,'2700000083',2,3,'S1');
INSERT INTO CALON_MAHASISWA (no_daftar,npm,id_prodi,id_jalur,jenjang) VALUES (85,'2700000085',25,3,'S1');
INSERT INTO CALON_MAHASISWA (no_daftar,npm,id_prodi,id_jalur,jenjang) VALUES (86,'2700000086',28,3,'S1');
INSERT INTO CALON_MAHASISWA (no_daftar,npm,id_prodi,id_jalur,jenjang) VALUES (87,'2700000087',2,3,'S1');
INSERT INTO CALON_MAHASISWA (no_daftar,npm,id_prodi,id_jalur,jenjang) VALUES (88,'2700000088',15,3,'S1');
INSERT INTO CALON_MAHASISWA (no_daftar,npm,id_prodi,id_jalur,jenjang) VALUES (90,'2700000090',9,3,'S1');
INSERT INTO CALON_MAHASISWA (no_daftar,npm,id_prodi,id_jalur,jenjang) VALUES (91,'2700000091',45,3,'S1');
INSERT INTO CALON_MAHASISWA (no_daftar,npm,id_prodi,id_jalur,jenjang) VALUES (92,'2700000092',16,3,'S1');
INSERT INTO CALON_MAHASISWA (no_daftar,npm,id_prodi,id_jalur,jenjang) VALUES (93,'2700000093',32,3,'S1');