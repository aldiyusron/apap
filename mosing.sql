CREATE TABLE IF NOT EXISTS USER
(
	username VARCHAR(30) NOT NULL PRIMARY KEY,
	password VARCHAR(20) NOT NULL,
	email	VARCHAR(30) NOT NULL,
	role VARCHAR(15) NOT NULL,
	enabled BOOLEAN NOT NULL
);

CREATE TABLE IF NOT EXISTS PENDAFTAR
(
	username VARCHAR(30) NOT NULL,
	no_id VARCHAR(20) NOT NULL,
	nama_id VARCHAR(50) NOT NULL,
	nama_ijazah VARCHAR(50) NOT NULL,
	foto VARCHAR(100) NOT NULL,
	no_hp VARCHAR(14) NOT NULL,
	no_telp VARCHAR(14),
	negara VARCHAR(25) NOT NULL,
	kewarganegaraan VARCHAR(3) NOT NULL,
	alamat_tetap VARCHAR(100) NOT NULL,
	jenis_id VARCHAR(20) NOT NULL,
	alamat_sekarang VARCHAR(100) NOT NULL,
	tgl_lahir DATE NOT NULL,
	provinsi VARCHAR(25) NOT NULL,
	kota VARCHAR(25) NOT NULL,
	jenis_kelamin TINYINT(1) NOT NULL,
	no_daftar INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
	FOREIGN KEY(username) REFERENCES USER (username) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS KPMB
(
	username VARCHAR(30) NOT NULL,
	nama VARCHAR(50) NOT NULL,
	jabatan VARCHAR(50) NOT NULL,
	no_pegawai CHAR(10) NOT NULL PRIMARY KEY,
	FOREIGN KEY(username) REFERENCES USER (username) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS PEMIMPIN_UNIV
(
	username VARCHAR(30) NOT NULL,
	nama VARCHAR(50) NOT NULL,
	jabatan VARCHAR(50) NOT NULL,
	no_pegawai CHAR(10) NOT NULL PRIMARY KEY,
	FOREIGN KEY(username) REFERENCES USER (username) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS PEMIMPIN_FAKULTAS
(
	username VARCHAR(30) NOT NULL,
	nama VARCHAR(50) NOT NULL,
	jabatan VARCHAR(50) NOT NULL,
	no_pegawai CHAR(10) NOT NULL PRIMARY KEY,
	fakultas VARCHAR(50) NOT NULL,
	FOREIGN KEY(username) REFERENCES USER (username) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS LEMBAGA_PENDIDIKAN_TERAKHIR
(
	username VARCHAR(30) NOT NULL PRIMARY KEY,
	nama_lembaga VARCHAR(50) NOT NULL,
	provinsi VARCHAR(25) NOT NULL,
	kota VARCHAR(25) NOT NULL,
	FOREIGN KEY(username) REFERENCES USER (username) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS LOKASI
(
	alamat VARCHAR(100) NOT NULL,
	no_telp VARCHAR(14) NOT NULL,
	nama_lokasi VARCHAR(50) NOT NULL PRIMARY KEY,
	provinsi VARCHAR(25) NOT NULL,
	kota VARCHAR(25) NOT NULL
);

CREATE TABLE IF NOT EXISTS PENGAWAS_UJIAN
(
	username VARCHAR(30) NOT NULL PRIMARY KEY,
	status BOOLEAN NOT NULL,
	jabatan VARCHAR(50) NOT NULL,
	nama VARCHAR(50) NOT NULL,
	lokasi VARCHAR(50) NOT NULL,
	FOREIGN KEY(username) REFERENCES USER (username) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY(lokasi) REFERENCES LOKASI (nama_lokasi) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS JALUR_MASUK
(
	id_jalur CHAR(5) NOT NULL PRIMARY KEY,
	nama VARCHAR(30) NOT NULL,
	tanggal_buka DATE NOT NULL,
	tanggal_tutup DATE NOT NULL,
	status TINYINT(1) NOT NULL,
	nama_jenjang VARCHAR(20) NOT NULL
);

CREATE TABLE IF NOT EXISTS PRODI_TERSEDIA
(
	nama_prodi VARCHAR(100) NOT NULL PRIMARY KEY,
	daya_tampung INTEGER NOT NULL,
	nama_fakultas VARCHAR(50) NOT NULL,
	id_jalur CHAR(5) NOT NULL,
	FOREIGN KEY(id_jalur) REFERENCES JALUR_MASUK (id_jalur) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS DAFTAR_PILIHAN
(
	no_daftar INTEGER NOT NULL AUTO_INCREMENT,
	jenjang VARCHAR(15) NOT NULL,
	nama_program VARCHAR(20) NOT NULL,
	nama_prodi VARCHAR(100) NOT NULL,
	pilihan INTEGER NOT NULL,
	PRIMARY KEY (no_daftar, jenjang, nama_program, nama_prodi),
	FOREIGN KEY(no_daftar) REFERENCES PENDAFTAR (no_daftar) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY(nama_prodi) REFERENCES PRODI_TERSEDIA (nama_prodi) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS DETAIL_UJIAN
(
	no_daftar INTEGER NOT NULL AUTO_INCREMENT,
	no_ujian CHAR(10) NOT NULL,
	id_jalur CHAR(5) NOT NULL,
	lokasi VARCHAR(50) NOT NULL,
	waktu_ujian TIME NOT NULL,
	tanggal_ujian DATE NOT NULL,
	PRIMARY KEY (no_daftar, no_ujian),
	FOREIGN KEY(no_daftar) REFERENCES PENDAFTAR (no_daftar) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY(id_jalur) REFERENCES JALUR_MASUK (id_jalur) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY(lokasi) REFERENCES LOKASI (nama_lokasi) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS RIWAYAT_PENDAFTARAN
(
	no_pendaftaran INTEGER NOT NULL AUTO_INCREMENT,
	tahun CHAR(4) NOT NULL,
	id_jalur CHAR(5) NOT NULL,
	nama_jenjang VARCHAR(20) NOT NULL,
	nama_program VARCHAR(20) NOT NULL,
	PRIMARY KEY(no_pendaftaran, id_jalur, nama_jenjang, nama_program, tahun),
	FOREIGN KEY(no_pendaftaran) REFERENCES PENDAFTAR (no_daftar) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY(id_jalur) REFERENCES JALUR_MASUK (id_jalur) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS PENYELEKSIAN
(
	no_daftar INTEGER NOT NULL AUTO_INCREMENT,
	status TINYINT(1) NOT NULL,
	nilai_ujian INTEGER NOT NULL,
	nilai_rapor INTEGER NOT NULL,
	id_jalur CHAR(5) NOT NULL,
	berkas VARCHAR(100) NOT NULL,
	PRIMARY KEY(no_daftar, id_jalur),
	FOREIGN KEY(no_daftar) REFERENCES PENDAFTAR (no_daftar) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY(id_jalur) REFERENCES JALUR_MASUK (id_jalur) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS CALON_MAHASISWA
(
	no_daftar INTEGER NOT NULL AUTO_INCREMENT,
	npm CHAR(10) NOT NULL,
	prodi VARCHAR(30) NOT NULL,
	id_jalur CHAR(5) NOT NULL,
	jenjang VARCHAR(20) NOT NULL,
	PRIMARY KEY (no_daftar, npm, id_jalur),
	FOREIGN KEY(no_daftar) REFERENCES PENDAFTAR (no_daftar) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY(prodi) REFERENCES PRODI_TERSEDIA (nama_prodi) ON UPDATE CASCADE ON DELETE CASCADE,
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

INSERT INTO PENDAFTAR (username,no_id,nama_id,nama_ijazah,foto,no_hp,no_telp,negara,kewarganegaraan,alamat_tetap,jenis_id,alamat_sekarang,tgl_lahir,provinsi,kota,jenis_kelamin,no_daftar) VALUES ('PEND4','1706520000','Pendaftar1','Pendaftar1i','foto1.jpg','82124360370','7987325','Indonesia','WNI','Jl. Juragan Sinda','KTP','Jl. Padepokan Timur','1999-07-24','Jawa Barat','Depok','1',1);
INSERT INTO PENDAFTAR (username,no_id,nama_id,nama_ijazah,foto,no_hp,no_telp,negara,kewarganegaraan,alamat_tetap,jenis_id,alamat_sekarang,tgl_lahir,provinsi,kota,jenis_kelamin,no_daftar) VALUES ('PEND7','1706521090','Pendaftar2','Pendaftar2i','foto2.png','82124360371','7987326','Malaysia','WNA','Jl. Zimbabwe','SIM','Jl. Mangga Besar','2000-08-29','DKI Jakarta','Jakarta Selatan','1',2);
INSERT INTO PENDAFTAR (username,no_id,nama_id,nama_ijazah,foto,no_hp,no_telp,negara,kewarganegaraan,alamat_tetap,jenis_id,alamat_sekarang,tgl_lahir,provinsi,kota,jenis_kelamin,no_daftar) VALUES ('PEND8','8906528000','Pendaftar3','Pendaftar3i','foto3.jpeg','82124360372','7987327','Indonesia','WNI','Jl. In Aja Dulu','KTP','Jl. Indah','2000-04-03','DKI Jakarta','Jakarta Selatan','0',3);
INSERT INTO PENDAFTAR (username,no_id,nama_id,nama_ijazah,foto,no_hp,no_telp,negara,kewarganegaraan,alamat_tetap,jenis_id,alamat_sekarang,tgl_lahir,provinsi,kota,jenis_kelamin,no_daftar) VALUES ('PEND9','81706520110','Pendaftar4','Pendaftar4i','foto4.png','82124360373','7987328','Indonesia','WNI','Jl. Kebenaran','KTP','Jl. Besar','1999-01-19','Banten','Tangerang','0',4);
INSERT INTO PENDAFTAR (username,no_id,nama_id,nama_ijazah,foto,no_hp,no_telp,negara,kewarganegaraan,alamat_tetap,jenis_id,alamat_sekarang,tgl_lahir,provinsi,kota,jenis_kelamin,no_daftar) VALUES ('PEND10','71896520001','Pendaftar5','Pendaftar5i','foto5.jpg','82124360374','7987329','Singapura','WNA','Jl. Lurus','KTP','Jl. Kecil','1999-11-11','Jawa Barat','Jakarta Timur','1',5);

INSERT INTO KPMB (username,nama,jabatan,no_pegawai) VALUES ('KPMB1','Bambang Pamungkas','Kepala KPMB','1000000101');

INSERT INTO PEMIMPIN_UNIV (username,nama,jabatan,no_pegawai) VALUES ('PEMU2','Jaka Widodo','Pemimpin UI','1000000001');

INSERT INTO PEMIMPIN_FAKULTAS (username,nama,jabatan,no_pegawai,fakultas) VALUES ('PEMF3','Baskoro','Pemimpin Fak. Ilmu Hewan','1000000002','Fakultas Ilmu Hewan');

INSERT INTO LEMBAGA_PENDIDIKAN_TERAKHIR (username,nama_lembaga,provinsi,kota) VALUES ('LPT5','MTS Pramudito','DKI Jakarta','Jakarta Timur');

INSERT INTO LOKASI (alamat,no_telp,nama_lokasi,provinsi,kota) VALUES ('Jl. Lengkeng','8886677','SMAN 1000','Jawa Barat','Depok');
INSERT INTO LOKASI (alamat,no_telp,nama_lokasi,provinsi,kota) VALUES ('Jl. Mangga','7779933','SMAN 1001','DKI Jakarta','Jakarta Pusat');
INSERT INTO LOKASI (alamat,no_telp,nama_lokasi,provinsi,kota) VALUES ('Jl. Semangka','9894212','SMAN 1002','DKI Jakarta','Jakarta Selatan');

INSERT INTO PENGAWAS_UJIAN (username,status,jabatan,nama,lokasi) VALUES ('PENGU6','Y','Pegawai UI','Aqua','SMAN 1000');
INSERT INTO PENGAWAS_UJIAN (username,status,jabatan,nama,lokasi) VALUES ('PENGU11','Y','Mahasiswa','Prima','SMAN 1001');
INSERT INTO PENGAWAS_UJIAN (username,status,jabatan,nama,lokasi) VALUES ('PENGU12','Y','Mahasiswa','Ades','SMAN 1002');

INSERT INTO LOKASI (alamat,no_telp,nama_lokasi,provinsi,kota) VALUES ('Jl. Juragan Sinda','72700098','Universitas Indonesia','Jawa Barat','Depok');

INSERT INTO JALUR_MASUK (id_jalur,nama,tanggal_buka,tanggal_tutup,status,nama_jenjang) VALUES ('001','SIMAK UI','2017-05-11','2017-08-11',1,'S1');

INSERT INTO PRODI_TERSEDIA (nama_prodi,daya_tampung,nama_fakultas,id_jalur) VALUES ('Sistem Informasi',100,'Fasilkom','001');

INSERT INTO DAFTAR_PILIHAN (no_daftar,jenjang,nama_program,nama_prodi,pilihan) VALUES (1,'S1','Reguler','Sistem Informasi',1);

INSERT INTO DETAIL_UJIAN (no_daftar,no_ujian,id_jalur,lokasi,waktu_ujian,tanggal_ujian) VALUES (1,'0000000001','001','Universitas Indonesia','09:00:00','2017-06-11');
