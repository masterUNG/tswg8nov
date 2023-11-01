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
-- Table structure for table `checkOfficerObjectiveUng`
--

CREATE TABLE `checkOfficerObjectiveUng` (
  `id` int(11) NOT NULL,
  `objective` text COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `checkOfficerObjectiveUng`
--

INSERT INTO `checkOfficerObjectiveUng` (`id`, `objective`) VALUES
(1, 'ติดต่อฝ่ายขาย'),
(2, 'ติดต่อการตลาด'),
(3, 'ผู้รับเหมา'),
(4, 'อื่นๆ');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `checkOfficerObjectiveUng`
--
ALTER TABLE `checkOfficerObjectiveUng`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `checkOfficerObjectiveUng`
--
ALTER TABLE `checkOfficerObjectiveUng`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
