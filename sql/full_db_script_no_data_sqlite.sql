CREATE TABLE answers (
    answer_id integer NOT NULL PRIMARY KEY AUTOINCREMENT,
    game_id integer NOT NULL,
    team_id integer NOT NULL,
    user_inst_id integer NOT NULL,
    name_id integer NOT NULL,
    name character varying(40) NOT NULL,
    success integer NOT NULL,
    round integer NOT NULL,
    time_start timestamp without time zone,
    time_finish timestamp without time zone,
    turn_id integer
);

CREATE TABLE default_names (
    name_id integer NOT NULL PRIMARY KEY AUTOINCREMENT,
    name character varying(40) NOT NULL
);

CREATE TABLE games (
    game_id integer NOT NULL PRIMARY KEY AUTOINCREMENT,
    game_name character varying(40) NOT NULL,
    active boolean NOT NULL,
    stage integer,
    round integer,
    number_teams integer NOT NULL,
    number_names integer NOT NULL,
    time_limit integer NOT NULL,
    round1 integer,
    round2 integer,
    round3 integer,
    round4 integer,
    date_created timestamp without time zone
);


CREATE TABLE mp3_order (
    number_stops integer,
    current_stop integer,
    number_starts integer,
    current_start integer
);

CREATE TABLE names (
    name_id integer NOT NULL PRIMARY KEY AUTOINCREMENT,
    game_id integer NOT NULL,
    user_inst_id integer NOT NULL,
    name character varying(40) NOT NULL
);

CREATE TABLE players_turn_order (
    team_id integer,
    players_array integer[],
    number_players integer,
    current_player integer
);

CREATE TABLE teams (
    team_id integer NOT NULL PRIMARY KEY AUTOINCREMENT,
    game_id integer NOT NULL,
    team_name character varying(20) NOT NULL,
    round1score integer,
    round2score integer,
    round3score integer,
    round4score integer,
    final_score integer
);


CREATE TABLE teams_turn_order (
    game_id integer,
    teams_array integer[],
    number_teams integer,
    current_team integer
);


CREATE TABLE turns (
    turn_id integer NOT NULL PRIMARY KEY AUTOINCREMENT,
    user_inst_id integer NOT NULL,
    game_id integer NOT NULL,
    round integer NOT NULL,
    time_start timestamp without time zone,
    time_finish timestamp without time zone,
    active boolean
);


CREATE TABLE user_instance (
    user_inst_id integer NOT NULL PRIMARY KEY AUTOINCREMENT,
    user_id integer NOT NULL,
    username character varying(16) NOT NULL,
    team_id integer,
    game_id integer NOT NULL,
    round1score integer,
    round2score integer,
    round3score integer,
    round4score integer,
    final_score integer
);

CREATE TABLE users (
    user_id integer NOT NULL PRIMARY KEY AUTOINCREMENT,
    username character varying(16) NOT NULL,
    ip_address character varying(24)
);


