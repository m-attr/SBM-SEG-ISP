-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Host: mysql-seg-sbm-isp.alwaysdata.net
-- Generation Time: Nov 17, 2026 at 01:57 PM
-- Server version: 11.8.9-MariaDB
-- PHP Version: 8.4.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `seg-sbm-isp_dev`
--

-- --------------------------------------------------------

--
-- Table structure for table `attendance_records`
--

CREATE TABLE `attendance_records` (
  `attendance_id` int(11) NOT NULL,
  `session_id` int(11) NOT NULL,
  `attendance_status` enum('Present','Absent') NOT NULL,
  `submitted_by` int(11) NOT NULL,
  `submitted_at` datetime NOT NULL,
  `absence_reason` text DEFAULT NULL,
  `reason_updated_at` datetime DEFAULT NULL,
  `reviewed_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `class_sessions`
--

CREATE TABLE `class_sessions` (
  `session_id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  `tuition_id` int(11) NOT NULL,
  `class_name` varchar(100) NOT NULL,
  `session_datetime` datetime NOT NULL,
  `location` varchar(150) DEFAULT NULL,
  `class_status` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `communication_logs`
--

CREATE TABLE `communication_logs` (
  `notification_id` int(11) NOT NULL,
  `recipient_user_id` int(11) NOT NULL,
  `session_id` int(11) DEFAULT NULL,
  `attendance_id` int(11) DEFAULT NULL,
  `notification_type` varchar(50) NOT NULL,
  `notification_status` enum('Unread','Read') NOT NULL,
  `created_at` datetime NOT NULL,
  `read_at` datetime DEFAULT NULL,
  `triggered_by_user_id` int(11) DEFAULT NULL,
  `email_status` enum('Not Sent','Pending','Sent','Failed') DEFAULT NULL,
  `email_sent_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `role_id` int(11) NOT NULL,
  `role_name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `students`
--

CREATE TABLE `students` (
  `student_id` int(11) NOT NULL,
  `student_name` varchar(150) NOT NULL,
  `tuition_id` int(11) NOT NULL,
  `academic_level` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tuition_agencies`
--

CREATE TABLE `tuition_agencies` (
  `tuition_id` int(11) NOT NULL,
  `tuition_name` varchar(150) NOT NULL,
  `tuition_location` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  `full_name` varchar(150) NOT NULL,
  `email_address` varchar(255) NOT NULL,
  `phone_number` varchar(20) DEFAULT NULL,
  `password_hash` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users_tuition_agency`
--

CREATE TABLE `users_tuition_agency` (
  `user_id` int(11) NOT NULL,
  `tuition_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `attendance_records`
--
ALTER TABLE `attendance_records`
  ADD PRIMARY KEY (`attendance_id`),
  ADD UNIQUE KEY `session_id` (`session_id`),
  ADD KEY `submitted_by` (`submitted_by`);

--
-- Indexes for table `class_sessions`
--
ALTER TABLE `class_sessions`
  ADD PRIMARY KEY (`session_id`),
  ADD KEY `tuition_id` (`tuition_id`),
  ADD KEY `student_id` (`student_id`);

--
-- Indexes for table `communication_logs`
--
ALTER TABLE `communication_logs`
  ADD PRIMARY KEY (`notification_id`),
  ADD KEY `recipient_user_id` (`recipient_user_id`),
  ADD KEY `session_id` (`session_id`),
  ADD KEY `attendance_id` (`attendance_id`),
  ADD KEY `triggered_by_user_id` (`triggered_by_user_id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`role_id`),
  ADD UNIQUE KEY `role_name` (`role_name`);

--
-- Indexes for table `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`student_id`),
  ADD KEY `tuition_id` (`tuition_id`);

--
-- Indexes for table `tuition_agencies`
--
ALTER TABLE `tuition_agencies`
  ADD PRIMARY KEY (`tuition_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `email_address` (`email_address`),
  ADD KEY `role_id` (`role_id`);

--
-- Indexes for table `users_tuition_agency`
--
ALTER TABLE `users_tuition_agency`
  ADD PRIMARY KEY (`user_id`),
  ADD KEY `tuition_id` (`tuition_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `attendance_records`
--
ALTER TABLE `attendance_records`
  MODIFY `attendance_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `class_sessions`
--
ALTER TABLE `class_sessions`
  MODIFY `session_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `communication_logs`
--
ALTER TABLE `communication_logs`
  MODIFY `notification_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `role_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `students`
--
ALTER TABLE `students`
  MODIFY `student_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tuition_agencies`
--
ALTER TABLE `tuition_agencies`
  MODIFY `tuition_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `attendance_records`
--
ALTER TABLE `attendance_records`
  ADD CONSTRAINT `attendance_records_ibfk_1` FOREIGN KEY (`session_id`) REFERENCES `class_sessions` (`session_id`),
  ADD CONSTRAINT `attendance_records_ibfk_2` FOREIGN KEY (`submitted_by`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `class_sessions`
--
ALTER TABLE `class_sessions`
  ADD CONSTRAINT `class_sessions_ibfk_1` FOREIGN KEY (`tuition_id`) REFERENCES `tuition_agencies` (`tuition_id`),
  ADD CONSTRAINT `class_sessions_ibfk_2` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`);

--
-- Constraints for table `communication_logs`
--
ALTER TABLE `communication_logs`
  ADD CONSTRAINT `communication_logs_ibfk_1` FOREIGN KEY (`recipient_user_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `communication_logs_ibfk_2` FOREIGN KEY (`session_id`) REFERENCES `class_sessions` (`session_id`),
  ADD CONSTRAINT `communication_logs_ibfk_3` FOREIGN KEY (`attendance_id`) REFERENCES `attendance_records` (`attendance_id`),
  ADD CONSTRAINT `communication_logs_ibfk_4` FOREIGN KEY (`triggered_by_user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `students`
--
ALTER TABLE `students`
  ADD CONSTRAINT `students_ibfk_1` FOREIGN KEY (`tuition_id`) REFERENCES `tuition_agencies` (`tuition_id`);

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `roles` (`role_id`);

--
-- Constraints for table `users_tuition_agency`
--
ALTER TABLE `users_tuition_agency`
  ADD CONSTRAINT `users_tuition_agency_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `users_tuition_agency_ibfk_2` FOREIGN KEY (`tuition_id`) REFERENCES `tuition_agencies` (`tuition_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
