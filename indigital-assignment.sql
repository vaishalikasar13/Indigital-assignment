-- phpMyAdmin SQL Dump
-- version 4.6.5.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 20, 2017 at 08:07 PM
-- Server version: 10.1.21-MariaDB
-- PHP Version: 7.1.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `assignment`
--

-- --------------------------------------------------------

--
-- Table structure for table `bsn_prm`
--

CREATE TABLE `bsn_prm` (
  `bpm_id` int(11) NOT NULL,
  `bpm_name` varchar(400) NOT NULL,
  `bpm_value` text NOT NULL,
  `bpm_crtd_dt` datetime NOT NULL,
  `bpm_crtd_by` int(11) NOT NULL,
  `bpm_updt_dt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `bpm_updt_by` varchar(50) NOT NULL,
  `bpm_last_ip` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='business parameters';

--
-- Dumping data for table `bsn_prm`
--

INSERT INTO `bsn_prm` (`bpm_id`, `bpm_name`, `bpm_value`, `bpm_crtd_dt`, `bpm_crtd_by`, `bpm_updt_dt`, `bpm_updt_by`, `bpm_last_ip`) VALUES
(1, 'admin_webhook_url', 'https://hooks.slack.com/services/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', '2017-11-19 11:00:00', 0, '2017-11-20 17:42:11', '', '');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `slack`
--

CREATE TABLE `slack` (
  `slk_id` int(11) NOT NULL,
  `slk_usr_name` varchar(50) NOT NULL,
  `slk_usr_mobile` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) NOT NULL,
  `usr_name` varchar(100) NOT NULL,
  `usr_email` varchar(100) NOT NULL,
  `usr_mobile` varchar(100) NOT NULL,
  `usr_password` varchar(100) NOT NULL,
  `usr_company_name` varchar(200) NOT NULL,
  `usr_designation` varchar(200) NOT NULL,
  `usr_company_size` varchar(100) NOT NULL,
  `usr_status` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `usr_name`, `usr_email`, `usr_mobile`, `usr_password`, `usr_company_name`, `usr_designation`, `usr_company_size`, `usr_status`, `created_at`, `updated_at`) VALUES
(1, 'vaishali kasar', 'vaishalikasar13@gmail.com', '8655385802', '$2y$10$B6Pr13dLVfyuFM.lj11f7.Emo.rjZCaV4MVAi8EOgwDC4iofBypwi', 'Nextasy', 'Web Developer', '10', 1, '2017-11-20 13:35:48', '2017-11-20 13:35:48');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bsn_prm`
--
ALTER TABLE `bsn_prm`
  ADD PRIMARY KEY (`bpm_id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `slack`
--
ALTER TABLE `slack`
  ADD PRIMARY KEY (`slk_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `bsn_prm`
--
ALTER TABLE `bsn_prm`
  MODIFY `bpm_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `slack`
--
ALTER TABLE `slack`
  MODIFY `slk_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
