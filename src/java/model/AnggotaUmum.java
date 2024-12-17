/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.tubes;

/**
 *
 * @author Belacks
 */
public class AnggotaUmum extends Anggota {
    public AnggotaUmum(String nama, String idAnggota) {
        super(nama, idAnggota);
    }

    @Override
    public void pinjamItem(ItemPerpustakaan item, String tanggalPinjam) {
        if (item.isReserved()) {
            item.setStatusDipinjam(true);
            System.out.println(nama + " meminjam " + item.judul + " pada " + tanggalPinjam);
        } else {
            System.out.println("Item tidak tersedia.");
        }
    }

    @Override
    public void kembalikanItem(ItemPerpustakaan item, String tanggalKembali) {
        item.setStatusDipinjam(false);
        System.out.println(nama + " mengembalikan " + item.judul + " pada " + tanggalKembali);
    }

    @Override
    public void tampilkanInfo() {
        System.out.println("Anggota Umum: " + nama + " | ID: " + idAnggota);
    }
}
