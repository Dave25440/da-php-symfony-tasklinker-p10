-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost:8889
-- Généré le : lun. 02 mars 2026 à 15:15
-- Version du serveur : 8.0.44
-- Version de PHP : 8.3.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `tasklinker_p10`
--

-- --------------------------------------------------------

--
-- Structure de la table `doctrine_migration_versions`
--

CREATE TABLE `doctrine_migration_versions` (
  `version` varchar(191) NOT NULL,
  `executed_at` datetime DEFAULT NULL,
  `execution_time` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `doctrine_migration_versions`
--

INSERT INTO `doctrine_migration_versions` (`version`, `executed_at`, `execution_time`) VALUES
('DoctrineMigrations\\Version20260216141827', '2026-02-24 13:49:50', 62),
('DoctrineMigrations\\Version20260219123954', '2026-02-24 13:49:50', 18),
('DoctrineMigrations\\Version20260226101330', '2026-02-26 10:14:38', 34);

-- --------------------------------------------------------

--
-- Structure de la table `employee`
--

CREATE TABLE `employee` (
  `id` int NOT NULL,
  `lastname` varchar(255) NOT NULL,
  `firstname` varchar(255) NOT NULL,
  `email` varchar(180) NOT NULL,
  `start` date NOT NULL,
  `status` varchar(255) NOT NULL,
  `roles` json NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `employee`
--

INSERT INTO `employee` (`id`, `lastname`, `firstname`, `email`, `start`, `status`, `roles`, `password`) VALUES
(1, 'Daniel', 'Patricia', 'celina55@carre.org', '1975-03-08', 'CDD', '[]', '$2y$13$b5hQ1YSxbp5gueKPNYamrevarmBClppd9jxgTc/KzQRX3iKVNDXuu'),
(2, 'Fleury', 'Robert', 'yblanc@royer.com', '2002-07-06', 'Freelance', '[]', '$2y$13$WDZU5/49RC1t87mGJvqcYuaMBQRWWsM2KpmPqm8FrZFj/Oq8dl3Li'),
(3, 'Dumont', 'Raymond', 'emile.rocher@laposte.net', '2012-12-24', 'CDD', '[]', '$2y$13$wBjr30lm50NvA5CZ/eyKROnfi8UERch08tYLMSqjgNQEWvK7z4PA.'),
(4, 'Horès', 'David', 'dave@mail.com', '2026-02-26', 'CDI', '[\"ROLE_ADMIN\"]', '$2y$13$Gt37aF0754nR1qMu6A3R3.puOac/ZfjzBOLn4CQvJRex7W2qJJ9by'),
(5, 'Houbre', 'Gary', 'gary@mail.com', '2026-02-26', 'CDI', '[\"ROLE_USER\"]', '$2y$13$ZRM942f3Wolee1Xqfy1fGOAkvKuxX5fHJFn0F9wV0xRxHU57q1Lq6');

-- --------------------------------------------------------

--
-- Structure de la table `employee_project`
--

CREATE TABLE `employee_project` (
  `employee_id` int NOT NULL,
  `project_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `employee_project`
--

INSERT INTO `employee_project` (`employee_id`, `project_id`) VALUES
(1, 1),
(1, 2),
(2, 1),
(3, 1),
(3, 2),
(5, 2);

-- --------------------------------------------------------

--
-- Structure de la table `messenger_messages`
--

CREATE TABLE `messenger_messages` (
  `id` bigint NOT NULL,
  `body` longtext NOT NULL,
  `headers` longtext NOT NULL,
  `queue_name` varchar(190) NOT NULL,
  `created_at` datetime NOT NULL,
  `available_at` datetime NOT NULL,
  `delivered_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `project`
--

CREATE TABLE `project` (
  `id` int NOT NULL,
  `title` varchar(255) NOT NULL,
  `archive` tinyint NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `project`
--

INSERT INTO `project` (`id`, `title`, `archive`) VALUES
(1, 'Autem sequi veniam ea dolor corrupti.', 0),
(2, 'Molestiae rem cum laudantium.', 0);

-- --------------------------------------------------------

--
-- Structure de la table `task`
--

CREATE TABLE `task` (
  `id` int NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` tinytext,
  `deadline` date DEFAULT NULL,
  `status` varchar(255) NOT NULL,
  `employee_id` int DEFAULT NULL,
  `project_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `task`
--

INSERT INTO `task` (`id`, `title`, `description`, `deadline`, `status`, `employee_id`, `project_id`) VALUES
(1, 'Consequatur non aliquid tempore corporis nihil et architecto.', 'Qui quo repellat odit et. Voluptas adipisci laborum at.', '2012-08-19', 'doing', 1, 1),
(2, 'Magni doloribus dicta recusandae ea fuga.', 'Magni est deserunt nobis omnis ab. Numquam repudiandae tenetur quia quis.', '2014-07-02', 'done', 1, 2),
(3, 'Molestiae et voluptatem fugit vitae.', 'Aut occaecati expedita a. Itaque quod sunt deleniti dolor. Culpa nobis qui distinctio ducimus.', '2006-01-04', 'to_do', 1, 2),
(4, 'Mollitia repudiandae neque mollitia.', 'Quia quo asperiores dolores. In provident perspiciatis vitae ut. Ut iure nemo minus minus eum aut.', '2017-04-01', 'doing', 3, 1),
(5, 'Commodi unde quis consequatur sunt.', 'Eum quasi dolor quisquam necessitatibus aut quidem. Rerum eos voluptas quis veniam enim.', '1997-03-17', 'done', 1, 2),
(6, 'Ut ut enim rerum.', 'Perferendis sunt cupiditate ipsam et. Voluptatem non dolorem cumque officiis eum totam.', '1992-08-14', 'done', 1, 2),
(7, 'Veritatis eum eum sit labore ut quia.', 'Consequuntur et occaecati neque rem sint. Et ullam rerum maiores.', '1989-10-11', 'doing', 2, 1),
(8, 'Illo saepe incidunt assumenda odit laudantium molestias praesentium.', 'Doloribus esse repellat quo. Vel minus qui nisi sunt ut minus. Nisi distinctio dolore voluptas.', '2019-11-12', 'to_do', 3, 1);

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `doctrine_migration_versions`
--
ALTER TABLE `doctrine_migration_versions`
  ADD PRIMARY KEY (`version`);

--
-- Index pour la table `employee`
--
ALTER TABLE `employee`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_5D9F75A1E7927C74` (`email`);

--
-- Index pour la table `employee_project`
--
ALTER TABLE `employee_project`
  ADD PRIMARY KEY (`employee_id`,`project_id`),
  ADD KEY `IDX_AFFF86E18C03F15C` (`employee_id`),
  ADD KEY `IDX_AFFF86E1166D1F9C` (`project_id`);

--
-- Index pour la table `messenger_messages`
--
ALTER TABLE `messenger_messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_75EA56E0FB7336F0E3BD61CE16BA31DBBF396750` (`queue_name`,`available_at`,`delivered_at`,`id`);

--
-- Index pour la table `project`
--
ALTER TABLE `project`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `task`
--
ALTER TABLE `task`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_527EDB258C03F15C` (`employee_id`),
  ADD KEY `IDX_527EDB25166D1F9C` (`project_id`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `employee`
--
ALTER TABLE `employee`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT pour la table `messenger_messages`
--
ALTER TABLE `messenger_messages`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `project`
--
ALTER TABLE `project`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `task`
--
ALTER TABLE `task`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `employee_project`
--
ALTER TABLE `employee_project`
  ADD CONSTRAINT `FK_AFFF86E1166D1F9C` FOREIGN KEY (`project_id`) REFERENCES `project` (`id`),
  ADD CONSTRAINT `FK_AFFF86E18C03F15C` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`id`);

--
-- Contraintes pour la table `task`
--
ALTER TABLE `task`
  ADD CONSTRAINT `FK_527EDB25166D1F9C` FOREIGN KEY (`project_id`) REFERENCES `project` (`id`),
  ADD CONSTRAINT `FK_527EDB258C03F15C` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`id`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
