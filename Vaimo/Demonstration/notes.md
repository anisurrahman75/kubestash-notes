```bash
mysqldump -u root -h sample-mysql.demo.svc --port=3306 --set-gtid-purged=OFF --no-tablespaces --no-data --skip-triggers --skip-opt --single-transaction --create-options --disable-keys --extended-insert --set-charset --quick playground 
&& 
mysqldump -u root -h sample-mysql.demo.svc --port=3306 --set-gtid-purged=OFF --no-tablespaces --no-create-info --skip-triggers --skip-opt --single-transaction --create-options --disable-keys --extended-insert --set-charset --quick --ignore-table=playground.equipment playground 
&& 
mysqldump -u root -h sample-mysql.demo.svc --port=3306 --set-gtid-purged=OFF --no-tablespaces --no-data --no-create-info --skip-opt --single-transaction --create-options --disable-keys --extended-insert --set-charset --quick playground
```

## QUERIES:
```bash
CREATE DATABASE playground;
USE playground;
```

```bash
CREATE TABLE equipment (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    purchase_date DATE,
    cost DECIMAL(10, 2),
    is_active BOOLEAN DEFAULT TRUE
);

```


```bash
INSERT INTO equipment (name, description, purchase_date, cost, is_active)
VALUES ('Laptop', 'High-performance laptop for engineering work', '2023-10-01', 1500.00, TRUE);

```

```bash
SELECT * FROM equipment;
````




















# ### Explanation of Commands:

# #### 1. **Schema-only Dump**
# ```bash
# mysqldump -h sample-mysql.demo.svc -u root -pts3qkpyOjj9M5Bhw --no-tablespaces --no-data --skip-triggers --skip-opt --single-transaction --create-options --disable-keys --extended-insert --set-charset --quick playground
# ```

# - **Purpose**: Dumps only the database schema (table structure) without any data.
# - **Key Flags**:
#   - `--no-data`: Ensures no row data is included, only schema.
#   - `--skip-triggers`: Excludes triggers from the dump.
#   - `--skip-opt`: Disables default optimizations for dumping.
#   - `--create-options`: Includes table options like `ENGINE`, `CHARSET`, etc.
#   - `--single-transaction`: Ensures consistency during the dump.
#   - Other flags (`--disable-keys`, `--set-charset`, `--extended-insert`, `--quick`) are included but don't significantly affect schema-only dumps.
  
# **Output**: SQL statements for creating tables (`CREATE TABLE`), indexes, and other schema-related constructs.

# ---

# #### 2. **Data-only Dump (with a Table Ignored)**
# ```bash
# mysqldump -h sample-mysql.demo.svc -u root -pts3qkpyOjj9M5Bhw --no-tablespaces --no-create-info --skip-triggers --skip-opt --single-transaction --create-options --disable-keys --extended-insert --set-charset --quick --ignore-table=playground.equipment playground
# ```

# - **Purpose**: Dumps data for all tables except `equipment` in the `playground` database.
# - **Key Flags**:
#   - `--no-create-info`: Skips table creation statements, includes only data (`INSERT` statements).
#   - `--ignore-table=playground.equipment`: Excludes data for the `equipment` table.
#   - `--single-transaction`: Ensures consistency for the data during the dump.
#   - `--quick`: Streams data directly instead of buffering it in memory.
#   - Other flags (`--disable-keys`, `--set-charset`, `--extended-insert`) optimize data dumping.

# **Output**: `INSERT` statements for all tables in `playground`, excluding the `equipment` table.

# ---

# #### 3. **Empty Dump (No Schema, No Data)**
# ```bash
# mysqldump -h sample-mysql.demo.svc -u root -pts3qkpyOjj9M5Bhw --no-tablespaces --no-data --no-create-info --skip-opt --single-transaction --create-options --disable-keys --extended-insert --set-charset --quick playground
# ```

# - **Purpose**: Dumps neither the schema nor the data.
# - **Key Flags**:
#   - `--no-data`: Excludes data.
#   - `--no-create-info`: Excludes schema (table creation statements).
#   - Other flags don't apply as nothing is dumped.

# **Output**: Essentially **empty**, since both schema and data are excluded.

# ---

# ### Differences:

# | Feature                     | Command 1: Schema-only                 | Command 2: Data-only                | Command 3: Empty                     |
# |-----------------------------|-----------------------------------------|-------------------------------------|---------------------------------------|
# | **Data Dumped**             | No                                     | Yes (excludes `equipment` table)    | No                                   |
# | **Schema Dumped**           | Yes                                    | No                                  | No                                   |
# | **Triggers Included**       | No (`--skip-triggers`)                 | No (`--skip-triggers`)              | N/A                                  |
# | **Ignored Tables**          | None                                   | `equipment` table only              | N/A                                  |
# | **Output Content**          | `CREATE TABLE` statements, no data     | `INSERT` statements for data only   | None (empty output)                  |

# ### Use Cases:
# - **Command 1**: Useful when migrating or replicating the database schema.
# - **Command 2**: Ideal for transferring specific data (excluding some tables).
# - **Command 3**: Likely a mistake or placeholder for testing dump flags.



# In Go's exec package, when we directly execute a command (using the system's default program execution), 
# it uses raw system calls (like fork() + execve() on Unix) which only run a single program with its arguments. 
# Shell operators like '&&' are features of shells (bash/sh) and not part of the system's program execution mechanism. 
# That's why we need to explicitly use "sh" or "bash" with "-c" flag to access shell features like '&&'.

# Example:
# // Won't work - trying to use && directly with system execution
# exec.Command("echo", "hello", "&&", "echo", "world")   

# // Works - using shell to get && operator
# exec.Command("sh", "-c", "echo hello && echo world")







