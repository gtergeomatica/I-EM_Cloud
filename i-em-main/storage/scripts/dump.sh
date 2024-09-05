
pg_dump -f "${DUMPPATH}/${SOURCEMODEL}" -U postgres -h localhost -s ${DBNAME}

echo "File ${SOURCEMODEL} updated successfully!"

