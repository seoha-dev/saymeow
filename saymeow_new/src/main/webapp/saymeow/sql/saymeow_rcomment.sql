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

-- 테이블 saymeow.rcomment 구조 내보내기
DROP TABLE IF EXISTS `rcomment`;
CREATE TABLE IF NOT EXISTS `rcomment` (
  `rcNum` int NOT NULL AUTO_INCREMENT,
  `rnum` int DEFAULT NULL,
  `cid` varchar(50) DEFAULT NULL,
  `pnum` int DEFAULT NULL,
  `rcDate` date DEFAULT NULL,
  `comment` text,
  PRIMARY KEY (`rcNum`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 테이블 데이터 saymeow.rcomment:~0 rows (대략적) 내보내기
DELETE FROM `rcomment`;
/*!40000 ALTER TABLE `rcomment` DISABLE KEYS */;
/*!40000 ALTER TABLE `rcomment` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
