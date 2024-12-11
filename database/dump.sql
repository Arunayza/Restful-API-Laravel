-- Menghapus foreign key check
-- PostgreSQL tidak memerlukan perintah PRAGMA foreign_keys=OFF.

-- Memulai transaksi
BEGIN;

-- Tabel migrations
CREATE TABLE IF NOT EXISTS migrations (
    id SERIAL PRIMARY KEY,
    migration VARCHAR NOT NULL,
    batch INTEGER NOT NULL
);

INSERT INTO migrations (migration, batch) VALUES
('0001_01_01_000000_create_users_table', 1),
('0001_01_01_000001_create_cache_table', 1),
('0001_01_01_000002_create_jobs_table', 1),
('2024_11_10_190149_create_movie_table', 2),
('2024_11_10_190754_create_personal_access_tokens_table', 3),
('2024_12_10_131021_add_tanggal_rilis_and_durasi_to_movies_table', 4);

-- Tabel users
CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    name VARCHAR NOT NULL,
    email VARCHAR NOT NULL,
    email_verified_at TIMESTAMP,
    password VARCHAR NOT NULL,
    remember_token VARCHAR,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

-- Tabel password_reset_tokens
CREATE TABLE IF NOT EXISTS password_reset_tokens (
    email VARCHAR NOT NULL,
    token VARCHAR NOT NULL,
    created_at TIMESTAMP,
    PRIMARY KEY (email)
);

-- Tabel sessions
CREATE TABLE IF NOT EXISTS sessions (
    id VARCHAR NOT NULL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id),
    ip_address VARCHAR,
    user_agent TEXT,
    payload TEXT NOT NULL,
    last_activity INTEGER NOT NULL
);

-- Tabel cache
CREATE TABLE IF NOT EXISTS cache (
    key VARCHAR NOT NULL PRIMARY KEY,
    value TEXT NOT NULL,
    expiration INTEGER NOT NULL
);

-- Tabel cache_locks
CREATE TABLE IF NOT EXISTS cache_locks (
    key VARCHAR NOT NULL PRIMARY KEY,
    owner VARCHAR NOT NULL,
    expiration INTEGER NOT NULL
);

-- Tabel jobs
CREATE TABLE IF NOT EXISTS jobs (
    id SERIAL PRIMARY KEY,
    queue VARCHAR NOT NULL,
    payload TEXT NOT NULL,
    attempts INTEGER NOT NULL,
    reserved_at INTEGER,
    available_at INTEGER NOT NULL,
    created_at INTEGER NOT NULL
);

-- Tabel job_batches
CREATE TABLE IF NOT EXISTS job_batches (
    id VARCHAR PRIMARY KEY,
    name VARCHAR NOT NULL,
    total_jobs INTEGER NOT NULL,
    pending_jobs INTEGER NOT NULL,
    failed_jobs INTEGER NOT NULL,
    failed_job_ids TEXT NOT NULL,
    options TEXT,
    cancelled_at INTEGER,
    created_at INTEGER NOT NULL,
    finished_at INTEGER
);

-- Tabel failed_jobs
CREATE TABLE IF NOT EXISTS failed_jobs (
    id SERIAL PRIMARY KEY,
    uuid VARCHAR NOT NULL,
    connection TEXT NOT NULL,
    queue TEXT NOT NULL,
    payload TEXT NOT NULL,
    exception TEXT NOT NULL,
    failed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);

-- Tabel movie
CREATE TABLE IF NOT EXISTS movie (
    id SERIAL PRIMARY KEY,
    judul VARCHAR NOT NULL,
    sinopsis TEXT NOT NULL,
    poster VARCHAR NOT NULL,
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    tanggal_rilis DATE,
    durasi_film VARCHAR(20),
    video VARCHAR(150)
);

