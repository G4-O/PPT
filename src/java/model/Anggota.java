/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.tubes;
import java.util.ArrayList;

/**
 *
 * @author Belacks
 */
public abstract class Anggota implements ManajemenPeminjaman {
    protected String nama;
    protected String idAnggota;
    protected ArrayList<ItemPerpustakaan> daftarPinjaman = new ArrayList<>();
    protected ArrayList<ItemPerpustakaan> daftarReservasi = new ArrayList<>(); // Daftar item yang direservasi

    public Anggota(String nama, String idAnggota) {
        this.nama = nama;
        this.idAnggota = idAnggota;
    }

    // Method untuk melakukan reservasi item perpustakaan
    public void reservasiItem(ItemPerpustakaan item) {
        if (!item.isReserved) {
            item.reservasiItem();
            daftarReservasi.add(item);
        } else {
            System.out.println("Item sudah direservasi oleh orang lain.");
        }
    }

    public void tampilkanDaftarReservasi() {
        System.out.println("Daftar Reservasi untuk " + nama + ":");
        for (ItemPerpustakaan item : daftarReservasi) {
            System.out.println("- " + item.judul);
        }
    }

    public abstract void tampilkanInfo();
}
