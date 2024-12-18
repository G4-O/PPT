/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;


/**
 *
 * @author Belacks
 */
public class AnggotaKaryawan extends Anggota {
     public AnggotaKaryawan(String nama, String idAnggota) {
        super(nama, idAnggota);
    }

    @Override
    public void pinjamItem(ItemPerpustakaan item, String tanggalPinjam) {
        if (item.isAvailable()) {
            item.setStatusDipinjam(true);
            System.out.println(nama + " (Karyawan) meminjam " + item.judul + " pada " + tanggalPinjam);
        } else {
            System.out.println("Item tidak tersedia.");
        }
    }

    @Override
    public void kembalikanItem(ItemPerpustakaan item, String tanggalKembali) {
        item.setStatusDipinjam(false);
        System.out.println(nama + " (Karyawan) mengembalikan " + item.judul + " pada " + tanggalKembali);
    }

    @Override
    public void tampilkanInfo() {
        System.out.println("Anggota Karyawan: " + nama + " | ID: " + idAnggota);
    }
}
