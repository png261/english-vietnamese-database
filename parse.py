import sqlite3
import json


def create_database(database, schemaFile):
    with open(schemaFile, 'r') as sql_file:
        sql_script = sql_file.read()

    cursor = database.cursor()
    cursor.executescript(sql_script)
    database.commit()


def fix_quote(string):
    return string.replace("'", "''")


def query_word(word, pronounce):
    word = fix_quote(word)
    pronounce = fix_quote(pronounce)
    return f"INSERT INTO words(word, pronounce) VALUES('{word}', '{pronounce}')"


def query_explain(explain_type, meaning):
    explain_type = fix_quote(explain_type)
    meaning = fix_quote(meaning)
    return f"INSERT INTO explains(type, meaning) VALUES('{explain_type}', '{meaning}')"


def query_example(example, translate):
    example = fix_quote(example)
    translate = fix_quote(translate)
    return f"INSERT INTO examples(example, translate) VALUES('{example}', '{translate}')"


def query_connect_word_and_explain(word_id, explain_id):
    return f"INSERT INTO words_explains(word_id, explain_id) VALUES('{word_id}', {explain_id})"


def query_connect_explain_and_example(explain_id, example_id):
    return f"INSERT INTO explains_examples(explain_id, example_id) VALUES({explain_id}, {example_id})"


def parse_json(database, jsonFile):
    with open(jsonFile, 'r') as json_file:
        data = json.load(json_file)
        cursor = database.cursor()

        for word, value in data.items():
            cursor.execute(query_word(word, value["pronoun"]))
            word_id = cursor.lastrowid

            for explain in value["type"]:
                for explain_type, explain_value in explain.items():
                    if not explain_value:
                        break

                    for meaning, examples in explain_value[0].items():
                        cursor.execute(query_explain(explain_type, meaning))
                        explain_id = cursor.lastrowid
                        cursor.execute(
                            query_connect_word_and_explain(word_id, explain_id))

                        for example in examples:
                            for ex, trans in example.items():
                                cursor.execute(query_example(ex, trans))
                                example_id = cursor.lastrowid
                                cursor.execute(query_connect_explain_and_example(
                                    explain_id, example_id))
    database.commit()


database = sqlite3.connect('database/en-vi.db')
create_database(database, 'sql/schema.sql')
parse_json(database, 'json/english-vietnamese.json')
database.commit()
database.close()
