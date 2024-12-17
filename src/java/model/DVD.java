/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.tubes;

/**
 *
 * @author Belacks
 */
public class DVD extends ItemPerpustakaan {
    private String sutradara;
    private int durasi;

    public DVD(String judul, String idItem, boolean statusDipinjam, String sutradara, int durasi) {
        super(judul, idItem, statusDipinjam);
        this.sutradara = sutradara;
        this.durasi = durasi;
    }

    @Override
    public void tampilkanInfo() {
        System.out.println("DVD: " + judul + " | Sutradara: " + sutradara + " | Durasi: " + durasi + " menit");
        System.out.println("Status: " + (statusDipinjam ? "Dipinjam" : "Tersedia"));
    }
}
