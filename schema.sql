-- MySQL dump 10.13  Distrib 8.0.43, for Win64 (x86_64)
--
-- Host: localhost    Database: cricket_scoreboard_oop
-- ------------------------------------------------------
-- Server version	8.0.43

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `admin`
--

DROP TABLE IF EXISTS `admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin` (
  `AdminId` int NOT NULL AUTO_INCREMENT,
  `Username` varchar(50) DEFAULT NULL,
  `Password` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`AdminId`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin`
--

LOCK TABLES `admin` WRITE;
/*!40000 ALTER TABLE `admin` DISABLE KEYS */;
INSERT INTO `admin` VALUES (1,'admin','12345');
/*!40000 ALTER TABLE `admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ballevent`
--

DROP TABLE IF EXISTS `ballevent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ballevent` (
  `BallId` int NOT NULL AUTO_INCREMENT,
  `InningsId` int NOT NULL,
  `OverNumber` int NOT NULL,
  `BallInOver` int NOT NULL,
  `SequenceInInnings` int NOT NULL,
  `BatsmanId` int NOT NULL,
  `NonStrikerId` int DEFAULT NULL,
  `BowlerId` int NOT NULL,
  `RunsOffBat` int NOT NULL DEFAULT '0',
  `Extras` int NOT NULL DEFAULT '0',
  `ExtraType` enum('NONE','WIDE','NOBALL','BYE','LEGBYE','PENALTY') NOT NULL DEFAULT 'NONE',
  `IsWicket` tinyint(1) NOT NULL DEFAULT '0',
  `DismissalType` enum('NONE','BOWLED','CAUGHT','RUN_OUT','LBW','STUMPED','HIT_WKT','OTHER') NOT NULL DEFAULT 'NONE',
  `DismissedPlayerId` int DEFAULT NULL,
  `IsLegalDelivery` tinyint(1) NOT NULL DEFAULT '1',
  `Commentary` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`BallId`),
  KEY `FK_Ball_Batsman` (`BatsmanId`),
  KEY `FK_Ball_NonStriker` (`NonStrikerId`),
  KEY `FK_Ball_Bowler` (`BowlerId`),
  KEY `FK_Ball_Dismissed` (`DismissedPlayerId`),
  KEY `IX_Ball_Innings` (`InningsId`,`SequenceInInnings`),
  CONSTRAINT `FK_Ball_Batsman` FOREIGN KEY (`BatsmanId`) REFERENCES `player` (`PlayerId`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `FK_Ball_Bowler` FOREIGN KEY (`BowlerId`) REFERENCES `player` (`PlayerId`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `FK_Ball_Dismissed` FOREIGN KEY (`DismissedPlayerId`) REFERENCES `player` (`PlayerId`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_Ball_Innings` FOREIGN KEY (`InningsId`) REFERENCES `matchinnings` (`InningsId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_Ball_NonStriker` FOREIGN KEY (`NonStrikerId`) REFERENCES `player` (`PlayerId`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ballevent`
--

LOCK TABLES `ballevent` WRITE;
/*!40000 ALTER TABLE `ballevent` DISABLE KEYS */;
/*!40000 ALTER TABLE `ballevent` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `battingcard`
--

DROP TABLE IF EXISTS `battingcard`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `battingcard` (
  `BattingId` int NOT NULL AUTO_INCREMENT,
  `InningsId` int NOT NULL,
  `PlayerId` int NOT NULL,
  `BattingPosition` int DEFAULT NULL,
  `Runs` int NOT NULL DEFAULT '0',
  `Balls` int NOT NULL DEFAULT '0',
  `Fours` int NOT NULL DEFAULT '0',
  `Sixes` int NOT NULL DEFAULT '0',
  `StrikeRate` decimal(6,2) DEFAULT NULL,
  `DismissalType` enum('NOT_OUT','BOWLED','CAUGHT','RUN_OUT','LBW','STUMPED','HIT_WKT','RETIRED_HURT','OTHER') NOT NULL DEFAULT 'NOT_OUT',
  `DismissalText` varchar(255) DEFAULT NULL,
  `BowlerId` int DEFAULT NULL,
  `FielderId` int DEFAULT NULL,
  PRIMARY KEY (`BattingId`),
  KEY `FK_Batting_Player` (`PlayerId`),
  KEY `FK_Batting_Bowler` (`BowlerId`),
  KEY `FK_Batting_Fielder` (`FielderId`),
  KEY `IX_Batting_Innings` (`InningsId`),
  CONSTRAINT `FK_Batting_Bowler` FOREIGN KEY (`BowlerId`) REFERENCES `player` (`PlayerId`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_Batting_Fielder` FOREIGN KEY (`FielderId`) REFERENCES `player` (`PlayerId`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_Batting_Innings` FOREIGN KEY (`InningsId`) REFERENCES `matchinnings` (`InningsId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_Batting_Player` FOREIGN KEY (`PlayerId`) REFERENCES `player` (`PlayerId`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `battingcard`
--

LOCK TABLES `battingcard` WRITE;
/*!40000 ALTER TABLE `battingcard` DISABLE KEYS */;
/*!40000 ALTER TABLE `battingcard` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bowlingcard`
--

DROP TABLE IF EXISTS `bowlingcard`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bowlingcard` (
  `BowlingId` int NOT NULL AUTO_INCREMENT,
  `InningsId` int NOT NULL,
  `PlayerId` int NOT NULL,
  `Overs` decimal(4,1) NOT NULL DEFAULT '0.0',
  `Maidens` int NOT NULL DEFAULT '0',
  `RunsConceded` int NOT NULL DEFAULT '0',
  `Wickets` int NOT NULL DEFAULT '0',
  `Economy` decimal(5,2) DEFAULT NULL,
  `Wides` int NOT NULL DEFAULT '0',
  `NoBalls` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`BowlingId`),
  KEY `FK_Bowling_Player` (`PlayerId`),
  KEY `IX_Bowling_Innings` (`InningsId`),
  CONSTRAINT `FK_Bowling_Innings` FOREIGN KEY (`InningsId`) REFERENCES `matchinnings` (`InningsId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_Bowling_Player` FOREIGN KEY (`PlayerId`) REFERENCES `player` (`PlayerId`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bowlingcard`
--

LOCK TABLES `bowlingcard` WRITE;
/*!40000 ALTER TABLE `bowlingcard` DISABLE KEYS */;
/*!40000 ALTER TABLE `bowlingcard` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fallofwicket`
--

DROP TABLE IF EXISTS `fallofwicket`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fallofwicket` (
  `FallId` int NOT NULL AUTO_INCREMENT,
  `InningsId` int NOT NULL,
  `WicketNumber` int NOT NULL,
  `RunsAtFall` int NOT NULL,
  `OverText` varchar(10) DEFAULT NULL,
  `PlayerId` int DEFAULT NULL,
  PRIMARY KEY (`FallId`),
  KEY `FK_Fall_Player` (`PlayerId`),
  KEY `IX_Fall_Innings` (`InningsId`),
  CONSTRAINT `FK_Fall_Innings` FOREIGN KEY (`InningsId`) REFERENCES `matchinnings` (`InningsId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_Fall_Player` FOREIGN KEY (`PlayerId`) REFERENCES `player` (`PlayerId`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fallofwicket`
--

LOCK TABLES `fallofwicket` WRITE;
/*!40000 ALTER TABLE `fallofwicket` DISABLE KEYS */;
/*!40000 ALTER TABLE `fallofwicket` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `match`
--

DROP TABLE IF EXISTS `match`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `match` (
  `MatchId` int NOT NULL AUTO_INCREMENT,
  `TournamentId` int DEFAULT NULL,
  `MatchDateTime` datetime DEFAULT NULL,
  `Venue` varchar(120) DEFAULT NULL,
  `Format` enum('T20','ODI','TEST') NOT NULL DEFAULT 'T20',
  `Status` enum('SCHEDULED','LIVE','COMPLETED','ABANDONED') NOT NULL DEFAULT 'SCHEDULED',
  `TeamAId` int NOT NULL,
  `TeamBId` int NOT NULL,
  `TossWinnerTeamId` int DEFAULT NULL,
  `TossDecision` enum('BAT','BOWL') DEFAULT NULL,
  `OversPerSide` int DEFAULT '20',
  `BallsPerOver` int DEFAULT '6',
  `ResultType` enum('NORMAL','TIE','NO_RESULT') DEFAULT 'NORMAL',
  `WinnerTeamId` int DEFAULT NULL,
  `ResultText` varchar(255) DEFAULT NULL,
  `ManOfTheMatchId` int DEFAULT NULL,
  `CreatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`MatchId`),
  KEY `FK_Match_TeamB` (`TeamBId`),
  KEY `FK_Match_TossWinner` (`TossWinnerTeamId`),
  KEY `FK_Match_Winner` (`WinnerTeamId`),
  KEY `FK_Match_ManOfMatch` (`ManOfTheMatchId`),
  KEY `IX_Match_Tournament` (`TournamentId`),
  KEY `IX_Match_Teams` (`TeamAId`,`TeamBId`),
  CONSTRAINT `FK_Match_ManOfMatch` FOREIGN KEY (`ManOfTheMatchId`) REFERENCES `player` (`PlayerId`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_Match_TeamA` FOREIGN KEY (`TeamAId`) REFERENCES `team` (`TeamId`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `FK_Match_TeamB` FOREIGN KEY (`TeamBId`) REFERENCES `team` (`TeamId`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `FK_Match_TossWinner` FOREIGN KEY (`TossWinnerTeamId`) REFERENCES `team` (`TeamId`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_Match_Winner` FOREIGN KEY (`WinnerTeamId`) REFERENCES `team` (`TeamId`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `match`
--

LOCK TABLES `match` WRITE;
/*!40000 ALTER TABLE `match` DISABLE KEYS */;
/*!40000 ALTER TABLE `match` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `match_batsman`
--

DROP TABLE IF EXISTS `match_batsman`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `match_batsman` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `MatchId` int NOT NULL,
  `TeamName` varchar(100) NOT NULL,
  `PlayerName` varchar(100) NOT NULL,
  `Runs` int NOT NULL,
  `Balls` int NOT NULL,
  `Fours` int NOT NULL,
  `Sixes` int NOT NULL,
  `Dismissal` varchar(255) DEFAULT NULL,
  `InningsNo` int NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `fk_mb_match` (`MatchId`),
  CONSTRAINT `fk_mb_match` FOREIGN KEY (`MatchId`) REFERENCES `matches` (`MatchID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=70 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `match_batsman`
--

LOCK TABLES `match_batsman` WRITE;
/*!40000 ALTER TABLE `match_batsman` DISABLE KEYS */;
INSERT INTO `match_batsman` VALUES (1,1,'India','Rohit Sharma',10,7,1,0,'Bowled by Haris Rauf',1),(2,1,'India','Virat Kohli',16,6,1,1,'Bowled by Haris Rauf',1),(3,1,'India','Shubman Gill',5,3,1,0,'Bowled by Haris Rauf',1),(4,1,'India','Shreyas Iyer',11,4,1,1,'Bowled by Haris Rauf',1),(5,1,'India','Suryakumar Yadav',14,6,1,1,'Bowled by Shaheen Afridi',1),(6,1,'India','Hardik Pandya',29,9,0,3,'Bowled by Naseem Shah',1),(7,1,'India','Ravindra Jadeja',24,8,1,2,'Bowled by Shaheen Afridi',1),(8,1,'India','Rishabh Pant',19,12,2,0,'Bowled by Shadab Khan',1),(9,1,'India','Jasprit Bumrah',46,21,3,1,'Bowled by Naseem Shah',1),(10,1,'India','Kuldeep Yadav',4,2,1,0,'Bowled by Shadab Khan',1),(11,1,'India','Mohammed Shami',1,1,0,0,'',1),(12,1,'Pakistan','Babar Azam',15,9,1,0,'Bowled by Kuldeep Yadav',2),(13,1,'Pakistan','Mohammad Rizwan',27,11,1,2,'Bowled by Kuldeep Yadav',2),(14,1,'Pakistan','Abdullah Shafique',10,5,1,0,'Bowled by Kuldeep Yadav',2),(15,1,'Pakistan','Fakhar Zaman',10,5,2,0,'Bowled by Jasprit Bumrah',2),(16,1,'Pakistan','Imam-ul-Haq',49,30,3,2,'Bowled by Hardik Pandya',2),(17,1,'Pakistan','Shadab Khan',48,32,0,3,'Bowled by Hardik Pandya',2),(18,1,'Pakistan','Agha Salman',18,6,1,1,'',2),(19,1,'Pakistan','Mohammad Nawaz',2,6,0,0,'',2),(20,2,'Australia','David Warner',17,7,0,1,'Bowled by Mark Wood',1),(21,2,'Australia','Steve Smith',1,2,0,0,'Bowled by Jofra Archer',1),(22,2,'Australia','Marnus Labuschagne',5,3,1,0,'Bowled by Jofra Archer',1),(23,2,'Australia','Travis Head',6,4,0,0,'Bowled by Mark Wood',1),(24,2,'Australia','Glenn Maxwell',3,3,0,0,'Bowled by Jofra Archer',1),(25,2,'Australia','Marcus Stoinis',10,6,0,0,'Bowled by Mark Wood',1),(26,2,'Australia','Mitchell Marsh',37,13,6,0,'Bowled by Mark Wood',1),(27,2,'Australia','Mitchell Starc',18,4,0,3,'Bowled by Jofra Archer',1),(28,2,'Australia','Pat Cummins',1,2,0,0,'Bowled by Mark Wood',1),(29,2,'Australia','Adam Zampa',2,3,0,0,'Bowled by Adil Rashid',1),(30,2,'Australia','Josh Hazlewood',12,2,0,2,'',1),(31,2,'England','Jos Buttler',14,9,1,1,'Bowled by Mitchell Starc',2),(32,2,'England','Jonny Bairstow',47,26,6,0,'',2),(33,2,'England','Joe Root',18,7,0,2,'Bowled by Pat Cummins',2),(34,2,'England','Dawid Malan',26,7,1,3,'Bowled by Adam Zampa',2),(35,2,'England','Harry Brook',2,3,0,0,'Bowled by Pat Cummins',2),(36,2,'England','Ben Stokes',6,1,0,1,'',2),(37,3,'South Africa','Aiden Markram',6,2,0,1,'Bowled by Trent Boult',1),(38,3,'South Africa','Reeza Hendricks',11,6,2,0,'Bowled by Trent Boult',1),(39,3,'South Africa','Rassie van der Dussen',38,13,2,2,'Bowled by Lockie Ferguson',1),(40,3,'South Africa','David Miller',1,2,0,0,'Bowled by Trent Boult',1),(41,3,'South Africa','Marco Jansen',5,3,1,0,'Bowled by Trent Boult',1),(42,3,'South Africa','Aiden Markram',0,1,0,0,'Bowled by Trent Boult',1),(43,3,'South Africa','Heinrich Klaasen',16,5,2,1,'Bowled by Trent Boult',1),(44,3,'South Africa','Quinton de Kock',9,4,0,1,'Bowled by Tim Southee',1),(45,3,'South Africa','Kagiso Rabada',1,2,0,0,'Bowled by Tim Southee',1),(46,3,'South Africa','Anrich Nortje',4,2,1,0,'Bowled by Lockie Ferguson',1),(47,3,'South Africa','Tabraiz Shamsi',18,3,0,3,'',1),(48,3,'New Zealand','Kane Williamson',13,5,1,1,'Bowled by Kagiso Rabada',2),(49,3,'New Zealand','Devon Conway',27,12,2,0,'Bowled by Kagiso Rabada',2),(50,3,'New Zealand','Finn Allen',45,20,2,4,'',2),(51,3,'New Zealand','Daryl Mitchell',10,3,1,1,'Bowled by Anrich Nortje',2),(52,3,'New Zealand','Lockie Ferguson',19,4,1,2,'',2),(53,4,'Zimbabwe','Craig Ervine',11,4,1,1,'Bowled by Alzarri Joseph',1),(54,4,'Zimbabwe','Sean Williams',3,2,0,0,'Bowled by Akeal Hosein',1),(55,4,'Zimbabwe','Wesley Madhevere',27,12,4,0,'Bowled by Akeal Hosein',1),(56,4,'Zimbabwe','Innocent Kaia',20,6,1,2,'Bowled by Alzarri Joseph',1),(57,4,'Zimbabwe','Sikandar Raza',4,3,0,0,'Bowled by Akeal Hosein',1),(58,4,'Zimbabwe','Ryan Burl',8,4,1,0,'Run out',1),(59,4,'Zimbabwe','Milton Shumba',5,4,0,0,'Bowled by Alzarri Joseph',1),(60,4,'Zimbabwe','Richard Ngarava',32,9,2,3,'Bowled by Akeal Hosein',1),(61,4,'Zimbabwe','Blessing Muzarabani',79,48,5,3,'',1),(62,4,'Zimbabwe','Brad Evans',51,28,1,3,'',1),(63,4,'West Indies','Nicholas Pooran',21,9,2,1,'Bowled by Blessing Muzarabani',2),(64,4,'West Indies','Shai Hope',34,22,4,0,'Bowled by Richard Ngarava',2),(65,4,'West Indies','Brandon King',26,18,2,0,'Bowled by Brad Evans',2),(66,4,'West Indies','Shimron Hetmyer',10,9,1,0,'Bowled by Tendai Chatara',2),(67,4,'West Indies','Jason Holder',23,11,2,1,'Bowled by Tendai Chatara',2),(68,4,'West Indies','Rovman Powell',27,22,2,1,'',2),(69,4,'West Indies','Kyle Mayers',58,29,3,4,'',2);
/*!40000 ALTER TABLE `match_batsman` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `match_batting`
--

DROP TABLE IF EXISTS `match_batting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `match_batting` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `MatchID` int DEFAULT NULL,
  `Team` varchar(50) DEFAULT NULL,
  `Name` varchar(100) DEFAULT NULL,
  `Runs` int DEFAULT NULL,
  `Balls` int DEFAULT NULL,
  `Fours` int DEFAULT NULL,
  `Sixes` int DEFAULT NULL,
  `StrikeRate` float DEFAULT NULL,
  `Dismissal` varchar(200) DEFAULT NULL,
  `InningsNo` int DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `MatchID` (`MatchID`),
  CONSTRAINT `match_batting_ibfk_1` FOREIGN KEY (`MatchID`) REFERENCES `matches` (`MatchID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `match_batting`
--

LOCK TABLES `match_batting` WRITE;
/*!40000 ALTER TABLE `match_batting` DISABLE KEYS */;
/*!40000 ALTER TABLE `match_batting` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `match_bowler`
--

DROP TABLE IF EXISTS `match_bowler`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `match_bowler` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `MatchId` int NOT NULL,
  `TeamName` varchar(100) NOT NULL,
  `PlayerName` varchar(100) NOT NULL,
  `Overs` decimal(4,1) NOT NULL,
  `Runs` int NOT NULL,
  `Wickets` int NOT NULL,
  `Economy` double DEFAULT NULL,
  `InningsNo` int NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `fk_mbw_match` (`MatchId`),
  CONSTRAINT `fk_mbw_match` FOREIGN KEY (`MatchId`) REFERENCES `matches` (`MatchID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `match_bowler`
--

LOCK TABLES `match_bowler` WRITE;
/*!40000 ALTER TABLE `match_bowler` DISABLE KEYS */;
INSERT INTO `match_bowler` VALUES (1,1,'Pakistan','Jasprit Bumrah',4.0,60,1,15,1),(2,1,'Pakistan','Kuldeep Yadav',4.0,54,3,13.5,1),(3,1,'Pakistan','Mohammed Shami',4.0,29,0,7.25,1),(4,1,'Pakistan','Hardik Pandya',4.0,27,2,6.75,1),(5,1,'Pakistan','Ravindra Jadeja',1.0,2,0,2,1),(6,1,'Pakistan','Rishabh Pant',0.3,8,0,24,1),(7,1,'India','Shaheen Afridi',4.0,63,2,15.75,2),(8,1,'India','Haris Rauf',4.0,62,4,15.5,2),(9,1,'India','Naseem Shah',3.2,36,2,11.368421,2),(10,1,'India','Shadab Khan',2.0,18,2,9,2),(11,2,'England','Mitchell Starc',4.0,61,1,15.25,1),(12,2,'England','Pat Cummins',3.8,41,2,10.695652,1),(13,2,'England','Adam Zampa',1.0,11,1,11,1),(14,2,'Australia','Jofra Archer',4.0,52,4,13,2),(15,2,'Australia','Mark Wood',3.2,40,5,12.631578,2),(16,2,'Australia','Adil Rashid',1.0,20,1,20,2),(17,3,'New Zealand','Kagiso Rabada',4.0,67,2,16.75,1),(18,3,'New Zealand','Anrich Nortje',3.0,43,1,14.333333,1),(19,3,'New Zealand','Tabraiz Shamsi',0.3,4,0,12,1),(20,3,'South Africa','Trent Boult',4.0,61,6,15.25,2),(21,3,'South Africa','Tim Southee',2.2,28,2,12.923077,2),(22,3,'South Africa','Lockie Ferguson',1.0,22,2,22,2),(23,4,'West Indies','Richard Ngarava',4.0,38,1,9.5,1),(24,4,'West Indies','Blessing Muzarabani',4.0,43,1,10.75,1),(25,4,'West Indies','Brad Evans',4.0,37,1,9.25,1),(26,4,'West Indies','Tendai Chatara',4.0,26,2,6.5,1),(27,4,'West Indies','Sikandar Raza',2.0,16,0,8,1),(28,4,'West Indies','Ryan Burl',2.0,39,0,19.5,1),(29,4,'Zimbabwe','Alzarri Joseph',4.0,53,3,13.25,2),(30,4,'Zimbabwe','Akeal Hosein',4.0,72,4,18,2),(31,4,'Zimbabwe','Oshane Thomas',4.0,66,0,16.5,2),(32,4,'Zimbabwe','Jason Holder',4.0,31,0,7.75,2),(33,4,'Zimbabwe','Rovman Powell',2.0,12,0,6,2),(34,4,'Zimbabwe','Kyle Mayers',2.0,6,0,3,2);
/*!40000 ALTER TABLE `match_bowler` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `match_bowling`
--

DROP TABLE IF EXISTS `match_bowling`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `match_bowling` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `MatchID` int DEFAULT NULL,
  `Team` varchar(50) DEFAULT NULL,
  `Name` varchar(100) DEFAULT NULL,
  `Overs` float DEFAULT NULL,
  `RunsGiven` int DEFAULT NULL,
  `Wickets` int DEFAULT NULL,
  `Economy` float DEFAULT NULL,
  `InningsNo` int DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `MatchID` (`MatchID`),
  CONSTRAINT `match_bowling_ibfk_1` FOREIGN KEY (`MatchID`) REFERENCES `matches` (`MatchID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `match_bowling`
--

LOCK TABLES `match_bowling` WRITE;
/*!40000 ALTER TABLE `match_bowling` DISABLE KEYS */;
/*!40000 ALTER TABLE `match_bowling` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `match_innings_batting`
--

DROP TABLE IF EXISTS `match_innings_batting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `match_innings_batting` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `MatchID` int NOT NULL,
  `InningsNo` int NOT NULL DEFAULT '1',
  `TeamName` varchar(100) NOT NULL,
  `PlayerName` varchar(100) NOT NULL,
  `Runs` int NOT NULL,
  `Balls` int NOT NULL,
  `Fours` int NOT NULL,
  `Sixes` int NOT NULL,
  `StrikeRate` decimal(6,2) DEFAULT NULL,
  `Dismissal` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_mib_match` (`MatchID`),
  CONSTRAINT `fk_mib_match` FOREIGN KEY (`MatchID`) REFERENCES `matches` (`MatchID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `match_innings_batting`
--

LOCK TABLES `match_innings_batting` WRITE;
/*!40000 ALTER TABLE `match_innings_batting` DISABLE KEYS */;
/*!40000 ALTER TABLE `match_innings_batting` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `match_innings_bowling`
--

DROP TABLE IF EXISTS `match_innings_bowling`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `match_innings_bowling` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `MatchID` int NOT NULL,
  `InningsNo` int NOT NULL DEFAULT '1',
  `TeamName` varchar(100) NOT NULL,
  `PlayerName` varchar(100) NOT NULL,
  `Overs` decimal(4,1) NOT NULL,
  `Runs` int NOT NULL,
  `Wickets` int NOT NULL,
  `Economy` decimal(5,2) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_mibo_match` (`MatchID`),
  CONSTRAINT `fk_mibo_match` FOREIGN KEY (`MatchID`) REFERENCES `matches` (`MatchID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `match_innings_bowling`
--

LOCK TABLES `match_innings_bowling` WRITE;
/*!40000 ALTER TABLE `match_innings_bowling` DISABLE KEYS */;
/*!40000 ALTER TABLE `match_innings_bowling` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `matches`
--

DROP TABLE IF EXISTS `matches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `matches` (
  `MatchID` int NOT NULL AUTO_INCREMENT,
  `TeamAName` varchar(100) NOT NULL,
  `TeamBName` varchar(100) NOT NULL,
  `ScoreA` varchar(50) NOT NULL,
  `ScoreB` varchar(50) NOT NULL,
  `ResultText` varchar(255) NOT NULL,
  `MatchDate` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`MatchID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `matches`
--

LOCK TABLES `matches` WRITE;
/*!40000 ALTER TABLE `matches` DISABLE KEYS */;
INSERT INTO `matches` VALUES (1,'India','Pakistan','179/10','180/6','Pakistan won by 4 wickets','2026-03-05 23:30:17'),(2,'Australia','England','112/10','113/4','England won by 6 wickets','2026-03-05 23:35:07'),(3,'South Africa','New Zealand','111/10','114/3','New Zealand won by 7 wickets','2026-03-05 23:42:55'),(4,'Zimbabwe','West Indies','240/8','199/5','Zimbabwe won by 41 runs','2026-03-05 23:48:06');
/*!40000 ALTER TABLE `matches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `matchinnings`
--

DROP TABLE IF EXISTS `matchinnings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `matchinnings` (
  `InningsId` int NOT NULL AUTO_INCREMENT,
  `MatchId` int NOT NULL,
  `InningsNumber` int NOT NULL,
  `BattingTeamId` int NOT NULL,
  `BowlingTeamId` int NOT NULL,
  `Runs` int NOT NULL DEFAULT '0',
  `Wickets` int NOT NULL DEFAULT '0',
  `Balls` int NOT NULL DEFAULT '0',
  `OversText` varchar(10) DEFAULT NULL,
  `ExtrasTotal` int NOT NULL DEFAULT '0',
  `Byes` int NOT NULL DEFAULT '0',
  `LegByes` int NOT NULL DEFAULT '0',
  `Wides` int NOT NULL DEFAULT '0',
  `NoBalls` int NOT NULL DEFAULT '0',
  `PenaltyRuns` int NOT NULL DEFAULT '0',
  `Target` int DEFAULT NULL,
  PRIMARY KEY (`InningsId`),
  KEY `FK_Innings_BattingTeam` (`BattingTeamId`),
  KEY `FK_Innings_BowlingTeam` (`BowlingTeamId`),
  KEY `IX_Innings_Match` (`MatchId`),
  CONSTRAINT `FK_Innings_BattingTeam` FOREIGN KEY (`BattingTeamId`) REFERENCES `team` (`TeamId`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `FK_Innings_BowlingTeam` FOREIGN KEY (`BowlingTeamId`) REFERENCES `team` (`TeamId`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `FK_Innings_Match` FOREIGN KEY (`MatchId`) REFERENCES `match` (`MatchId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `matchinnings`
--

LOCK TABLES `matchinnings` WRITE;
/*!40000 ALTER TABLE `matchinnings` DISABLE KEYS */;
/*!40000 ALTER TABLE `matchinnings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `player`
--

DROP TABLE IF EXISTS `player`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `player` (
  `PlayerId` int NOT NULL AUTO_INCREMENT,
  `TeamId` int NOT NULL,
  `FullName` varchar(100) NOT NULL,
  `Role` enum('BAT','BOWL','AR','WK') NOT NULL DEFAULT 'BAT',
  `BattingStyle` varchar(50) DEFAULT NULL,
  `BowlingStyle` varchar(50) DEFAULT NULL,
  `DateOfBirth` date DEFAULT NULL,
  `IsActive` tinyint(1) NOT NULL DEFAULT '1',
  `CreatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`PlayerId`),
  KEY `FK_Player_Team` (`TeamId`),
  CONSTRAINT `FK_Player_Team` FOREIGN KEY (`TeamId`) REFERENCES `team` (`TeamId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=148 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `player`
--

LOCK TABLES `player` WRITE;
/*!40000 ALTER TABLE `player` DISABLE KEYS */;
INSERT INTO `player` VALUES (1,1,'Rohit Sharma','BAT',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(2,1,'Virat Kohli','BAT',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(3,1,'Shubman Gill','BAT',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(4,1,'Jasprit Bumrah','BOWL',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(5,1,'Kuldeep Yadav','BOWL',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(6,1,'Hardik Pandya','AR',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(7,1,'Ravindra Jadeja','AR',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(8,2,'Babar Azam','BAT',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(9,2,'Mohammad Rizwan','BAT',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(10,2,'Abdullah Shafique','BAT',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(11,2,'Shaheen Afridi','BOWL',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(12,2,'Haris Rauf','BOWL',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(13,2,'Shadab Khan','AR',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(14,2,'Agha Salman','AR',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(15,3,'David Warner','BAT',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(16,3,'Steve Smith','BAT',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(17,3,'Marnus Labuschagne','BAT',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(18,3,'Mitchell Starc','BOWL',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(19,3,'Pat Cummins','BOWL',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(20,3,'Glenn Maxwell','AR',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(21,3,'Marcus Stoinis','AR',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(22,4,'Jos Buttler','BAT',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(23,4,'Jonny Bairstow','BAT',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(24,4,'Joe Root','BAT',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(25,4,'Jofra Archer','BOWL',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(26,4,'Mark Wood','BOWL',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(27,4,'Ben Stokes','AR',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(28,4,'Moeen Ali','AR',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(29,6,'Kane Williamson','BAT',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(30,6,'Devon Conway','BAT',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(31,6,'Finn Allen','BAT',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(32,6,'Trent Boult','BOWL',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(33,6,'Tim Southee','BOWL',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(34,6,'Daryl Mitchell','AR',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(35,6,'Mitchell Santner','AR',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(36,5,'Aiden Markram','BAT',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(37,5,'Reeza Hendricks','BAT',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(38,5,'Rassie van der Dussen','BAT',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(39,5,'Kagiso Rabada','BOWL',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(40,5,'Anrich Nortje','BOWL',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(41,5,'Marco Jansen','AR',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(42,5,'Aiden Markram','AR',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(43,8,'Litton Das','BAT',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(44,8,'Najmul Hossain Shanto','BAT',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(45,8,'Shakib Al Hasan','AR',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(46,8,'Taskin Ahmed','BOWL',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(47,8,'Mustafizur Rahman','BOWL',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(48,8,'Mahmudullah','AR',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(49,8,'Mehidy Hasan','AR',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(50,7,'Kusal Mendis','BAT',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(51,7,'Pathum Nissanka','BAT',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(52,7,'Charith Asalanka','BAT',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(53,7,'Maheesh Theekshana','BOWL',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(54,7,'Dilshan Madushanka','BOWL',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(55,7,'Wanindu Hasaranga','AR',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(56,7,'Angelo Mathews','AR',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(57,9,'Nicholas Pooran','BAT',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(58,9,'Shai Hope','BAT',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(59,9,'Brandon King','BAT',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(60,9,'Alzarri Joseph','BOWL',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(61,9,'Akeal Hosein','BOWL',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(62,9,'Jason Holder','AR',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(63,9,'Rovman Powell','AR',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(64,10,'Craig Ervine','BAT',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(65,10,'Sean Williams','BAT',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(66,10,'Wesley Madhevere','BAT',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(67,10,'Richard Ngarava','BOWL',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(68,10,'Blessing Muzarabani','BOWL',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(69,10,'Sikandar Raza','AR',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(70,10,'Ryan Burl','AR',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(71,11,'Rahmanullah Gurbaz','BAT',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(72,11,'Ibrahim Zadran','BAT',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(73,11,'Hashmatullah Shahidi','BAT',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(74,11,'Rashid Khan','BOWL',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(75,11,'Naveen-ul-Haq','BOWL',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(76,11,'Mohammad Nabi','AR',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(77,11,'Azmatullah Omarzai','AR',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(78,12,'Andrew Balbirnie','BAT',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(79,12,'Paul Stirling','BAT',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(80,12,'Harry Tector','BAT',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(81,12,'Mark Adair','BOWL',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(82,12,'Josh Little','BOWL',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(83,12,'Curtis Campher','AR',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(84,12,'George Dockrell','AR',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(85,1,'Mohammed Shami','BOWL',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(86,1,'Rishabh Pant','AR',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(87,1,'Shreyas Iyer','BAT',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(88,1,'Suryakumar Yadav','BAT',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(89,2,'Fakhar Zaman','BAT',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(90,2,'Imam-ul-Haq','BAT',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(91,2,'Mohammad Nawaz','AR',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(92,2,'Naseem Shah','BOWL',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(93,3,'Adam Zampa','BOWL',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(94,3,'Josh Hazlewood','BOWL',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(95,3,'Mitchell Marsh','AR',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(96,3,'Travis Head','BAT',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(97,4,'Adil Rashid','BOWL',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(98,4,'Chris Woakes','AR',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(99,4,'Dawid Malan','BAT',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(100,4,'Harry Brook','BAT',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(101,5,'David Miller','BAT',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(102,5,'Heinrich Klaasen','AR',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(103,5,'Quinton de Kock','AR',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(104,5,'Tabraiz Shamsi','BOWL',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(105,6,'Glenn Phillips','AR',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(106,6,'Jimmy Neesham','AR',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(107,6,'Lockie Ferguson','BOWL',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(108,6,'Tom Latham','AR',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(109,7,'Dhananjaya de Silva','AR',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(110,7,'Kasun Rajitha','BOWL',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(111,7,'Lahiru Kumara','BOWL',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(112,7,'Sadeera Samarawickrama','BAT',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(113,8,'Hasan Mahmud','BOWL',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(114,8,'Mushfiqur Rahim','AR',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(115,8,'Shoriful Islam','BOWL',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(116,8,'Towhid Hridoy','BAT',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(117,9,'Kyle Mayers','AR',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(118,9,'Oshane Thomas','BOWL',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(119,9,'Romario Shepherd','AR',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(120,9,'Shimron Hetmyer','BAT',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(121,10,'Brad Evans','BOWL',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(122,10,'Innocent Kaia','BAT',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(123,10,'Milton Shumba','AR',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(124,10,'Tendai Chatara','BOWL',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(125,11,'Fazalhaq Farooqi','BOWL',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(126,11,'Gulbadin Naib','AR',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(127,11,'Mujeeb Ur Rahman','BOWL',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(128,11,'Rahmat Shah','BAT',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(129,12,'Craig Young','BOWL',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(130,12,'Graham Hume','BOWL',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(131,12,'Lorcan Tucker','AR',NULL,NULL,NULL,1,'2026-03-05 18:18:43'),(132,12,'Simi Singh','AR',NULL,NULL,NULL,1,'2026-03-05 18:18:43');
/*!40000 ALTER TABLE `player` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schedule`
--

DROP TABLE IF EXISTS `schedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `schedule` (
  `ScheduleId` int NOT NULL AUTO_INCREMENT,
  `TeamA` varchar(100) NOT NULL,
  `TeamACode` varchar(10) NOT NULL,
  `TeamB` varchar(100) NOT NULL,
  `TeamBCode` varchar(10) NOT NULL,
  `MatchDate` date NOT NULL,
  `MatchTime` varchar(20) NOT NULL,
  `Venue` varchar(120) NOT NULL,
  `Format` varchar(10) NOT NULL,
  `IsPlayed` int NOT NULL,
  PRIMARY KEY (`ScheduleId`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schedule`
--

LOCK TABLES `schedule` WRITE;
/*!40000 ALTER TABLE `schedule` DISABLE KEYS */;
INSERT INTO `schedule` VALUES (1,'India','in','Pakistan','pk','2025-02-21','7:00 PM','Melbourne Cricket Ground','T20',1),(2,'Australia','au','England','gb','2025-02-28','2:00 PM','Sydney Cricket Ground','ODI',1),(3,'South Africa','za','New Zealand','nz','2025-03-14','1:30 PM','Johannesburg','T20',1),(4,'Sri Lanka','lk','Bangladesh','bd','2025-03-20','6:30 PM','Colombo','ODI',0),(5,'West Indies','jm','Zimbabwe','zw','2025-04-05','4:00 PM','Bridgetown','T20',1),(6,'Afghanistan','af','Ireland','ie','2025-04-12','3:00 PM','Sharjah','T20',0);
/*!40000 ALTER TABLE `schedule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `team`
--

DROP TABLE IF EXISTS `team`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `team` (
  `TeamId` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(100) NOT NULL,
  `ShortName` varchar(10) DEFAULT NULL,
  `CountryCode` varchar(5) DEFAULT NULL,
  `FlagPath` varchar(255) DEFAULT NULL,
  `CreatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`TeamId`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `team`
--

LOCK TABLES `team` WRITE;
/*!40000 ALTER TABLE `team` DISABLE KEYS */;
INSERT INTO `team` VALUES (1,'India','IND','in','in.png','2026-03-05 18:18:43'),(2,'Pakistan','PAK','pk','pk.png','2026-03-05 18:18:43'),(3,'Australia','AUS','au','au.png','2026-03-05 18:18:43'),(4,'England','ENG','gb','gb.png','2026-03-05 18:18:43'),(5,'South Africa','SA','za','za.png','2026-03-05 18:18:43'),(6,'New Zealand','NZ','nz','nz.png','2026-03-05 18:18:43'),(7,'Sri Lanka','SL','lk','lk.png','2026-03-05 18:18:43'),(8,'Bangladesh','BAN','bd','bd.png','2026-03-05 18:18:43'),(9,'West Indies','WI','jm','jm.png','2026-03-05 18:18:43'),(10,'Zimbabwe','ZIM','zw','zw.png','2026-03-05 18:18:43'),(11,'Afghanistan','AFG','af','af.png','2026-03-05 18:18:43'),(12,'Ireland','IRE','ie','ie.png','2026-03-05 18:18:43');
/*!40000 ALTER TABLE `team` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teamranking`
--

DROP TABLE IF EXISTS `teamranking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `teamranking` (
  `RankingId` int NOT NULL AUTO_INCREMENT,
  `Position` int NOT NULL,
  `TeamName` varchar(100) NOT NULL,
  `Matches` int NOT NULL,
  `Points` int NOT NULL,
  `Rating` int NOT NULL,
  `CountryCode` varchar(10) NOT NULL,
  `Wins` int NOT NULL,
  `Losses` int NOT NULL,
  `Ties` int NOT NULL,
  PRIMARY KEY (`RankingId`),
  UNIQUE KEY `uq_teamranking_team` (`TeamName`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teamranking`
--

LOCK TABLES `teamranking` WRITE;
/*!40000 ALTER TABLE `teamranking` DISABLE KEYS */;
INSERT INTO `teamranking` VALUES (1,1,'India',39,4745,122,'in',0,0,0),(2,2,'New Zealand',44,4956,113,'nz',0,0,0),(3,3,'Australia',38,4134,109,'au',0,0,0),(4,4,'Pakistan',41,4294,105,'pk',0,0,0),(5,5,'Sri Lanka',44,4392,100,'lk',0,0,0),(6,6,'South Africa',38,3708,98,'za',0,0,0),(7,7,'Afghanistan',28,2657,95,'af',0,0,0),(8,8,'England',40,3432,86,'gb',0,0,0),(9,9,'West Indies',42,3173,77,'jm',0,1,0),(10,10,'Bangladesh',38,2882,76,'bd',0,0,0),(11,11,'Zimbabwe',25,1301,54,'zw',1,0,0),(12,12,'Ireland',18,938,52,'ie',0,0,0),(13,13,'Scotland',33,1522,46,'gb-sct',0,0,0);
/*!40000 ALTER TABLE `teamranking` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-03-06  0:01:03