-- Contoh insert untuk tabel movie
INSERT INTO movie (judul, sinopsis, poster, created_at, updated_at, tanggal_rilis, durasi_film, video) VALUES
('Detective Conan Movie 01 : THE TIME BOMBED SKYSCRAPER', 'menceritakan Conan Edogawa yang harus menghentikan serangkaian bom...', 'https://i.imgur.com/3f41vUo.jpeg', '2024-11-10 19:50:22', '2024-12-10 16:10:46', '1997-4-19', '99 Menit', 'https://drive.google.com/file/d/1LKYihnSH5gV-RgwyByQh9-WMXuS7fh2L/view?usp=drive_link'),
('Detective Conan Movie 02 : THE DIE-HARD DETECTIVE', 'Conan harus memecahkan misteri di sebuah hotel mewah dengan berbagai petunjuk yang membingungkan.', 'https://i.imgur.com/TyJPO0t.jpeg', '2024-11-10 19:50:22', '2024-12-10 16:10:46', '1998-4-18', '100 Menit', 'https://drive.google.com/file/d/2dyf9QvklB2dRjynFJbPZ5fMAvw8JKCjs/view?usp=drive_link'),
('Detective Conan Movie 03 : THE LAST WALTZ', 'Conan menyelidiki peristiwa misterius di sebuah konser, berhadapan dengan penjahat berbahaya.', 'https://i.imgur.com/sX5zVgM.jpeg', '2024-11-10 19:50:22', '2024-12-10 16:10:46', '1999-4-17', '101 Menit', 'https://drive.google.com/file/d/3lX9LO9wK9fFzW6JdkFOI4O4kT7Y8ql7O/view?usp=drive_link'),
('Detective Conan Movie 04 : THE CULPRIT HUNT', 'Conan harus memburu seorang pembunuh yang telah kabur setelah melakukan aksi kriminal besar.', 'https://i.imgur.com/1rgT3LP.jpeg', '2024-11-10 19:50:22', '2024-12-10 16:10:46', '2000-4-22', '102 Menit', 'https://drive.google.com/file/d/4fzjJg4mty_M4WZhr9xrk8Gr3A6Dwmln/view?usp=drive_link'),
('Detective Conan Movie 05 : COUNTDOWN TO HEAVEN', 'Conan berusaha menyelamatkan banyak nyawa setelah seorang teroris merencanakan ledakan besar.', 'https://i.imgur.com/q6xlOa3.jpeg', '2024-11-10 19:50:22', '2024-12-10 16:10:46', '2001-4-21', '105 Menit', 'https://drive.google.com/file/d/5mx7EjYF9Vt7nLvf7xgYmX74Xy6Lnzjdd/view?usp=drive_link'),
('Detective Conan Movie 06 : THE PHANTOM OF THE OPERA HOUSE', 'Conan menghadapi musuh misterius yang berada di balik serangkaian peristiwa mengerikan di sebuah gedung opera.', 'https://i.imgur.com/JpEKq4O.jpeg', '2024-11-10 19:50:22', '2024-12-10 16:10:46', '2002-4-20', '108 Menit', 'https://drive.google.com/file/d/6v9XYsd1t0DsGjOnAmFzOFCgC0mf0grw/view?usp=drive_link'),
('Detective Conan Movie 07 : THE MYSTERY OF THE MIRROR MAZE', 'Conan harus memecahkan teka-teki dalam sebuah labirin cermin yang penuh jebakan dan rahasia gelap.', 'https://i.imgur.com/pAqFh0r.jpeg', '2024-11-10 19:50:22', '2024-12-10 16:10:46', '2003-4-19', '110 Menit', 'https://drive.google.com/file/d/7zz2nUwX7JtQL2TeF6q5yYKH1HtHv8zL/view?usp=drive_link'),
('Detective Conan Movie 08 : THE SUSPICIOUS JUROR', 'Conan membantu memecahkan kasus yang berhubungan dengan pembunuhan yang terjadi di ruang sidang.', 'https://i.imgur.com/jFOdWyD.jpeg', '2024-11-10 19:50:22', '2024-12-10 16:10:46', '2004-4-17', '112 Menit', 'https://drive.google.com/file/d/8MXk0IIR9u5UkEvIjS_Mj17m6AiYMzRY/view?usp=drive_link'),
('Detective Conan Movie 09 : THE CRIMINALS IN THE DARK', 'Conan terlibat dalam penyelidikan kejahatan besar yang terjadi dalam kegelapan total.', 'https://i.imgur.com/GoRPkeI.jpeg', '2024-11-10 19:50:22', '2024-12-10 16:10:46', '2005-4-16', '115 Menit', 'https://drive.google.com/file/d/9M2U5we9SY1RzDnhV9m7rswYZd5_HJ3H/view?usp=drive_link'),
('Detective Conan Movie 10 : THE SECRET OF THE WATERFALL', 'Conan harus mengungkap misteri di balik serangkaian kejadian aneh di sebuah desa yang dikelilingi air terjun.', 'https://i.imgur.com/FzDxx73.jpeg', '2024-11-10 19:50:22', '2024-12-10 16:10:46', '2006-4-15', '120 Menit', 'https://drive.google.com/file/d/10knXJSoR7eg2lLOM5Flosz0JhsJMYWv0/view?usp=drive_link'),
('Detective Conan Movie 11 : THE BLACK SPIRAL', 'Conan berhadapan dengan organisasi kriminal yang terlibat dalam kejahatan internasional.', 'https://i.imgur.com/Ow2nCDN.jpeg', '2024-11-10 19:50:22', '2024-12-10 16:10:46', '2007-4-14', '123 Menit', 'https://drive.google.com/file/d/11Z25XhzYZ1v5c4AvJpd0t9Fbg2nDah6/view?usp=drive_link'),
('Detective Conan Movie 12 : THE MIDNIGHT TRAIN', 'Conan harus menyelamatkan para penumpang yang terjebak dalam kereta yang tiba-tiba berhenti di tengah malam.', 'https://i.imgur.com/nEocTyZ.jpeg', '2024-11-10 19:50:22', '2024-12-10 16:10:46', '2008-4-19', '125 Menit', 'https://drive.google.com/file/d/12Zn5WhcuhfPTHk_GgXi0x1psx01Vdvb/view?usp=drive_link'),
('Detective Conan Movie 13 : THE DISAPPEARING GAME', 'Conan memecahkan misteri orang yang hilang dalam sebuah permainan yang membingungkan di luar negeri.', 'https://i.imgur.com/J0yFVG3.jpeg', '2024-11-10 19:50:22', '2024-12-10 16:10:46', '2009-4-18', '127 Menit', 'https://drive.google.com/file/d/13Eek1Z_Q8lFQZgEJcjqvnzQGv9MZij/view?usp=drive_link'),
('Detective Conan Movie 14 : THE MYSTERY OF THE MURDERED ARTIST', 'Conan membantu polisi mengungkap pembunuh seorang seniman yang meninggalkan pesan rahasia di lukisan.', 'https://i.imgur.com/sWzFh92.jpeg', '2024-11-10 19:50:22', '2024-12-10 16:10:46', '2010-4-17', '130 Menit', 'https://drive.google.com/file/d/14LirBaQXysF0nOlq4nGfyK4mrXqhzF6/view?usp=drive_link'),
('Detective Conan Movie 15 : THE END OF THE WORLD', 'Conan harus berhadapan dengan sebuah organisasi yang berencana menghancurkan dunia dalam sebuah peristiwa besar.', 'https://i.imgur.com/qXYzX7L.jpeg', '2024-11-10 19:50:22', '2024-12-10 16:10:46', '2011-4-16', '133 Menit', 'https://drive.google.com/file/d/15bbLl5JhErRmFW8ThPYlkl1A3Tt0kD6/view?usp=drive_link'),
('Detective Conan Movie 16 : THE VANISHED CASTLE', 'Conan menyelidiki sebuah kastil misterius yang menghilang, serta menemukan rahasia yang sangat berbahaya.', 'https://i.imgur.com/ksDfs7X.jpeg', '2024-11-10 19:50:22', '2024-12-10 16:10:46', '2012-4-14', '135 Menit', 'https://drive.google.com/file/d/16G_qY7a5pXjXyngzEL3oCpq-VbBecX5/view?usp=drive_link'),
('Detective Conan Movie 17 : THE RESCUE MISSION', 'Conan berusaha menyelamatkan seorang tokoh penting yang diculik oleh organisasi kriminal.', 'https://i.imgur.com/N2Jr9jJ.jpeg', '2024-11-10 19:50:22', '2024-12-10 16:10:46', '2013-4-20', '138 Menit', 'https://drive.google.com/file/d/17lN7-j1L7tQveb1T2iFeLzdpSiHCOqA/view?usp=drive_link'),
('Detective Conan Movie 18 : THE FINAL CONFLICT', 'Conan menghadapi tantangan terbesar dalam hidupnya, berhadapan dengan musuh yang sangat kuat.', 'https://i.imgur.com/t2gGF58.jpeg', '2024-11-10 19:50:22', '2024-12-10 16:10:46', '2014-4-19', '140 Menit', 'https://drive.google.com/file/d/18d0_PbDjtmcW2L0zA5NDb5IEBEXfW9g/view?usp=drive_link'),
('Detective Conan Movie 19 : THE QUEST FOR THE TREASURE', 'Conan terlibat dalam pencarian harta karun yang berbahaya yang mengarah ke petunjuk tentang masa lalu.', 'https://i.imgur.com/ODyB5h4.jpeg', '2024-11-10 19:50:22', '2024-12-10 16:10:46', '2015-4-18', '143 Menit', 'https://drive.google.com/file/d/19Fc1Gi2BtkH59Hvi7AaFIc2p06rw0H0/view?usp=drive_link'),
('Detective Conan Movie 20 : THE RETURN OF THE BLACK ORGANIZATION', 'Conan kembali berhadapan dengan Organisasi Hitam yang sedang merencanakan serangan besar.', 'https://i.imgur.com/Wl0DrO0.jpeg', '2024-11-10 19:50:22', '2024-12-10 16:10:46', '2016-4-16', '145 Menit', 'https://drive.google.com/file/d/20zqOaNxf7jj9vZ5v3Yh4DkPp5KvF5Oq/view?usp=drive_link'),
('Detective Conan Movie 21 : THE UNDERWATER MYSTERY', 'Conan menyelidiki misteri di bawah laut, di mana sebuah kapal karam menyimpan rahasia besar.', 'https://i.imgur.com/DhIcPQ0.jpeg', '2024-11-10 19:50:22', '2024-12-10 16:10:46', '2017-4-15', '147 Menit', 'https://drive.google.com/file/d/21WtbRWqK2p5m1Y0uyyqG-D1g3AiWxVw/view?usp=drive_link'),
('Detective Conan Movie 22 : THE KIDNAPPED SCIENTIST', 'Conan berusaha menyelamatkan seorang ilmuwan yang diculik dan terlibat dalam kejahatan besar.', 'https://i.imgur.com/lfCVlFB.jpeg', '2024-11-10 19:50:22', '2024-12-10 16:10:46', '2018-4-14', '150 Menit', 'https://drive.google.com/file/d/22n3Q3BvZYVGVzODuThb_JqaX2OGF1Nk/view?usp=drive_link'),
('Detective Conan Movie 23 : THE LEGEND OF THE PHOENIX', 'Conan terlibat dalam petualangan memecahkan teka-teki terkait dengan sebuah legenda kuno yang misterius.', 'https://i.imgur.com/R1oXJ0M.jpeg', '2024-11-10 19:50:22', '2024-12-10 16:10:46', '2019-4-13', '152 Menit', 'https://drive.google.com/file/d/23zVrAcoFf5xg3OP-lKkcbSK2rmjyjK6/view?usp=drive_link'),
('Detective Conan Movie 24 : THE ESCAPE OF THE MYSTERIOUS PRISONER', 'Conan mengejar seorang tahanan yang melarikan diri dan mencoba mengungkap siapa yang berada di balik rencana penjahat tersebut.', 'https://i.imgur.com/W1TQHeA.jpeg', '2024-11-10 19:50:22', '2024-12-10 16:10:46', '2020-4-18', '155 Menit', 'https://drive.google.com/file/d/24ysRwxJ4N2wWTlP2phsO6gYY29PnUHT/view?usp=drive_link'),
('Detective Conan Movie 25 : THE PHANTOM THIEF', 'Conan mengungkap kasus pencurian besar yang melibatkan pencuri misterius dengan identitas yang tidak jelas.', 'https://i.imgur.com/h8IqoxL.jpeg', '2024-11-10 19:50:22', '2024-12-10 16:10:46', '2021-4-17', '158 Menit', 'https://drive.google.com/file/d/25hJRuFuTe5jBGiVY3xZqf4KmjT1-VgG/view?usp=drive_link'),
('Detective Conan Movie 26 : THE TRUTH BEHIND THE MURDER', 'Conan berusaha mengungkap identitas pembunuh yang bersembunyi di balik misteri pembunuhan yang rumit.', 'https://i.imgur.com/WcPOn9I.jpeg', '2024-11-10 19:50:22', '2024-12-10 16:10:46', '2022-4-16', '160 Menit', 'https://drive.google.com/file/d/26FfzzyKof4F6xw7l8XjJGiFb60R5G79/view?usp=drive_link'),
('Detective Conan Movie 27 : THE HUNT FOR THE SECRET CODE', 'Conan memburu petunjuk yang mengarah ke kode rahasia yang dapat mengungkap kejahatan besar.', 'https://i.imgur.com/pduMwTw.jpeg', '2024-11-10 19:50:22', '2024-12-10 16:10:46', '2023-4-15', '162 Menit', 'https://drive.google.com/file/d/27rTjXTFFm3cXsjgGF5wRiGHINBq0gFq/view?usp=drive_link'),
('Detective Conan Movie 28 : THE FATE OF THE WORLD', 'Conan berhadapan dengan ancaman yang bisa menghancurkan dunia, dan harus bekerja sama dengan berbagai pihak untuk menghentikannya.', 'https://i.imgur.com/0dpnihe.jpeg', '2024-11-10 19:50:22', '2024-12-10 16:10:46', '2024-4-20', '165 Menit', 'https://drive.google.com/file/d/28hrgQxAlJcbSmjPLV9lnIS4gSzwn-Kz/view?usp=drive_link');


