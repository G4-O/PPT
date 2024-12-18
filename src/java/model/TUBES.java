/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 */


package model;

/**
 *
 * @author Belacks
 */
public class TUBES {

    public static void main(String[] args) {
        Perpustakaan perpustakaan = new Perpustakaan();

        // Menambahkan Item
        Buku buku1 = new Buku("Pemrograman Java", "B001", "John Doe", 2020);
        CD cd1 = new CD("Musik Klasik", "C001", "Beethoven", 60);
        DVD dvd1 = new DVD("Film Aksi", "D001", "Steven Spielberg", 120);

        perpustakaan.tambahItem(buku1);
        perpustakaan.tambahItem(cd1);
        perpustakaan.tambahItem(dvd1);

        // Menambahkan Anggota
        Anggota anggota1 = new Anggota("Alice", "A001");
        perpustakaan.tambahAnggota(anggota1);

        // Transaksi Peminjaman
        //Peminjaman peminjaman1 = new Peminjaman("T001", buku1, anggota1, "2024-11-10", "2024-11-17");
        //perpustakaan.tambahTransaksi(peminjaman1);
        //anggota1.pinjamItem(buku1, "2024-11-10");

        // Transaksi Pengembalian
        //Pengembalian pengembalian1 = new Pengembalian("T002", buku1, anggota1, "2024-11-17", 0);
        //perpustakaan.tambahTransaksi(pengembalian1);
        //anggota1.kembalikanItem(buku1, "2024-11-17");

        // Tampilkan Semua Transaksi
        //perpustakaan.tampilkanDaftarTransaksi();
    }
}
