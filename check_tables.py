import sqlite3

conn = sqlite3.connect('carmax_v3.db')
cursor = conn.cursor()
cursor.execute("SELECT name FROM sqlite_master WHERE type='table';")
tables = cursor.fetchall()
print("Tables in carmax_v3.db:")
for table in tables:
    print(table[0])
conn.close()