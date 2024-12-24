/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Belacks
 */
public class Pengembalian extends Transaksi {
    private int denda;

    public Pengembalian(String idTransaksi, ItemPerpustakaan item, User user, long tanggalTransaksi, int denda) {
        super(idTransaksi, item, user, tanggalTransaksi);
        this.denda = denda;
    }

    @Override
    public void detailTransaksi() {
        System.out.println("Pengembalian ID: " + idTransaksi);
        System.out.println("Item: " + item.judul);
        System.out.println("Anggota: " + user.getNama());
        System.out.println("Tanggal Pengembalian: " + tanggalTransaksi);
        System.out.println("Denda: " + denda);
    }
}
