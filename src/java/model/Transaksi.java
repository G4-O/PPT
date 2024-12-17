/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.tubes;

/**
 *
 * @author Belacks
 */
public abstract class Transaksi {
    protected String idTransaksi;
    protected ItemPerpustakaan item;
    protected Anggota anggota;
    protected String tanggalTransaksi;

    public Transaksi(String idTransaksi, ItemPerpustakaan item, Anggota anggota, String tanggalTransaksi) {
        this.idTransaksi = idTransaksi;
        this.item = item;
        this.anggota = anggota;
        this.tanggalTransaksi = tanggalTransaksi;
    }

    public abstract void detailTransaksi();
}
