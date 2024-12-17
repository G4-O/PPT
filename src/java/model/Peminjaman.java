/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.tubes;

/**
 *
 * @author Belacks
 */
public class Peminjaman extends Transaksi {
    private String tanggalKembali;

    public Peminjaman(String idTransaksi, ItemPerpustakaan item, Anggota anggota, String tanggalTransaksi, String tanggalKembali) {
        super(idTransaksi, item, anggota, tanggalTransaksi);
        this.tanggalKembali = tanggalKembali;
    }

    @Override
    public void detailTransaksi() {
        System.out.println("Peminjaman ID: " + idTransaksi);
        System.out.println("Item: " + item.judul);
        System.out.println("Anggota: " + anggota.nama);
        System.out.println("Tanggal Peminjaman: " + tanggalTransaksi);
        System.out.println("Tanggal Kembali: " + tanggalKembali);
    }
}
