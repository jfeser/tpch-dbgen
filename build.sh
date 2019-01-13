#!/bin/bash

DB=tpch
SCALE=1

dropdb --if-exists $DB;
createdb $DB;
./dbgen -s $SCALE -f;

for i in `ls *.tbl`; do
    sed 's/|$//' $i > ${i/tbl/csv};
    echo $i;
done;

mv *.csv /tmp;
psql -d tpch -f tpch-build-db.sql;
