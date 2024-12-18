/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;
import java.util.List;

/**
 *
 * @author Belacks
 */
public class Anggota implements ManajemenPeminjaman {
    protected String nama;
    protected String idAnggota;
    
    public Anggota(String nama, String idAnggota) {
        this.nama = nama;
        this.idAnggota = idAnggota;
    }

    // Method untuk melakukan reservasi item perpustakaan
    @Override
    public void pinjamItem(ItemPerpustakaan item, long durasiPinjam, List<Peminjaman> l) {
        long unixTime = System.currentTimeMillis() / 1000L;
        if (item.isAvailable(l)) {
            item.pinjamItem(l, this, unixTime+durasiPinjam);
            System.out.println(nama + " meminjam " + item.judul + " selama " + String.valueOf(durasiPinjam/(3600*24)) +" hari");
        } else {
            System.out.println("Item tidak tersedia.");
        }
    }
    @Override
    public void kembalikanItem(ItemPerpustakaan item, List<Peminjaman> l) {
        item.batalkanPeminjaman(item.idItem, l);
        System.out.println(nama + " mengembalikan " + item.judul);
    }
    public void tampilkanInfo(){
        System.out.println("id: "+idAnggota);
        System.out.println("nama: "+nama);
    };
}