INSERT INTO default_names VALUES (1, 'Donald Trump');
INSERT INTO default_names VALUES (2, 'Che Guevara');
INSERT INTO default_names VALUES (3, 'Pope Francis');
INSERT INTO default_names VALUES (4, 'Muhammad Ali');
INSERT INTO default_names VALUES (5, 'Jimmy Carter');
INSERT INTO default_names VALUES (6, 'Stephen Hawking');
INSERT INTO default_names VALUES (7, 'Pope John Paul II');
INSERT INTO default_names VALUES (8, 'Mikhail Gorbachev');
INSERT INTO default_names VALUES (9, 'Yuri Gagarin');
INSERT INTO default_names VALUES (10, 'Sylvester Stallone');
INSERT INTO default_names VALUES (11, 'Steve Jobs');
INSERT INTO default_names VALUES (12, 'Freddie Mercury');
INSERT INTO default_names VALUES (13, 'Malcolm X');
INSERT INTO default_names VALUES (14, 'Elvis Presley');
INSERT INTO default_names VALUES (15, 'Bob Marley');
INSERT INTO default_names VALUES (16, 'Fidel Castro');
INSERT INTO default_names VALUES (17, 'Vladimir Putin');
INSERT INTO default_names VALUES (18, 'Neil Armstrong');
INSERT INTO default_names VALUES (19, 'Steven Spielberg');
INSERT INTO default_names VALUES (20, 'Saddam Hussein');
INSERT INTO default_names VALUES (21, 'Bruce Lee');
INSERT INTO default_names VALUES (22, 'Martin Scorsese');
INSERT INTO default_names VALUES (23, 'Pope Benedict XVI');
INSERT INTO default_names VALUES (24, 'John Lennon');
INSERT INTO default_names VALUES (25, 'Prince Philip');
INSERT INTO default_names VALUES (26, 'Ennio Morricone');
INSERT INTO default_names VALUES (27, 'Pablo Escobar');
INSERT INTO default_names VALUES (28, 'Michael Jackson');
INSERT INTO default_names VALUES (29, 'Boris Yeltsin');
INSERT INTO default_names VALUES (30, 'Clint Eastwood');
INSERT INTO default_names VALUES (31, 'Al Pacino');
INSERT INTO default_names VALUES (32, 'Bill Gates');
INSERT INTO default_names VALUES (33, 'Muammar Gaddafi');
INSERT INTO default_names VALUES (34, '14th Dalai Lama');
INSERT INTO default_names VALUES (35, 'Marlon Brando');
INSERT INTO default_names VALUES (36, 'Yasser Arafat');
INSERT INTO default_names VALUES (37, 'Charles Manson');
INSERT INTO default_names VALUES (38, 'Kim Jong-il');
INSERT INTO default_names VALUES (39, 'Stanley Kubrick');
INSERT INTO default_names VALUES (40, 'Anthony Hopkins');
INSERT INTO default_names VALUES (41, 'Andy Warhol');
INSERT INTO default_names VALUES (42, 'Robert De Niro');
INSERT INTO default_names VALUES (43, 'Luciano Pavarotti');
INSERT INTO default_names VALUES (44, 'Sean Connery');
INSERT INTO default_names VALUES (45, 'Morgan Freeman');
INSERT INTO default_names VALUES (46, 'Jeff Bezos');
INSERT INTO default_names VALUES (47, 'Martin Luther King Jr.');
INSERT INTO default_names VALUES (48, 'Arnold Schwarzenegger');
INSERT INTO default_names VALUES (49, 'Elon Musk');
INSERT INTO default_names VALUES (50, 'Warren Buffett');
INSERT INTO default_names VALUES (51, 'Roman Polanski');
INSERT INTO default_names VALUES (52, 'Jack Nicholson');
INSERT INTO default_names VALUES (53, 'Pol Pot');
INSERT INTO default_names VALUES (54, 'George W. Bush');
INSERT INTO default_names VALUES (55, 'Prince Charles');
INSERT INTO default_names VALUES (56, 'Noam Chomsky');
INSERT INTO default_names VALUES (57, 'Danny DeVito');
INSERT INTO default_names VALUES (58, 'Joe Biden');
INSERT INTO default_names VALUES (59, 'Dustin Hoffman');
INSERT INTO default_names VALUES (60, 'Patrick Swayze');
INSERT INTO default_names VALUES (61, 'Leonard Cohen');
INSERT INTO default_names VALUES (62, 'Elizabeth II');
INSERT INTO default_names VALUES (63, 'Marilyn Monroe');
INSERT INTO default_names VALUES (64, 'Hillary Clinton');
INSERT INTO default_names VALUES (65, 'Anne Frank');
INSERT INTO default_names VALUES (66, 'Margaret Thatcher');
INSERT INTO default_names VALUES (67, 'Cher');
INSERT INTO default_names VALUES (68, 'Audrey Hepburn');
INSERT INTO default_names VALUES (69, 'Angela Merkel');
INSERT INTO default_names VALUES (70, 'Janis Joplin');
INSERT INTO default_names VALUES (71, 'Judy Garland');
INSERT INTO default_names VALUES (72, 'Princess Margaret');
INSERT INTO default_names VALUES (73, 'Tina Turner');
INSERT INTO default_names VALUES (74, 'Meryl Streep');
INSERT INTO default_names VALUES (75, 'Maggie Smith');
INSERT INTO default_names VALUES (76, 'Yoko Ono');
INSERT INTO default_names VALUES (77, 'Grace Kelly');
INSERT INTO default_names VALUES (78, 'Princess Diana');
INSERT INTO default_names VALUES (79, 'Madonna');
INSERT INTO default_names VALUES (80, 'Barbra Streisand');
INSERT INTO default_names VALUES (81, 'Judi Dench');
INSERT INTO default_names VALUES (82, 'Patti Smith');
INSERT INTO default_names VALUES (83, 'Whitney Houston');
INSERT INTO default_names VALUES (84, 'Aretha Franklin');
INSERT INTO default_names VALUES (85, 'Helen Mirren');
INSERT INTO default_names VALUES (86, 'Sigourney Weaver');
INSERT INTO default_names VALUES (87, 'J. K. Rowling');
INSERT INTO default_names VALUES (88, 'Julie Andrews');
INSERT INTO default_names VALUES (89, 'Gwyneth Paltrow');
INSERT INTO default_names VALUES (90, 'Cameron Diaz');
INSERT INTO default_names VALUES (91, 'Sandra Bullock');
INSERT INTO default_names VALUES (92, 'Margaret Atwood');
INSERT INTO default_names VALUES (93, 'Anatoly Dyatlov');
INSERT INTO default_names VALUES (94, 'Angelina Jolie');
INSERT INTO default_names VALUES (95, 'Muhammad');
INSERT INTO default_names VALUES (96, 'Genghis Khan');
INSERT INTO default_names VALUES (97, 'Leonardo da Vinci');
INSERT INTO default_names VALUES (98, 'Isaac Newton');
INSERT INTO default_names VALUES (99, 'Ludwig van Beethoven');
INSERT INTO default_names VALUES (100, 'Alexander the Great');
INSERT INTO default_names VALUES (101, 'Aristotle');
INSERT INTO default_names VALUES (102, 'Napoleon');
INSERT INTO default_names VALUES (103, 'Julius Caesar');
INSERT INTO default_names VALUES (104, 'Wolfgang Amadeus Mozart');
INSERT INTO default_names VALUES (105, 'Plato');
INSERT INTO default_names VALUES (106, 'Jesus');
INSERT INTO default_names VALUES (107, 'Adolf Hitler');
INSERT INTO default_names VALUES (108, 'Galileo Galilei');
INSERT INTO default_names VALUES (109, 'Marco Polo');
INSERT INTO default_names VALUES (110, 'Socrates');
INSERT INTO default_names VALUES (111, 'Johann Sebastian Bach');
INSERT INTO default_names VALUES (112, 'Albert Einstein');
INSERT INTO default_names VALUES (113, 'Michelangelo');
INSERT INTO default_names VALUES (114, 'William Shakespeare');
INSERT INTO default_names VALUES (115, 'Martin Luther');
INSERT INTO default_names VALUES (116, 'Christopher Columbus');
INSERT INTO default_names VALUES (117, 'Moses');
INSERT INTO default_names VALUES (118, 'Archimedes');
INSERT INTO default_names VALUES (119, 'Abraham');
INSERT INTO default_names VALUES (120, 'Sigmund Freud');
INSERT INTO default_names VALUES (121, 'Confucius');
INSERT INTO default_names VALUES (122, 'Vincent van Gogh');
INSERT INTO default_names VALUES (123, 'Nicolaus Copernicus');
INSERT INTO default_names VALUES (124, 'Ferdinand Magellan');
INSERT INTO default_names VALUES (125, 'Gautama Buddha');
INSERT INTO default_names VALUES (126, 'Charles Darwin');
INSERT INTO default_names VALUES (127, 'Karl Marx');
INSERT INTO default_names VALUES (128, 'Immanuel Kant');
INSERT INTO default_names VALUES (129, 'Thomas Jefferson');
INSERT INTO default_names VALUES (130, 'Joseph Stalin');
INSERT INTO default_names VALUES (131, 'Thomas Edison');
INSERT INTO default_names VALUES (132, 'Vladimir Lenin');
INSERT INTO default_names VALUES (133, 'Homer');
INSERT INTO default_names VALUES (134, 'Pablo Picasso');
INSERT INTO default_names VALUES (135, 'Nikola Tesla');
INSERT INTO default_names VALUES (136, 'Antonio Vivaldi');
INSERT INTO default_names VALUES (137, 'Nelson Mandela');
INSERT INTO default_names VALUES (138, 'Friedrich Nietzsche');
INSERT INTO default_names VALUES (139, 'Mahatma Gandhi');
INSERT INTO default_names VALUES (140, 'Frederic Chopin');
INSERT INTO default_names VALUES (141, 'J. R. R. Tolkien');
INSERT INTO default_names VALUES (142, 'Niccola Machiavelli');
INSERT INTO default_names VALUES (143, 'Hans Christian Andersen');
INSERT INTO default_names VALUES (144, 'Charlie Chaplin');
INSERT INTO default_names VALUES (145, 'Salvador Dali');
INSERT INTO default_names VALUES (146, 'Mary, mother of Jesus');
INSERT INTO default_names VALUES (147, 'Joan of Arc');
INSERT INTO default_names VALUES (148, 'Elizabeth I');
INSERT INTO default_names VALUES (149, 'Marie Curie');
INSERT INTO default_names VALUES (150, 'Frida Kahlo');
INSERT INTO default_names VALUES (151, 'Queen Victoria');
INSERT INTO default_names VALUES (152, 'Marie Antoinette');
INSERT INTO default_names VALUES (153, 'Nefertiti');
INSERT INTO default_names VALUES (154, 'Maria Theresa');
INSERT INTO default_names VALUES (155, 'Agatha Christie');
INSERT INTO default_names VALUES (156, 'Mary, Queen of Scots');
INSERT INTO default_names VALUES (157, 'Pocahontas');
INSERT INTO default_names VALUES (158, 'Anne Boleyn');
INSERT INTO default_names VALUES (159, 'Catherine the Great');
INSERT INTO default_names VALUES (160, 'Mary Magdalene');
INSERT INTO default_names VALUES (161, 'Mother Teresa');
INSERT INTO default_names VALUES (162, 'Florence Nightingale');
INSERT INTO default_names VALUES (163, 'Eleanor Roosevelt');
INSERT INTO default_names VALUES (164, 'Cleopatra');
INSERT INTO default_names VALUES (165, 'Coco Chanel');
INSERT INTO default_names VALUES (166, 'Jane Austen');
INSERT INTO default_names VALUES (167, 'Wallis Simpson');
INSERT INTO default_names VALUES (168, 'Maria Montessori');
INSERT INTO default_names VALUES (169, 'Baba Vanga');
INSERT INTO default_names VALUES (170, 'Virginia Woolf');
INSERT INTO default_names VALUES (171, 'Eva Braun');
INSERT INTO default_names VALUES (172, 'Kim Jong-un');
INSERT INTO default_names VALUES (173, 'Novak Djokovic');
INSERT INTO default_names VALUES (174, 'Chris Hemsworth');
INSERT INTO default_names VALUES (175, 'Roger Federer');
INSERT INTO default_names VALUES (176, 'Mark Zuckerberg');
INSERT INTO default_names VALUES (177, 'PewDiePie');
INSERT INTO default_names VALUES (178, 'Prince William');
INSERT INTO default_names VALUES (179, 'Shia LaBeouf');
INSERT INTO default_names VALUES (180, 'Usain Bolt');
INSERT INTO default_names VALUES (181, 'Drake');
INSERT INTO default_names VALUES (182, 'Daniel Radcliffe');
INSERT INTO default_names VALUES (183, 'Edward Snowden');
INSERT INTO default_names VALUES (184, 'Rafael Nadal');
INSERT INTO default_names VALUES (185, 'Lil Wayne');
INSERT INTO default_names VALUES (186, 'Avicii');
INSERT INTO default_names VALUES (187, 'LeBron James');
INSERT INTO default_names VALUES (188, 'Liam Hemsworth');
INSERT INTO default_names VALUES (189, 'Eddie Redmayne');
INSERT INTO default_names VALUES (190, 'Andrew Garfield');
INSERT INTO default_names VALUES (191, 'Rami Malek');
INSERT INTO default_names VALUES (192, 'Justin Timberlake');
INSERT INTO default_names VALUES (193, 'Justin Bieber');
INSERT INTO default_names VALUES (194, 'Donald Glover');
INSERT INTO default_names VALUES (195, 'Robert Pattinson');
INSERT INTO default_names VALUES (196, 'Elijah Wood');
INSERT INTO default_names VALUES (197, 'Rihanna');
INSERT INTO default_names VALUES (198, 'Lady Gaga');
INSERT INTO default_names VALUES (199, 'Natalie Portman');
INSERT INTO default_names VALUES (200, 'Margot Robbie');
INSERT INTO default_names VALUES (201, 'Scarlett Johansson');
INSERT INTO default_names VALUES (202, 'Alicia Keys');
INSERT INTO default_names VALUES (203, 'Anne Hathaway');
INSERT INTO default_names VALUES (204, 'Emma Watson');
INSERT INTO default_names VALUES (205, 'Britney Spears');
INSERT INTO default_names VALUES (206, 'Amy Winehouse');
INSERT INTO default_names VALUES (207, 'Avril Lavigne');
INSERT INTO default_names VALUES (208, 'Keira Knightley');
INSERT INTO default_names VALUES (209, 'Selena Gomez');
INSERT INTO default_names VALUES (210, 'Beyonce');
INSERT INTO default_names VALUES (211, 'Katy Perry');
INSERT INTO default_names VALUES (212, 'Jessica Alba');
INSERT INTO default_names VALUES (213, 'Ariana Grande');
INSERT INTO default_names VALUES (214, 'Jennifer Lawrence');
INSERT INTO default_names VALUES (215, 'Emilia Clarke');
INSERT INTO default_names VALUES (216, 'Gal Gadot');
INSERT INTO default_names VALUES (217, 'Kirsten Dunst');
INSERT INTO default_names VALUES (218, 'Paris Hilton');
INSERT INTO default_names VALUES (219, 'Emma Stone');
INSERT INTO default_names VALUES (220, 'Kristen Stewart');
INSERT INTO default_names VALUES (221, 'Meghan Markle');
INSERT INTO default_names VALUES (222, 'Amber Heard');
INSERT INTO default_names VALUES (223, 'Taylor Swift');
INSERT INTO default_names VALUES (224, 'Kim Yo-jong');
INSERT INTO default_names VALUES (225, 'Lindsay Lohan');
INSERT INTO default_names VALUES (226, 'Megan Fox');
INSERT INTO default_names VALUES (227, 'Miley Cyrus');
INSERT INTO default_names VALUES (228, 'Billie Eilish');
INSERT INTO default_names VALUES (229, 'Mila Kunis');
INSERT INTO default_names VALUES (230, 'Lana Del Rey');
INSERT INTO default_names VALUES (231, 'Greta Thunberg');
INSERT INTO default_names VALUES (232, 'Serena Williams');
INSERT INTO default_names VALUES (233, 'Kylie Jenner');
INSERT INTO default_names VALUES (234, 'Dakota Johnson');
INSERT INTO default_names VALUES (235, 'Nicki Minaj');
INSERT INTO default_names VALUES (236, 'Adele');


INSERT INTO mp3_order VALUES (13, 2, 18, 6);
