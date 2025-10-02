#!/usr/bin/env fish

function show_help
    echo "Penggunaan: ./docker-db.fish perintah [opsi]"
    echo ""
    echo "Perintah tersedia:"
    echo "  shell:             Masuk ke shell MariaDB di container"
    echo "  list:              Menampilkan semua database"
    echo "  tables:            Menampilkan semua tabel dalam database poliklinik"
    echo "  query \"SQL_QUERY\": Menjalankan query SQL kustom"
    echo "  dump [FILE]:       Membuat dump database (default ke poliklinik_dump.sql)"
    echo ""
end

# Parse perintah
if test (count $argv) -eq 0
    show_help
    exit 1
end

set -l command $argv[1]
set -e argv[1]

if test "$command" = "help" -o "$command" = "--help" -o "$command" = "-h"
    show_help
    exit 0
end

# Jalankan perintah yang dipilih
switch $command
    case shell
        echo "Masuk ke shell MariaDB di container db-poli..."
        docker exec -it db-poli mariadb -uroot -proot poliklinik
    
    case list
        echo "Menampilkan semua database di container db-poli..."
        docker exec -it db-poli mariadb -uroot -proot -e "SHOW DATABASES;"
    
    case tables
        echo "Menampilkan semua tabel dalam database poliklinik..."
        docker exec -it db-poli mariadb -uroot -proot -e "USE poliklinik; SHOW TABLES;"
    
    case query
        if test (count $argv) -eq 0
            echo "Error: Query SQL diperlukan"
            exit 1
        end
        
        set -l sql_query $argv[1]
        echo "Menjalankan query: $sql_query"
        docker exec -it db-poli mariadb -uroot -proot poliklinik -e "$sql_query"
    
    case dump
        set -l dump_file "poliklinik_dump.sql"
        if test (count $argv) -gt 0
            set dump_file $argv[1]
        end
        
        echo "Membuat dump database poliklinik ke file $dump_file..."
        docker exec db-poli mariadb-dump -uroot -proot poliklinik > $dump_file
        echo "Database dump tersimpan di $dump_file"
    
    case '*'
        echo "Error: Perintah tidak dikenal: $command"
        echo ""
        show_help
        exit 1
end