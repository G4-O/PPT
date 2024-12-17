/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.tubes;

/**
 *
 * @author Belacks
 */
public class Majalah extends ItemPerpustakaan {
    private int edisi;

    public Majalah(String judul, String idItem, int edisi) {
        super(judul, idItem);
        this.edisi = edisi;
    }

    @Override
    public void tampilkanInfo() {
        System.out.println("Majalah: " + judul + " | Edisi: " + edisi);
        System.out.println("Status: " + (statusDipinjam ? "Dipinjam" : "Tersedia"));
    }
}
