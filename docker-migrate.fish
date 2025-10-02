#!/usr/bin/env fish

function show_help
    echo "Penggunaan: ./docker-migrate.fish perintah [opsi]"
    echo ""
    echo "Perintah tersedia:"
    echo "  migrate:           Menjalankan migrasi"
    echo "  rollback:          Mengembalikan migrasi terakhir"
    echo "  fresh:             Menghapus semua tabel dan menjalankan migrasi ulang"
    echo "  refresh:           Menjalankan rollback semua migrasi dan kemudian migrasi ulang"
    echo "  status:            Menampilkan status migrasi"
    echo ""
    echo "Tambahkan opsi setelah perintah (misal: --seed, --step=2, dll)"
end

function docker_migrate
    echo "Menjalankan migrasi di dalam Docker container..."
    docker exec poliklinik-app php artisan migrate $argv
    echo "Migrasi di Docker selesai!"
end

function docker_rollback
    echo "Mengembalikan migrasi terakhir di dalam Docker container..."
    docker exec poliklinik-app php artisan migrate:rollback $argv
    echo "Rollback di Docker selesai!"
end

function docker_fresh
    echo "Menghapus semua tabel dan menjalankan migrasi ulang di Docker container..."
    docker exec poliklinik-app php artisan migrate:fresh $argv
    echo "Fresh migrate di Docker selesai!"
end

function docker_refresh
    echo "Menjalankan rollback dan migrasi ulang di Docker container..."
    docker exec poliklinik-app php artisan migrate:refresh $argv
    echo "Refresh migrate di Docker selesai!"
end

function docker_status
    echo "Menampilkan status migrasi di Docker container..."
    docker exec poliklinik-app php artisan migrate:status
    echo "Status migrasi di Docker selesai!"
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
    case migrate
        docker_migrate $argv
    case rollback
        docker_rollback $argv
    case fresh
        docker_fresh $argv
    case refresh
        docker_refresh $argv
    case status
        docker_status $argv
    case '*'
        echo "Error: Perintah tidak dikenal: $command"
        echo ""
        show_help
        exit 1
end