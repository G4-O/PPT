/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Belacks
 */
public abstract class Transaksi {
    protected String idTransaksi;
    protected ItemPerpustakaan item;
    protected User user;
    protected long tanggalTransaksi;

    public Transaksi(String idTransaksi, ItemPerpustakaan item, User user, long tanggalTransaksi) {
        this.idTransaksi = idTransaksi;
        this.item = item;
        this.user = user;
        this.tanggalTransaksi = tanggalTransaksi;
    }

    public abstract void detailTransaksi();
}
