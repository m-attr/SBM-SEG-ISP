-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Host: mysql-seg-sbm-isp.alwaysdata.net
-- Generation Time: Nov 19, 2026 at 07:52 PM
-- Server version: 11.8.9-MariaDB
-- PHP Version: 8.4.28

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
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`role_id`, `role_name`) VALUES
(1, 'Case Worker'),
(2, 'Tuition Agency');

-- --------------------------------------------------------

--
-- Dumping data for table `tuition_agencies`
--

INSERT INTO `tuition_agencies` (`tuition_id`, `tuition_name`, `tuition_location`) VALUES
(1, 'North Star Tuition Centre', 'Yishun'),
(2, 'Bright Minds Learning Centre', 'Woodlands'),
(3, 'Aspire Education Hub', 'Sembawang'),
(4, 'Future Scholars Tuition Centre', 'Ang Mo Kio');

-- --------------------------------------------------------

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `role_id`, `full_name`, `email_address`, `phone_number`, `password_hash`) VALUES
(1, 1, 'Michelle Tan', 'michelle.tan@example.com', NULL, '$2y$10$x.mcU3ImtNB9/u3tUHaJqO7nh1Pb1DZm4FmXxweSZ3utAbQEFzRSG'),
(2, 2, 'Daniel Lee', 'daniel.lee@example.com', NULL, '$2y$10$cE8shI4u9/djPLY5RrSJbeLy7JF6.EMdUcBcFYmM45dtkGxsoTnW.'),
(3, 2, 'Priya Nair', 'priya.nair@example.com', NULL, '$2y$10$UZXYPJUTfBcax1al94mi6.LIxF/FX5c1f7D0lXXp56hTOMOMBmko.'),
(4, 2, 'Farah Ahmad', 'farah.ahmad@example.com', NULL, '$2y$10$iILLBpVZo7VfV1UdOWcuDeTAKl383n5Dsz6YEDuQ6meo6flum3x0a');

-- --------------------------------------------------------

--
-- Dumping data for table `students`
--

INSERT INTO `students` (`student_id`, `student_name`, `tuition_id`, `academic_level`) VALUES
(1, 'Aaliyah Tan', 1, 'Primary 3'),
(2, 'Ethan Lim', 2, 'Primary 4'),
(3, 'Nur Aisyah', 3, 'Primary 5'),
(4, 'Jayden Koh', 1, 'Secondary 1'),
(5, 'Sarah Ong', 2, 'Secondary 2');

-- --------------------------------------------------------

--
-- Dumping data for table `users_tuition_agency`
--

INSERT INTO `users_tuition_agency` (`user_id`, `tuition_id`) VALUES
(2, 1),
(3, 2),
(4, 3);

-- --------------------------------------------------------

--
-- Dumping data for table `class_sessions`
--

INSERT INTO `class_sessions` (`session_id`, `student_id`, `tuition_id`, `class_name`, `session_datetime`, `location`, `class_status`) VALUES
(1, 1, 1, 'Primary 3 Mathematics', '2026-11-02 15:00:00', 'Yishun', 'Completed'),
(2, 2, 2, 'Primary 4 English', '2026-11-03 16:00:00', 'Woodlands', 'Completed'),
(3, 3, 3, 'Primary 5 Science', '2026-11-04 15:30:00', 'Sembawang', 'Completed'),
(4, 4, 1, 'Secondary 1 Mathematics', '2026-11-05 17:00:00', 'Yishun', 'Completed'),
(5, 5, 2, 'Secondary 2 English', '2026-11-06 16:30:00', 'Woodlands', 'Completed'),
(6, 1, 1, 'Primary 3 Mathematics', '2026-11-09 15:00:00', 'Yishun', 'Completed'),
(7, 2, 2, 'Primary 4 English', '2026-11-10 16:00:00', 'Woodlands', 'Completed'),
(8, 3, 3, 'Primary 5 Science', '2026-11-11 15:30:00', 'Sembawang', 'Completed'),
(9, 4, 1, 'Secondary 1 Mathematics', '2026-11-12 17:00:00', 'Yishun', 'Completed'),
(10, 5, 2, 'Secondary 2 English', '2026-11-13 16:30:00', 'Woodlands', 'Completed'),
(11, 1, 1, 'Primary 3 Mathematics', '2026-11-23 15:00:00', 'Yishun', 'Scheduled'),
(12, 2, 2, 'Primary 4 English', '2026-11-24 16:00:00', 'Woodlands', 'Scheduled'),
(13, 3, 3, 'Primary 5 Science', '2026-11-25 15:30:00', 'Sembawang', 'Scheduled'),
(14, 4, 1, 'Secondary 1 Mathematics', '2026-11-26 17:00:00', 'Yishun', 'Scheduled'),
(15, 5, 2, 'Secondary 2 English', '2026-11-27 16:30:00', 'Woodlands', 'Scheduled');

