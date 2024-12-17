/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.tubes;

/**
 *
 * @author Belacks
 */
public class CD extends ItemPerpustakaan {
    private String artis;
    private int durasi;

    public CD(String judul, String idItem, boolean statusDipinjam, String artis, int durasi) {
        super(judul, idItem, statusDipinjam);
        this.artis = artis;
        this.durasi = durasi;
    }

    @Override
    public void tampilkanInfo() {
        System.out.println("CD: " + judul + " | Artis: " + artis + " | Durasi: " + durasi + " menit");
        System.out.println("Status: " + (statusDipinjam ? "Dipinjam" : "Tersedia"));
    }
}

