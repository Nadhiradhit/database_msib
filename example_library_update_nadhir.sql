-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 02, 2023 at 08:46 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `example_library`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_view_data` ()   SELECT * FROM data_sewa$$

--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `kalkulasi` (`xket` INT) RETURNS VARCHAR(15) CHARSET utf8mb4 COLLATE utf8mb4_general_ci DETERMINISTIC BEGIN 
	DECLARE ket_sewa VARCHAR(15);
	IF xket >= 4 THEN 
		SET ket_sewa = 'Paling Laku';
	ELSE 
		SET ket_sewa = 'Kurang Laku';
	END IF;

	RETURN ket_sewa;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Stand-in structure for view `data_sewa`
-- (See below for the actual view)
--
CREATE TABLE `data_sewa` (
`id` int(11)
,`nama_room` varchar(100)
,`nama_penyewa` varchar(100)
,`durasi_sewa` int(11)
);

-- --------------------------------------------------------

--
-- Table structure for table `interest`
--

CREATE TABLE `interest` (
  `id` int(12) NOT NULL,
  `room_id` int(12) NOT NULL,
  `nama_room` varchar(100) NOT NULL,
  `user_id` int(12) NOT NULL,
  `nama_user` varchar(100) NOT NULL,
  `ket` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `interest`
--

INSERT INTO `interest` (`id`, `room_id`, `nama_room`, `user_id`, `nama_user`, `ket`) VALUES
(1, 2, 'VigiBoard', 1, 'Nadhir', 6);

-- --------------------------------------------------------

--
-- Table structure for table `logs`
--

CREATE TABLE `logs` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `rented_count` varchar(50) NOT NULL,
  `log_in` timestamp NOT NULL DEFAULT current_timestamp(),
  `log_update` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `logs`
--

INSERT INTO `logs` (`id`, `name`, `rented_count`, `log_in`, `log_update`) VALUES
(1, 'add_room', 'add_rented_count', '2023-09-02 17:44:39', '2023-09-02 17:44:54'),
(2, 'add_room', 'add_rented_count', '2023-09-02 17:45:40', '2023-09-02 17:45:40');

-- --------------------------------------------------------

--
-- Table structure for table `rents`
--

CREATE TABLE `rents` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `room_id` int(11) NOT NULL,
  `duration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `rents`
--

INSERT INTO `rents` (`id`, `user_id`, `room_id`, `duration`) VALUES
(1, 1, 1, 3),
(2, 1, 3, 3),
(3, 2, 2, 2),
(4, 2, 4, 6);

-- --------------------------------------------------------

--
-- Table structure for table `rooms`
--

CREATE TABLE `rooms` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `rented_count` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `rooms`
--

INSERT INTO `rooms` (`id`, `name`, `rented_count`) VALUES
(1, 'Acasia', 2),
(2, 'VigiBoard', 2),
(3, 'Le-Minerale Momentos', 4),
(4, 'Kolak room', 1),
(5, 'Vanilla Reborn', 5);

--
-- Triggers `rooms`
--
DELIMITER $$
CREATE TRIGGER `insert_data` AFTER INSERT ON `rooms` FOR EACH ROW INSERT INTO logs (name,rented_count) VALUE ('add_room', 'add_rented_count')
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `address` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `address`) VALUES
(1, 'Nadhir', 'Bogor'),
(2, 'Rondhi', 'Africa St.1');

-- --------------------------------------------------------

--
-- Structure for view `data_sewa`
--
DROP TABLE IF EXISTS `data_sewa`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `data_sewa`  AS SELECT `rents`.`id` AS `id`, `rooms`.`name` AS `nama_room`, `users`.`name` AS `nama_penyewa`, `rents`.`duration` AS `durasi_sewa` FROM ((`rents` join `users` on(`rents`.`user_id` = `users`.`id`)) join `rooms` on(`rents`.`room_id` = `rooms`.`id`)) ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `interest`
--
ALTER TABLE `interest`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `logs`
--
ALTER TABLE `logs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rents`
--
ALTER TABLE `rents`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rooms`
--
ALTER TABLE `rooms`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `interest`
--
ALTER TABLE `interest`
  MODIFY `id` int(12) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `logs`
--
ALTER TABLE `logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `rents`
--
ALTER TABLE `rents`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `rooms`
--
ALTER TABLE `rooms`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