-- Personal Access Tokens Table
CREATE TABLE IF NOT EXISTS "personal_access_tokens" (
    "id" serial PRIMARY KEY, 
    "tokenable_type" varchar NOT NULL, 
    "tokenable_id" integer NOT NULL, 
    "name" varchar NOT NULL, 
    "token" varchar NOT NULL, 
    "abilities" text, 
    "last_used_at" timestamp, 
    "expires_at" timestamp, 
    "created_at" timestamp, 
    "updated_at" timestamp
);

-- Indexes
CREATE UNIQUE INDEX IF NOT EXISTS "users_email_unique" ON "users" ("email");
CREATE INDEX IF NOT EXISTS "sessions_user_id_index" ON "sessions" ("user_id");
CREATE INDEX IF NOT EXISTS "sessions_last_activity_index" ON "sessions" ("last_activity");
CREATE INDEX IF NOT EXISTS "jobs_queue_index" ON "jobs" ("queue");
CREATE UNIQUE INDEX IF NOT EXISTS "failed_jobs_uuid_unique" ON "failed_jobs" ("uuid");
CREATE INDEX IF NOT EXISTS "personal_access_tokens_tokenable_type_tokenable_id_index" ON "personal_access_tokens" ("tokenable_type", "tokenable_id");
CREATE UNIQUE INDEX IF NOT EXISTS "personal_access_tokens_token_unique" ON "personal_access_tokens" ("token");

-- Commit transaksi
COMMIT;
