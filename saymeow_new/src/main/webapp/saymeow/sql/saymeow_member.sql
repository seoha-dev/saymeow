-- --------------------------------------------------------
-- 호스트:                          127.0.0.1
-- 서버 버전:                        8.0.21 - MySQL Community Server - GPL
-- 서버 OS:                        Win64
-- HeidiSQL 버전:                  11.3.0.6295
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- 테이블 saymeow.member 구조 내보내기
DROP TABLE IF EXISTS `member`;
CREATE TABLE IF NOT EXISTS `member` (
  `id` varchar(50) NOT NULL,
  `pwd` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  `phone` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `email` varchar(30) DEFAULT NULL,
  `address` varchar(200) DEFAULT NULL,
  `grade` tinyint DEFAULT '0',
  `mode` tinyint DEFAULT '0',
  `petName` varchar(30) DEFAULT NULL,
  `petAge` date DEFAULT NULL,
  `petGender` tinyint DEFAULT NULL,
  `petBreed` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 테이블 데이터 saymeow.member:~22 rows (대략적) 내보내기
DELETE FROM `member`;
/*!40000 ALTER TABLE `member` DISABLE KEYS */;
INSERT INTO `member` (`id`, `pwd`, `name`, `birthday`, `phone`, `email`, `address`, `grade`, `mode`, `petName`, `petAge`, `petGender`, `petBreed`) VALUES
	('aaa', '1234', '사용자1', '2002-09-08', '010-5721-8234', 'urna@icloud.com', '서울', 0, 0, '', '2004-04-22', 0, '코숏\r'),
	('admin', '1234', '관리자', '2022-05-01', '010-1234-5678', 'admin@aaa.aaa', '부산', 0, 1, '', '2004-04-21', 0, '코숏\r'),
	('aij', '1234', '사용자16', '1981-11-12', '010-4517-6374', 'etuer@hotmail.couk', '서울', 0, 0, '', '2014-03-03', 0, '랙돌\r'),
	('bbb', '1234', '사용자2', '1972-12-29', '010-1714-5826', 'mas@google.edu', '경기', 0, 0, '', '2014-06-28', 0, '코숏\r'),
	('bng', '1234', '사용자11', '1996-10-09', '010-4208-3989', 'leifend.nec@hotmail.couk', '경북', 0, 0, '', '2022-04-05', 1, '러블\r'),
	('bzr', '1234', '사용자10', '2006-06-09', '010-7346-4892', 'cursus@aol.couk', '경남', 0, 0, '야옹이', '2018-10-18', 1, '러블'),
	('ccc', '1234', '사용자3', '1969-11-02', '010-4797-1885', 'in.lobortis@hotmail.com', '인천', 0, 0, '', '2017-03-22', 0, '코숏\r'),
	('che', '1234', '사용자4', '1979-12-15', '010-5328-0508', 'mauris.ut.mi@aol.org', '부산', 0, 0, '', '2009-05-09', 0, '샴\r'),
	('cyg', '1234', '사용자7', '2010-10-11', '010-6357-6830', 'felis@google.edu', '경기', 0, 0, '', '2010-04-06', 1, '뱅갈\r'),
	('dog', '1234', '사용자18', '2018-09-06', '010-4281-3862', 'nam@aol.edu', '인천', 0, 0, '', '2007-08-13', 1, '아메숏\r'),
	('gix', '1234', '사용자6', '2014-10-17', '010-8719-2518', 'sapien.cursus@icloud.com', '서울', 0, 0, '', '2011-09-01', 1, '아메숏\r'),
	('jqy', '1234', '사용자5', '2003-11-12', '010-9161-9608', 'metus@aol.couk', '부산', 0, 0, '', '2023-04-19', 0, '샴\r'),
	('len', '1234', '사용자15', '2009-01-19', '010-8250-1802', 'nullam@google.couk', '서울', 0, 0, '', '2009-12-11', 1, '터키쉬\r'),
	('may', '1234', '사용자14', '2005-09-24', '010-3855-4589', 'integer.aliquam.adipiscing@aol', '부산', 0, 0, '', '2013-05-10', 1, '터키쉬\r'),
	('mkp', '1234', '사용자17', '1967-03-03', '010-7018-6925', 'donec@google.org', '인천', 0, 0, '', '2000-11-08', 0, '코숏\r'),
	('nib', '1234', '사용자20', '1979-12-30', '010-8455-2383', 'fringilla.ornare@aol.com', '강원도', 0, 0, '', '2020-11-11', 0, '아메숏\r'),
	('rny', '1234', '사용자8', '1995-12-03', '010-4550-5139', 'ante@aol.edu', '인천', 0, 0, '', '2014-02-05', 1, '뱅갈\r'),
	('sqe', '1234', '사용자13', '2008-04-16', '010-7265-7171', 'in@aol.edu', '충남', 0, 0, '', '2020-04-18', 1, '샴\r'),
	('tgx', '1234', '사용자9', '1971-06-23', '010-7576-3154', 'vestibulum.neque@icloud.org', '제주도', 0, 0, '', '2007-04-22', 1, '러블\r'),
	('tty', '1234', '사용자19', '1991-10-23', '010-8515-7344', 'et@hotmail.ca', '부산', 0, 0, '', '2006-09-23', 1, '아메숏\r'),
	('ucn', '1234', '사용자21', '1998-02-22', '010-1231-1111', 'ex@gmail.com', '대구', 0, 0, '', '2019-09-11', 0, '페르시안'),
	('vlk', '1234', '사용자12', '2021-05-30', '010-1557-4058', 'purus@icloud.edu', '충북', 0, 0, '', '2017-09-10', 1, '코숏\r');
/*!40000 ALTER TABLE `member` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
