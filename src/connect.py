import psycopg2

def connect():
    try:
        conn = psycopg2.connect(
            dbname="football_stats",
            user="tyty",
            password="tuPasswordFacherita",
            host="localhost",
            port="5432"
        )
        print("Conexión exitosa a PostgreSQL 🟢")
        return conn
    except Exception as e:
        print("Error en la conexión 🚨", e)

if __name__ == "__main__":
    connect()
