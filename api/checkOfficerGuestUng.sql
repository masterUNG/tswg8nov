-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: May 01, 2023 at 05:50 PM
-- Server version: 10.6.9-MariaDB
-- PHP Version: 7.4.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `androidh_fluttertraining`
--

-- --------------------------------------------------------

--
-- Table structure for table `checkOfficerGuestUng`
--

CREATE TABLE `checkOfficerGuestUng` (
  `id` int(11) NOT NULL,
  `nameAndSur` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `carId` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `province` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `objective` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `urlImage1` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `urlImage2` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `urlImage3` text COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `checkOfficerGuestUng`
--

INSERT INTO `checkOfficerGuestUng` (`id`, `nameAndSur`, `phone`, `carId`, `province`, `objective`, `urlImage1`, `urlImage2`, `urlImage3`) VALUES
(1, 'Master Ung', '0811234567', '6 กล 7124', 'กรุงเทพมหานคร', 'ติดต่อการตลาด', 'https://www.androidthai.in.th/fluttertraining/checeOffocerUng/image/image100404.jpg', 'https://www.androidthai.in.th/fluttertraining/checeOffocerUng/image/image456381.jpg', 'https://www.androidthai.in.th/fluttertraining/checeOffocerUng/image/image589718.jpg'),
(2, 'aaa', '1234567', 'a1234', 'ลพบุรี', 'ผู้รับเหมา', 'https://www.androidthai.in.th/fluttertraining/checeOffocerUng/image/image887718.jpg', 'https://www.androidthai.in.th/fluttertraining/checeOffocerUng/image/image540832.jpg', 'https://www.androidthai.in.th/fluttertraining/checeOffocerUng/image/image520088.jpg');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `checkOfficerGuestUng`
--
ALTER TABLE `checkOfficerGuestUng`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `checkOfficerGuestUng`
--
ALTER TABLE `checkOfficerGuestUng`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
