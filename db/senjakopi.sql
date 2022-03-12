-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 12, 2022 at 08:51 AM
-- Server version: 10.4.17-MariaDB
-- PHP Version: 7.4.15

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `senjakopi`
--

-- --------------------------------------------------------

--
-- Table structure for table `barang`
--

CREATE TABLE `barang` (
  `id_barang` int(11) NOT NULL,
  `id_kategori` int(11) NOT NULL,
  `id_supplier` int(11) NOT NULL,
  `kode_barang` varchar(20) NOT NULL,
  `nama_barang` varchar(100) NOT NULL,
  `stock_toko` varchar(100) NOT NULL,
  `stock_gudang` varchar(100) NOT NULL,
  `satuan` enum('Liter','Kilogram','Gram') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `barang`
--

INSERT INTO `barang` (`id_barang`, `id_kategori`, `id_supplier`, `kode_barang`, `nama_barang`, `stock_toko`, `stock_gudang`, `satuan`) VALUES
(1, 4, 2, 'BR001', 'Tepung Segitiga Biru', '0', '50', 'Kilogram'),
(2, 1, 1, 'BR002', 'Saus Sambal', '0', '15', 'Kilogram'),
(3, 1, 1, 'BR003', 'Bubuk Kari', '0', '800', 'Gram'),
(4, 3, 3, 'BR004', 'Susu Diamond', '0', '0', 'Liter'),
(5, 1, 5, 'BR005', 'Kecap Manis', '8', '5', 'Kilogram'),
(6, 1, 5, 'BR006', 'Bubuk Rendang', '0', '0', 'Gram'),
(7, 4, 4, 'BR007', 'Tepung Rose Brand', '0', '0', 'Kilogram'),
(8, 2, 1, 'BR008', 'Saus Tomat', '0', '0', 'Kilogram');

-- --------------------------------------------------------

--
-- Table structure for table `barang_keluar`
--

CREATE TABLE `barang_keluar` (
  `id_barangkeluar` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `id_permintaanbarang` int(11) NOT NULL,
  `kode_barangkeluar` varchar(20) NOT NULL,
  `tgl_barangkeluar` date NOT NULL,
  `status_barangkeluar` enum('Setuju','Ditolak') NOT NULL,
  `jumlah_barangkeluar` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `barang_keluar`
--

INSERT INTO `barang_keluar` (`id_barangkeluar`, `id_user`, `id_permintaanbarang`, `kode_barangkeluar`, `tgl_barangkeluar`, `status_barangkeluar`, `jumlah_barangkeluar`) VALUES
(4, 4, 2, 'BK001', '2022-03-09', 'Setuju', '5');

-- --------------------------------------------------------

--
-- Table structure for table `barang_masuk`
--

CREATE TABLE `barang_masuk` (
  `id_barangmasuk` int(11) NOT NULL,
  `id_po` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `kode_barangmasuk` varchar(20) NOT NULL,
  `tgl_barangmasuk` date NOT NULL,
  `status_barangmasuk` enum('Diterima') NOT NULL,
  `jumlah_barangmasuk` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `barang_masuk`
--

INSERT INTO `barang_masuk` (`id_barangmasuk`, `id_po`, `id_user`, `kode_barangmasuk`, `tgl_barangmasuk`, `status_barangmasuk`, `jumlah_barangmasuk`) VALUES
(2, 12, 4, 'BM001', '2022-03-09', 'Diterima', '50'),
(3, 13, 4, 'BM002', '2022-03-09', 'Diterima', '15'),
(4, 14, 4, 'BM003', '2022-03-09', 'Diterima', '1000'),
(5, 16, 4, 'BM004', '2022-03-09', 'Diterima', '15');

-- --------------------------------------------------------

--
-- Table structure for table `kategori`
--

CREATE TABLE `kategori` (
  `id_kategori` int(11) NOT NULL,
  `nama_kategori` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `kategori`
--

INSERT INTO `kategori` (`id_kategori`, `nama_kategori`) VALUES
(1, 'Bumbu'),
(2, 'Makanan'),
(3, 'Minuman'),
(4, 'Tepung');

-- --------------------------------------------------------

--
-- Table structure for table `permintaan_barang`
--

CREATE TABLE `permintaan_barang` (
  `id_permintaanbarang` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `id_barang` int(11) NOT NULL,
  `kode_permintaanbarang` varchar(20) NOT NULL,
  `tgl_permintaanbarang` date NOT NULL,
  `jumlah_permintaanbarang` varchar(20) NOT NULL,
  `status_permintaanbarang` enum('Meminta','Setuju','Ditolak') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `permintaan_barang`
--

INSERT INTO `permintaan_barang` (`id_permintaanbarang`, `id_user`, `id_barang`, `kode_permintaanbarang`, `tgl_permintaanbarang`, `jumlah_permintaanbarang`, `status_permintaanbarang`) VALUES
(1, 2, 3, 'PB001', '2022-03-09', '200', 'Setuju'),
(2, 2, 5, 'PB002', '2022-03-09', '5', 'Setuju'),
(3, 2, 5, 'PB003', '2022-03-09', '5', 'Ditolak');

-- --------------------------------------------------------

--
-- Table structure for table `permintaan_pembelian`
--

CREATE TABLE `permintaan_pembelian` (
  `id_permintaanpembelian` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `id_barang` int(11) NOT NULL,
  `kode_permintaanpembelian` varchar(20) NOT NULL,
  `tgl_permintaanpembelian` date NOT NULL,
  `jumlah_permintaanpembelian` varchar(100) NOT NULL,
  `status_permintaanpembelian` enum('Meminta','Ditolak','Setuju') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `permintaan_pembelian`
--

INSERT INTO `permintaan_pembelian` (`id_permintaanpembelian`, `id_user`, `id_barang`, `kode_permintaanpembelian`, `tgl_permintaanpembelian`, `jumlah_permintaanpembelian`, `status_permintaanpembelian`) VALUES
(10, 4, 1, 'PP001', '2022-03-09', '50', 'Setuju'),
(11, 4, 2, 'PP002', '2022-03-07', '15', 'Setuju'),
(12, 4, 3, 'PP003', '2022-03-08', '1000', 'Setuju'),
(13, 4, 4, 'PP004', '2022-03-09', '30', 'Setuju'),
(14, 4, 5, 'PP005', '2022-03-09', '15', 'Setuju'),
(15, 4, 6, 'PP006', '2022-03-09', '2000', 'Setuju'),
(16, 4, 7, 'PP007', '2022-03-09', '50', 'Meminta'),
(17, 4, 8, 'PP008', '2022-03-09', '15', 'Meminta'),
(18, 4, 8, 'PP009', '2022-03-09', '100', 'Ditolak');

-- --------------------------------------------------------

--
-- Table structure for table `po`
--

CREATE TABLE `po` (
  `id_po` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `id_permintaanpembelian` int(11) NOT NULL,
  `kode_po` varchar(20) NOT NULL,
  `tgl_po` date NOT NULL,
  `jumlah_po` varchar(100) NOT NULL,
  `status_po` enum('Mengirim','Diterima','Ditolak') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `po`
--

INSERT INTO `po` (`id_po`, `id_user`, `id_permintaanpembelian`, `kode_po`, `tgl_po`, `jumlah_po`, `status_po`) VALUES
(12, 3, 10, 'PO001', '2022-03-09', '50', 'Diterima'),
(13, 3, 11, 'PO002', '2022-03-09', '15', 'Diterima'),
(14, 3, 12, 'PO003', '2022-03-09', '1000', 'Diterima'),
(15, 3, 13, 'PO004', '2022-03-09', '30', 'Mengirim'),
(16, 3, 14, 'PO005', '2022-03-09', '15', 'Diterima'),
(17, 3, 15, 'PO006', '2022-03-09', '2000', 'Mengirim'),
(18, 3, 18, 'PO007', '2022-03-09', '100', 'Ditolak');

-- --------------------------------------------------------

--
-- Table structure for table `supplier`
--

CREATE TABLE `supplier` (
  `id_supplier` int(11) NOT NULL,
  `kode_supplier` varchar(20) NOT NULL,
  `nama_supplier` varchar(100) NOT NULL,
  `alamat_supplier` varchar(300) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `supplier`
--

INSERT INTO `supplier` (`id_supplier`, `kode_supplier`, `nama_supplier`, `alamat_supplier`) VALUES
(1, 'SP001', 'PT. Gunacipta Mutirasa', 'Jl. Faliman Jaya No.1, RT.002/RW.009, Kb. Besar, Kec. Batuceper, Kota Tangerang, Banten 15122'),
(2, 'SP002', 'Bogasari', 'Jl. Raya Cilincing No.1, Tanjung Priok, Jakarta, Indonesia'),
(3, 'SP003', 'PT Diamond Food Indonesia Tbk', 'Jalan Ring Road Utara, Kecamatan Depok, Sanggrahan, Maguwoharjo, Sleman, Kabupaten Sleman, Daerah Istimewa Yogyakarta 55281'),
(4, 'SP004', 'PT Budi Acid Jaya Tbk', ' Jl. H.R. Rasuna Said, Wisma Budi, 8th - 9th Floor, RT.15/RW.2, Cipete Sel., Kec. Cilandak, Kota Jakarta Selatan, Daerah Khusus Ibukota Jakarta 12410'),
(5, 'SP005', 'PT Indofood Sukses Makmur Tbk', 'Jl. Ipda Tut Harsono No.50-52, Muja Muju, Kec. Umbulharjo, Kota Yogyakarta, Daerah Istimewa Yogyakarta 55165');

-- --------------------------------------------------------

--
-- Table structure for table `user_petugas`
--

CREATE TABLE `user_petugas` (
  `id_user` int(11) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `jabatan` varchar(100) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `foto_user` varchar(100) NOT NULL,
  `level` enum('admin','store','purchasing','gudang') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user_petugas`
--

INSERT INTO `user_petugas` (`id_user`, `nama`, `jabatan`, `phone`, `email`, `password`, `foto_user`, `level`) VALUES
(1, 'admin', 'Manager', '083156656783', 'admin@gmail.com', '40bd001563085fc35165329ea1ff5c5ecbdbbeef', 'male-1.png', 'admin'),
(2, 'store', 'Manager Stores', '084093137086', 'store@gmail.com', '40bd001563085fc35165329ea1ff5c5ecbdbbeef', 'female-2.png', 'store'),
(3, 'purchasing', 'Manager Purchasing', '084406675045', 'purchasing@gmail.com', '40bd001563085fc35165329ea1ff5c5ecbdbbeef', 'male-3.png', 'purchasing'),
(4, 'gudang', 'Gudang', '086315013455', 'gudang@gmail.com', '40bd001563085fc35165329ea1ff5c5ecbdbbeef', 'male-2.png', 'gudang');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `barang`
--
ALTER TABLE `barang`
  ADD PRIMARY KEY (`id_barang`),
  ADD KEY `id_kategori` (`id_kategori`,`id_supplier`),
  ADD KEY `barang_ibfk_1` (`id_supplier`);

--
-- Indexes for table `barang_keluar`
--
ALTER TABLE `barang_keluar`
  ADD PRIMARY KEY (`id_barangkeluar`),
  ADD KEY `id_user` (`id_user`,`id_permintaanbarang`),
  ADD KEY `barang_keluar_ibfk_2` (`id_permintaanbarang`);

--
-- Indexes for table `barang_masuk`
--
ALTER TABLE `barang_masuk`
  ADD PRIMARY KEY (`id_barangmasuk`),
  ADD KEY `id_po` (`id_po`,`id_user`),
  ADD KEY `id_user` (`id_user`);

--
-- Indexes for table `kategori`
--
ALTER TABLE `kategori`
  ADD PRIMARY KEY (`id_kategori`);

--
-- Indexes for table `permintaan_barang`
--
ALTER TABLE `permintaan_barang`
  ADD PRIMARY KEY (`id_permintaanbarang`),
  ADD KEY `id_user` (`id_user`),
  ADD KEY `id_barang` (`id_barang`);

--
-- Indexes for table `permintaan_pembelian`
--
ALTER TABLE `permintaan_pembelian`
  ADD PRIMARY KEY (`id_permintaanpembelian`),
  ADD KEY `id_user` (`id_user`,`id_barang`),
  ADD KEY `id_barang` (`id_barang`);

--
-- Indexes for table `po`
--
ALTER TABLE `po`
  ADD PRIMARY KEY (`id_po`),
  ADD KEY `id_user` (`id_user`,`id_permintaanpembelian`),
  ADD KEY `id_permintaanpembelian` (`id_permintaanpembelian`);

--
-- Indexes for table `supplier`
--
ALTER TABLE `supplier`
  ADD PRIMARY KEY (`id_supplier`);

--
-- Indexes for table `user_petugas`
--
ALTER TABLE `user_petugas`
  ADD PRIMARY KEY (`id_user`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `barang`
--
ALTER TABLE `barang`
  MODIFY `id_barang` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `barang_keluar`
--
ALTER TABLE `barang_keluar`
  MODIFY `id_barangkeluar` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `barang_masuk`
--
ALTER TABLE `barang_masuk`
  MODIFY `id_barangmasuk` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `kategori`
--
ALTER TABLE `kategori`
  MODIFY `id_kategori` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `permintaan_barang`
--
ALTER TABLE `permintaan_barang`
  MODIFY `id_permintaanbarang` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `permintaan_pembelian`
--
ALTER TABLE `permintaan_pembelian`
  MODIFY `id_permintaanpembelian` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `po`
--
ALTER TABLE `po`
  MODIFY `id_po` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `supplier`
--
ALTER TABLE `supplier`
  MODIFY `id_supplier` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `user_petugas`
--
ALTER TABLE `user_petugas`
  MODIFY `id_user` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `barang`
--
ALTER TABLE `barang`
  ADD CONSTRAINT `barang_ibfk_1` FOREIGN KEY (`id_supplier`) REFERENCES `supplier` (`id_supplier`),
  ADD CONSTRAINT `barang_ibfk_2` FOREIGN KEY (`id_kategori`) REFERENCES `kategori` (`id_kategori`);

--
-- Constraints for table `barang_keluar`
--
ALTER TABLE `barang_keluar`
  ADD CONSTRAINT `barang_keluar_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `user_petugas` (`id_user`),
  ADD CONSTRAINT `barang_keluar_ibfk_2` FOREIGN KEY (`id_permintaanbarang`) REFERENCES `permintaan_barang` (`id_permintaanbarang`);

--
-- Constraints for table `barang_masuk`
--
ALTER TABLE `barang_masuk`
  ADD CONSTRAINT `barang_masuk_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `user_petugas` (`id_user`),
  ADD CONSTRAINT `barang_masuk_ibfk_2` FOREIGN KEY (`id_po`) REFERENCES `po` (`id_po`);

--
-- Constraints for table `permintaan_barang`
--
ALTER TABLE `permintaan_barang`
  ADD CONSTRAINT `permintaan_barang_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `user_petugas` (`id_user`),
  ADD CONSTRAINT `permintaan_barang_ibfk_2` FOREIGN KEY (`id_barang`) REFERENCES `barang` (`id_barang`);

--
-- Constraints for table `permintaan_pembelian`
--
ALTER TABLE `permintaan_pembelian`
  ADD CONSTRAINT `permintaan_pembelian_ibfk_1` FOREIGN KEY (`id_barang`) REFERENCES `barang` (`id_barang`),
  ADD CONSTRAINT `permintaan_pembelian_ibfk_2` FOREIGN KEY (`id_user`) REFERENCES `user_petugas` (`id_user`);

--
-- Constraints for table `po`
--
ALTER TABLE `po`
  ADD CONSTRAINT `po_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `user_petugas` (`id_user`),
  ADD CONSTRAINT `po_ibfk_2` FOREIGN KEY (`id_permintaanpembelian`) REFERENCES `permintaan_pembelian` (`id_permintaanpembelian`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;