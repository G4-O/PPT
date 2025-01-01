-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 01, 2025 at 12:12 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `perpustakaan_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `anggota`
--

CREATE TABLE `anggota` (
  `idAnggota` varchar(50) NOT NULL,
  `nama` varchar(255) NOT NULL,
  `idUser` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `anggota`
--

INSERT INTO `anggota` (`idAnggota`, `nama`, `idUser`) VALUES
('6d39347f-f38b-481b-b258-813973149780', 'test', 3);

-- --------------------------------------------------------

--
-- Table structure for table `anggota_karyawan`
--

CREATE TABLE `anggota_karyawan` (
  `id` int(11) NOT NULL,
  `username` varchar(50) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `idAnggota` varchar(50) DEFAULT NULL,
  `nama` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `anggota_karyawan`
--

INSERT INTO `anggota_karyawan` (`id`, `username`, `email`, `password`, `idAnggota`, `nama`) VALUES
(1, 'admin', 'admin@admin.com', 'admin', 'admin01', 'admin');

-- --------------------------------------------------------

--
-- Table structure for table `buku`
--

CREATE TABLE `buku` (
  `idItem` varchar(50) NOT NULL,
  `judul` varchar(255) NOT NULL,
  `penulis` varchar(255) NOT NULL,
  `tahunTerbit` int(11) NOT NULL,
  `gambarUrl` varchar(255) DEFAULT NULL,
  `stok` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `buku`
--

INSERT INTO `buku` (`idItem`, `judul`, `penulis`, `tahunTerbit`, `gambarUrl`, `stok`) VALUES
('bku1', 'To Kill a Mockingbird', 'Harper Lee', 1960, 'https://cdn.britannica.com/21/182021-050-666DB6B1/book-cover-To-Kill-a-Mockingbird-many-1961.jpg?w=300', 2),
('bku10', 'Crime and Punishment', 'Fyodor Dostoevsky', 1866, 'https://upload.wikimedia.org/wikipedia/en/4/4b/Crimeandpunishmentcover.png', 1),
('bku2', '1984', 'George Orwell', 1949, 'https://inc.mizanstore.com/aassets/img/com_cart/produk/covBT-017.jpg', 0),
('bku3', 'The Great Gatsby', 'F. Scott Fitzgerald', 1925, 'https://nursaadahnubatonis.web.ugm.ac.id/wp-content/uploads/sites/8584/2021/07/The_Great_Gatsby_Cover_1925_Retouched-212x300.jpg', 0),
('bku4', 'The Catcher in the Rye', 'J.D. Salinger', 1951, 'https://static.periplus.com/n7sbGwpEFQtFucBzKZvDSK4rmpoQUPrOzDYhFoTDPQ2dqpkj0ClzXNCTwW1I9ivQA--', 1),
('bku5', 'Pride and Prejudice', 'Jane Austen', 1813, 'https://cloud.firebrandtech.com/api/v2/image/111/9780785839866/CoverArtHigh/XL', 2),
('bku6', 'The Hobbit', 'J.R.R. Tolkien', 1937, 'https://i.harperapps.com/hcanz/covers/9780007322602/x293.jpg', 3),
('bku7', 'Moby-Dick', 'Herman Melville', 1851, 'https://covers.storytel.com/jpg-640/9789354866609.69d09c02-11bd-4720-8c33-9b4396a96b8b?optimize=high&quality=70&width=600', 4),
('bku8', 'War and Peace', 'Leo Tolstoy', 1869, 'https://d28hgpri8am2if.cloudfront.net/book_images/onix/cvr9781524864989/war-and-peace-9781524864989_lg.jpg', 5),
('bku9', 'The Odyssey', 'Homer', -800, 'https://monsieurdidot.com/wp-content/uploads/2020/02/The-Odyssey.jpg', 2);

-- --------------------------------------------------------

--
-- Table structure for table `dvd`
--

CREATE TABLE `dvd` (
  `idItem` varchar(50) NOT NULL,
  `judul` varchar(255) NOT NULL,
  `sutradara` varchar(255) NOT NULL,
  `durasi` int(11) NOT NULL,
  `gambarUrl` varchar(255) NOT NULL,
  `stok` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `dvd`
--

INSERT INTO `dvd` (`idItem`, `judul`, `sutradara`, `durasi`, `gambarUrl`, `stok`) VALUES
('dvd01', 'Inception', 'Christopher Nolan', 148, 'https://example.com/inception.jpg', 1),
('dvd02', 'The Godfather', 'Francis Ford Coppola', 175, 'https://example.com/godfather.jpg', 0),
('dvd03', 'The Dark Knight', 'Christopher Nolan', 152, 'https://example.com/darkknight.jpg', 1),
('dvd04', 'Pulp Fiction', 'Quentin Tarantino', 154, 'https://example.com/pulpfiction.jpg', 2),
('dvd05', 'The Lord of the Rings: The Return of the King', 'Peter Jackson', 201, 'https://example.com/lotr.jpg', 0),
('dvd06', 'Fight Club', 'David Fincher', 139, 'https://example.com/fightclub.jpg', 3),
('dvd07', 'Forrest Gump', 'Robert Zemeckis', 142, 'https://example.com/forrestgump.jpg', 5),
('dvd08', 'The Matrix', 'Lana Wachowski, Lilly Wachowski', 136, 'https://example.com/matrix.jpg', 6),
('dvd09', 'Goodfellas', 'Martin Scorsese', 146, 'https://example.com/goodfellas.jpg', 1),
('dvd10', 'The Shawshank Redemption', 'Frank Darabont', 142, 'https://example.com/shawshank.jpg', 0);

-- --------------------------------------------------------

--
-- Table structure for table `jurnal`
--

CREATE TABLE `jurnal` (
  `idItem` varchar(50) NOT NULL,
  `judul` varchar(255) NOT NULL,
  `penulis` varchar(255) NOT NULL,
  `bidang` varchar(255) NOT NULL,
  `gambarUrl` varchar(255) NOT NULL,
  `stok` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `jurnal`
--

INSERT INTO `jurnal` (`idItem`, `judul`, `penulis`, `bidang`, `gambarUrl`, `stok`) VALUES
('jnl01', 'Nature', 'John Smith', 'Biology', 'https://example.com/nature.jpg', 1),
('jnl02', 'Science', 'Jane Doe', 'Physics', 'https://example.com/science.jpg', 2),
('jnl03', 'Cell', 'Alice Johnson', 'Biochemistry', 'https://example.com/cell.jpg', 2),
('jnl04', 'The Lancet', 'Robert Brown', 'Medicine', 'https://example.com/lancet.jpg', 1),
('jnl05', 'The Astrophysical Journal', 'Chris Martin', 'Astronomy', 'https://example.com/apj.jpg', 0),
('jnl06', 'Journal of Political Economy', 'Sarah Lee', 'Economics', 'https://example.com/jpe.jpg', 0),
('jnl07', 'Journal of Finance', 'Michael Davis', 'Finance', 'https://example.com/jof.jpg', 1),
('jnl08', 'Chemical Reviews', 'Emily Clark', 'Chemistry', 'https://example.com/chemrev.jpg', 3),
('jnl09', 'Psychological Review', 'James Wilson', 'Psychology', 'https://example.com/psychrev.jpg', 5),
('jnl10', 'Journal of Marketing', 'Patricia Anderson', 'Marketing', 'https://example.com/jom.jpg', 1);

-- --------------------------------------------------------

--
-- Table structure for table `majalah`
--

CREATE TABLE `majalah` (
  `idItem` varchar(50) NOT NULL,
  `judul` varchar(255) NOT NULL,
  `edisi` int(11) NOT NULL,
  `gambarUrl` varchar(255) NOT NULL,
  `stok` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `majalah`
--

INSERT INTO `majalah` (`idItem`, `judul`, `edisi`, `gambarUrl`, `stok`) VALUES
('mgz01', 'National Geographic', 202, 'https://example.com/natgeo.jpg', 2),
('mgz02', 'TIME Magazine', 150, 'https://example.com/time.jpg', 2),
('mgz03', 'Forbes', 175, 'https://example.com/forbes.jpg', 2),
('mgz04', 'Vogue', 300, 'https://example.com/vogue.jpg', 0),
('mgz05', 'Scientific American', 400, 'https://example.com/sciam.jpg', 0),
('mgz06', 'The Economist', 210, 'https://example.com/economist.jpg', 1),
('mgz07', 'New Scientist', 350, 'https://example.com/newscientist.jpg', 3),
('mgz08', 'Nature', 450, 'https://example.com/naturemag.jpg', 5),
('mgz09', 'Wired', 230, 'https://example.com/wired.jpg', 5),
('mgz10', 'People', 520, 'https://example.com/people.jpg', 1);

-- --------------------------------------------------------

--
-- Table structure for table `peminjaman`
--

CREATE TABLE `peminjaman` (
  `idTransaksi` varchar(50) NOT NULL,
  `idItem` varchar(50) NOT NULL,
  `tanggalTransaksi` bigint(20) NOT NULL,
  `tanggalKembali` bigint(20) NOT NULL,
  `idAnggota` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `peminjaman`
--

INSERT INTO `peminjaman` (`idTransaksi`, `idItem`, `tanggalTransaksi`, `tanggalKembali`, `idAnggota`) VALUES
('0a56d9b2-1c22-49a9-be9f-ad8d518acd34', 'bku1', 1735536584, 1735709384, '0c16853a-9868-4871-9bdd-b9659a8c1e5f'),
('123b8832-824b-46f5-b3d1-db51644dcb28', 'bku2', 1735537259, 1735623659, '0c16853a-9868-4871-9bdd-b9659a8c1e5f'),
('3153c536-c8c0-4f71-b038-5eb491d6a93e', 'bku2', 1734950869, 1735123669, NULL),
('71422634-5487-46cb-90df-84343c5096e5', 'bku3', 1735537445, 1735623845, '0c16853a-9868-4871-9bdd-b9659a8c1e5f'),
('8c30c62f-128e-4bb7-b411-e7f7d89549c4', 'bku2', 1735537020, 1735709820, '0c16853a-9868-4871-9bdd-b9659a8c1e5f'),
('9047df54-05f1-4bc2-8698-943602c3855e', 'dvd03', 1734950938, 1735123738, NULL),
('914fade2-b390-4004-ab09-b6061de6385c', 'dvd01', 1735541274, 1735714074, '0c16853a-9868-4871-9bdd-b9659a8c1e5f'),
('92ceb304-9777-4be3-886e-4a524137e525', 'bku2', 1734950789, 1735123589, NULL),
('aecb21cf-2782-4f83-a720-0e0d83b289a7', 'bku1', 1734950687, 1735123487, NULL),
('b3ea7ec6-61b4-4977-8bad-a23cd7f7dae3', 'bku2', 1735537300, 1735623700, '0c16853a-9868-4871-9bdd-b9659a8c1e5f'),
('be8127e5-6f90-42a0-b5c8-83207c969532', 'bku3', 1734950972, 1735123772, NULL),
('d1693220-d73f-4220-a184-11e09eb71a53', 'bku1', 1734950644, 1735123444, NULL),
('d5382819-92ae-4648-a78b-dccf4ceea167', 'bku1', 1734950722, 1735123522, NULL),
('e0bea14f-479b-49f9-9de3-45cb3278bd1a', 'bku1', 1734950590, 1735123390, NULL),
('PJM-072536dd', 'bku2', 1735711747, 1735884547, 'MBR-1061d98b'),
('PJM-32219e89', 'dvd02', 1735713194, 1735885994, 'MBR-1061d98b'),
('PJM-3931c660', 'bku10', 1735725863, 1735898663, 'MBR-1061d98b');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `idAnggota` varchar(50) DEFAULT NULL,
  `nama` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `password`, `idAnggota`, `nama`) VALUES
(1, 'Printer', 'printer@monas.id', 'printer', NULL, NULL),
(2, 'buku', 'buku@gmail.com', 'buku', '0c16853a-9868-4871-9bdd-b9659a8c1e5f', 'test'),
(3, 'test', 'test@gmail.com', 'test', NULL, 'test'),
(4, 'nyoba', 'nyobaaaaa@gmail.com', 'nyoba', NULL, NULL),
(5, 'Printer123', 'Printer123@gmail.com', 'Printer123', NULL, NULL),
(6, 'test123', 'test123@gmail.com', 'test123', NULL, NULL),
(7, 'beli', 'beli@gmail.com', 'beli', 'MBR-1061d98b', 'beli');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `anggota`
--
ALTER TABLE `anggota`
  ADD PRIMARY KEY (`idAnggota`),
  ADD KEY `idUser` (`idUser`);

--
-- Indexes for table `anggota_karyawan`
--
ALTER TABLE `anggota_karyawan`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `buku`
--
ALTER TABLE `buku`
  ADD PRIMARY KEY (`idItem`);

--
-- Indexes for table `dvd`
--
ALTER TABLE `dvd`
  ADD PRIMARY KEY (`idItem`);

--
-- Indexes for table `jurnal`
--
ALTER TABLE `jurnal`
  ADD PRIMARY KEY (`idItem`);

--
-- Indexes for table `majalah`
--
ALTER TABLE `majalah`
  ADD PRIMARY KEY (`idItem`);

--
-- Indexes for table `peminjaman`
--
ALTER TABLE `peminjaman`
  ADD PRIMARY KEY (`idTransaksi`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `anggota_karyawan`
--
ALTER TABLE `anggota_karyawan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `anggota`
--
ALTER TABLE `anggota`
  ADD CONSTRAINT `anggota_ibfk_1` FOREIGN KEY (`idUser`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
