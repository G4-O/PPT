/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;
import java.util.ArrayList;

/**
 *
 * @author Belacks
 */
public class Perpustakaan {
    private ArrayList<ItemPerpustakaan> daftarItem = new ArrayList<>();
    private ArrayList<Anggota> daftarAnggota = new ArrayList<>();
    private ArrayList<Transaksi> daftarTransaksi = new ArrayList<>();

    public void tambahItem(ItemPerpustakaan item) {
        daftarItem.add(item);
    }

    public void tambahAnggota(Anggota anggota) {
        daftarAnggota.add(anggota);
    }

    public void tambahTransaksi(Transaksi transaksi) {
        daftarTransaksi.add(transaksi);
    }

    public void tampilkanDaftarItem() {
        for (ItemPerpustakaan item : daftarItem) {
            item.tampilkanInfo();
        }
    }

    public void tampilkanDaftarAnggota() {
        for (Anggota anggota : daftarAnggota) {
            anggota.tampilkanInfo();
        }
    }

    public void tampilkanDaftarTransaksi() {
        for (Transaksi transaksi : daftarTransaksi) {
            transaksi.detailTransaksi();
        }
    }
}
