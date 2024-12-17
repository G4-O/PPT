/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.tubes;

/**
 *
 * @author Belacks
 */
public abstract class ItemPerpustakaan {
    protected String judul;
    protected String idItem;
    protected boolean statusDipinjam = false;
    protected boolean isReserved = false; // Penanda apakah item sedang direservasi

    public ItemPerpustakaan(String judul, String idItem) {
        this.judul = judul;
        this.idItem = idItem;
    }

    // Metode untuk melakukan reservasi
    public void reservasiItem() {
        if (!statusDipinjam && !isReserved) {
            isReserved = true;
            System.out.println(judul + " telah berhasil direservasi.");
        } else {
            System.out.println("Item ini tidak dapat direservasi saat ini.");
        }
    }

    // Membatalkan reservasi
    public void batalkanReservasi() {
        if (isReserved) {
            isReserved = false;
            System.out.println(judul + " reservasi telah dibatalkan.");
        }
    }

    public abstract void tampilkanInfo();
}
