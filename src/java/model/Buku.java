/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.tubes;

/**
 *
 * @author Belacks
 */
public class Buku extends ItemPerpustakaan {
    private String penulis;
    private int tahunTerbit;

    public Buku(String judul, String idItem, String penulis, int tahunTerbit) {
        super(judul, idItem);
        this.penulis = penulis;
        this.tahunTerbit = tahunTerbit;
    }

    public int getTahunTerbit() {
        return tahunTerbit;
    }

    public String getPenulis() {
        return penulis;
    }

    @Override
    public void tampilkanInfo() {
        System.out.println("Buku: " + judul + " | Penulis: " + penulis + " | Tahun: " + tahunTerbit);
        System.out.println("Status: " + (statusDipinjam ? "Dipinjam" : "Tersedia"));
    }
}