-- --------------------------------------------------------

--
-- Dumping data for table `attendance_records`
--

INSERT INTO `attendance_records` (`attendance_id`, `session_id`, `attendance_status`, `submitted_by`, `submitted_at`, `absence_reason`, `reason_updated_at`, `reviewed_at`) VALUES
(1, 1, 'Present', 2, '2026-11-02 16:35:00', NULL, NULL, '2026-11-03 09:00:00'),
(2, 2, 'Absent', 3, '2026-11-03 17:35:00', 'Medical appointment', '2026-11-04 10:15:00', '2026-11-04 11:00:00'),
(3, 3, 'Present', 4, '2026-11-04 17:05:00', NULL, NULL, '2026-11-05 09:30:00'),
(4, 5, 'Absent', 3, '2026-11-06 18:05:00', 'Family emergency', NULL, NULL),
(5, 6, 'Absent', 2, '2026-11-09 16:35:00', 'Unwell', '2026-11-10 08:45:00', '2026-11-10 10:00:00'),
(6, 7, 'Present', 3, '2026-11-10 17:35:00', NULL, NULL, NULL),
(7, 9, 'Present', 2, '2026-11-12 18:35:00', NULL, NULL, '2026-11-13 09:15:00'),
(8, 10, 'Absent', 3, '2026-11-13 18:05:00', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Dumping data for table `communication_logs`
--

INSERT INTO `communication_logs` (`notification_id`, `recipient_user_id`, `session_id`, `attendance_id`, `notification_type`, `notification_status`, `created_at`, `read_at`, `triggered_by_user_id`, `email_status`, `email_sent_at`) VALUES
(1, 1, 2, 2, 'Absence Alert', 'Read', '2026-11-03 17:40:00', '2026-11-04 09:00:00', 3, 'Sent', '2026-11-03 17:41:00'),
(2, 3, 2, 2, 'Reason Update', 'Read', '2026-11-04 10:16:00', '2026-11-04 10:30:00', 1, 'Sent', '2026-11-04 10:17:00'),
(3, 2, 4, NULL, 'Missing Attendance Reminder', 'Unread', '2026-11-06 09:00:00', NULL, 1, 'Sent', '2026-11-06 09:01:00'),
(4, 1, 5, 4, 'Absence Alert', 'Unread', '2026-11-06 18:10:00', NULL, 3, 'Sent', '2026-11-06 18:11:00'),
(5, 1, 6, 5, 'Absence Alert', 'Read', '2026-11-09 16:40:00', '2026-11-10 08:30:00', 2, 'Sent', '2026-11-09 16:41:00'),
(6, 2, 6, 5, 'Reason Update', 'Unread', '2026-11-10 08:50:00', NULL, 1, 'Pending', NULL),
(7, 4, 8, NULL, 'Missing Attendance Reminder', 'Unread', '2026-11-12 09:00:00', NULL, 1, 'Failed', NULL),
(8, 3, 10, 8, 'Absence Reason Reminder', 'Unread', '2026-11-14 09:00:00', NULL, 1, 'Not Sent', NULL);

COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
