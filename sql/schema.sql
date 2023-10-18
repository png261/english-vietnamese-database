DROP TABLE IF EXISTS words;
DROP TABLE IF EXISTS explains;
DROP TABLE IF EXISTS examples;
DROP TABLE IF EXISTS wordsExplains;
DROP TABLE IF EXISTS explainsExamples;

CREATE TABLE words (
    word_id INTEGER NOT NULL PRIMARY KEY,
    word VARCHAR(255) NOT NULL,
    pronounce VARCHAR(255)
);

CREATE TABLE explains (
    explain_id INTEGER NOT NULL PRIMARY KEY,
    word_id INTEGER NOT NULL,
    type VARCHAR(255),
    meaning VARCHAR(255)
);

CREATE TABLE examples (
    example_id INTEGER NOT NULL PRIMARY KEY,
    explain_id INTEGER NOT NULL,
    example VARCHAR(255),
    translate VARCHAR(255)
);
